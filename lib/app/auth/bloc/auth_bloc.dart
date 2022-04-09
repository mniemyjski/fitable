import 'dart:async';

import 'package:fitable/app/auth/models/auth_model.dart';
import 'package:fitable/app/auth/repositories/auth_repository.dart';
import 'package:fitable/app/failure/models/failure_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_bloc.freezed.dart';
part 'auth_bloc.g.dart';
part 'auth_event.dart';
part 'auth_state.dart';

abstract class BaseAuthBloc {
  Future<void> signUpWithEmail({required String email, required String password});
  Future<void> signInWithEmail({required String email, required String password});
  Future<void> signInWithGoogle();
  Future<void> signOut();
  Future<void> signOutAllDevices();
}

// @LazySingleton()
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> with BaseAuthBloc {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.initial(null)) {
    on<AuthCheckRequested>((event, emit) {
      if (event.auth != null) {
        emit(AuthState.authenticated(event.auth!));
      } else {
        emit(AuthState.unauthenticated());
      }
    });

    on<SignedOut>((event, emit) {
      emit(AuthState.unauthenticated());
    });

    on<DeleteAccount>((event, emit) {
      emit(AuthState.unauthenticated());
    });

    _init();
  }

  _init() {
    state.maybeWhen(
      orElse: () => add(AuthEvent.authCheckRequested(null)),
      initial: (auth) async {
        if (auth != null) {
          try {
            final Auth? rAuth = await _authRepository.getSessionById(auth.sessionId);
            add(AuthEvent.authCheckRequested(rAuth));
          } on Failure catch (failure) {
            add(AuthEvent.authCheckRequested(null));
          }
        } else {
          add(AuthEvent.authCheckRequested(null));
        }
      },
    );
  }

  @override
  Future<void> signUpWithEmail({required String email, required String password}) async {
    try {
      final Auth? auth = await _authRepository.signUpWithEmail(email: email, password: password);
      add(AuthEvent.authCheckRequested(auth));
    } on Failure catch (failure) {
      throw failure;
    }
  }

  @override
  Future<void> signInWithEmail({required String email, required String password}) async {
    try {
      final Auth? auth = await _authRepository.signInWithEmail(email: email, password: password);
      add(AuthEvent.authCheckRequested(auth));
    } on Failure catch (failure) {
      throw failure;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    // await Task(() => _authRepository.createAccount(auth)).attempt().mapLeftToFailure().run().then((value) => null);
  }
  @override
  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
      add(AuthEvent.signedOut());
    } on Failure catch (failure) {
      throw failure;
    }
  }

  @override
  Future<void> signOutAllDevices() async {
    try {
      await _authRepository.signOutAllDevices();
      add(AuthEvent.signedOut());
    } on Failure catch (failure) {
      throw failure;
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.maybeWhen(
      authenticated: (s) {
        return AuthState.initial(s).toJson();
      },
      orElse: () => AuthState.initial(null).toJson(),
    );
  }
}
