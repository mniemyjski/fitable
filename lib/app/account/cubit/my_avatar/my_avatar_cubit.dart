import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:fitable/app/account/repositories/avatar_repository.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:universal_io/io.dart';

part 'my_avatar_cubit.freezed.dart';
part 'my_avatar_cubit.g.dart';
part 'my_avatar_state.dart';

abstract class BaseMyAvatarCubit {
  Future update(File file);

  Future delete();
}

class MyAvatarCubit extends Cubit<MyAvatarState> with BaseMyAvatarCubit {
  final AuthBloc _authBloc;
  final AvatarRepository _avatarRepository;
  late StreamSubscription _avatarSubscription;
  late StreamSubscription<AuthState> _authSubscription;

  MyAvatarCubit({required avatarRepository, required authBloc})
      : _avatarRepository = avatarRepository,
        _authBloc = authBloc,
        super(MyAvatarState.initial()) {
    _init();
  }

  _init() {
    _authBloc.state.whenOrNull(authenticated: (auth) => _authenticated(auth.userId));

    try {
      _authSubscription.cancel();
    } catch (e) {}

    _authSubscription = _authBloc.stream.listen((event) {
      event.maybeWhen(
        authenticated: (auth) => _authenticated(auth.userId),
        orElse: () {
          try {
            _avatarSubscription.cancel();
          } catch (e) {}
          if (state is! Initial) emit(MyAvatarState.initial());
        },
      );
    });
  }

  _authenticated(String id) async {
    final result = await _avatarRepository.get(id);
    emit(MyAvatarState.loaded(result));

    _avatarSubscription = _avatarRepository.stream(id).listen((_) async {
      final result = await _avatarRepository.get(id);
      emit(MyAvatarState.loaded(result));
    });
  }

  @override
  Future delete() async {
    _authBloc.state.whenOrNull(authenticated: (auth) => _avatarRepository.delete(auth.userId));
  }

  @override
  Future update(File file) async {
    await _authBloc.state
        .whenOrNull(authenticated: (auth) => _avatarRepository.update(id: auth.userId, file: file));
  }
}
