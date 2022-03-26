import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../auth/models/auth_model.dart';
import '../../failure/models/failure_model.dart';
import '../models/account_model.dart';
import '../repositories/account_repository.dart';

part 'my_account_state.dart';
part 'my_account_cubit.freezed.dart';
part 'my_account_cubit.g.dart';

abstract class BaseMyAccountCubit {
  Future<void> create(String name);
  Future<void> update(Account account);
  Future<void> delete(Account account);
  Future<Either<Failure, Account?>> getAccount();
}

class MyAccountCubit extends Cubit<MyAccountState> with BaseMyAccountCubit {
  final AccountRepository _accountRepository;
  final AuthBloc _authBloc;
  late StreamSubscription<Account?> _accountSubscription;
  late StreamSubscription<AuthState> _authSubscription;

  MyAccountCubit({required accountRepository, required authBloc})
      : _accountRepository = accountRepository,
        _authBloc = authBloc,
        super(MyAccountState.initial()) {
    _init();
  }

  _init() {
    if (_authBloc.state is Authenticated) {
      _authentication();
    }

    try {
      _authSubscription.cancel();
    } catch (e) {}

    _authSubscription = _authBloc.stream.listen((event) {
      event.maybeWhen(
        authenticated: (_) => _authentication(),
        orElse: () {
          try {
            _accountSubscription.cancel();
          } catch (e) {}
          if (state is! Initial) emit(MyAccountState.initial());
        },
      );
    });
  }

  void _authentication() async {
    await getAccount()
      ..fold((f) {
        if (state is! UnCreated) emit(MyAccountState.unCreated());
      }, (account) {
        emit(MyAccountState.created(account));
      });

    try {
      await _accountSubscription.cancel();
    } catch (e) {}

    _authBloc.state.maybeWhen(
      orElse: () => emit(MyAccountState.initial()),
      initial: (auth) async {
        if (auth != null) _subStream(auth);
      },
      authenticated: (auth) => _subStream(auth),
    );
  }

  _subStream(Auth auth) {
    _accountSubscription = _accountRepository.stream(auth).listen((account) {
      if (account != null) {
        emit(MyAccountState.created(account));
      } else {
        emit(MyAccountState.unCreated());
      }
    });
  }

  @override
  Future<void> close() {
    try {
      _authSubscription.cancel();
    } catch (e) {}
    try {
      _accountSubscription.cancel();
    } catch (e) {}
    return super.close();
  }

  @override
  Future<void> create(String name) async {
    _authBloc.state.maybeWhen(
      orElse: () => throw 'Auth failed',
      initial: (auth) async =>
          auth != null ? await _accountRepository.create(auth: auth, name: name) : throw 'Auth failed',
      authenticated: (auth) => _accountRepository.create(auth: auth, name: name),
    );
  }

  @override
  Future<void> update(Account account) async {
    _authBloc.state.maybeWhen(
      orElse: () => throw 'Auth failed',
      initial: (auth) async => auth != null ? await _accountRepository.update(account) : throw 'Auth failed',
      authenticated: (auth) => _accountRepository.update(account),
    );
  }

  @override
  Future<void> delete(Account account) async {}

  updateAvatar(File file) {
    state.whenOrNull(created: (account) => _accountRepository.updateAvatar(id: account.id, file: file));
  }

  @override
  Future<Either<Failure, Account>> getAccount() async {
    return _authBloc.state.maybeWhen(
      orElse: () => left(throw 'Auth failed'),
      initial: (auth) async => auth != null ? await _get(auth) : left(throw 'Auth failed'),
      authenticated: (auth) => _get(auth),
    );
  }

  Future<Either<Failure, Account>> _get(Auth auth) async {
    return await Task(() => _accountRepository.get(auth)).attempt().mapLeftToFailure().run().then(
          (value) => value.fold(
            (f) => left(f),
            (account) => right(account),
          ),
        );
  }
}
