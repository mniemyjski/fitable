import 'dart:async';

import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:fitable/app/auth/models/auth_model.dart';
import 'package:fitable/app/auth/repositories/auth_repository.dart';
import 'package:fitable/app/failure/models/failure_model.dart';
import 'package:fitable/utilities/extensions.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';
part 'auth_bloc.g.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.initial(null)) {
    _init();
  }

  void _init() {
    state.maybeWhen(
      orElse: () => add(AuthEvent.authCheckRequested(null)),
      initial: (id) {
        if (id != null) {
          Task(() async => await _authRepository.getSessionById(id))
              .attempt()
              .mapLeftToFailure()
              .run()
              .then(
                (value) => value.fold(
                  (failure) {
                    add(AuthEvent.authCheckRequested(null));
                  },
                  (auth) {
                    add(AuthEvent.authCheckRequested(id));
                  },
                ),
              );
        } else {
          add(AuthEvent.authCheckRequested(null));
        }
      },
    );
  }

  Future<Failure?> signUpWithEmail(Auth auth) async {
    return await Task(() async => await _authRepository.signUpWithEmail(auth))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then(
          (value) => value.fold(
            (failure) => failure,
            (auth) {
              add(AuthEvent.authCheckRequested(auth));
            },
          ),
        );
  }

  Future<Failure?> signInWithEmail(Auth auth) async {
    return await Task(() async => await _authRepository.signInWithEmail(auth))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then(
          (value) => value.fold(
            (failure) => failure,
            (auth) {
              add(AuthEvent.authCheckRequested(auth));
            },
          ),
        );
  }

  deleteAccount() {
    add(AuthEvent.deleteAccount());
  }

  updatePreference() {
    _authRepository.updatePref();
  }

  signInWithGoogle(Auth auth) async {
    // await Task(() => _authRepository.createAccount(auth)).attempt().mapLeftToFailure().run().then((value) => null);
  }

  signOut() async {
    state.maybeWhen(
      orElse: () => add(AuthEvent.authCheckRequested(null)),
      authenticated: (id) async =>
          await Task(() async => await _authRepository.signOut(id))
              .attempt()
              .mapLeftToFailure()
              .run()
              .then(
                (value) => value.fold(
                  (failure) => failure,
                  (auth) {
                    add(AuthEvent.signedOut());
                  },
                ),
              ),
    );
  }

  signOutAllDevices() async {
    state.maybeWhen(
      orElse: () => add(AuthEvent.authCheckRequested(null)),
      authenticated: (id) async =>
          await Task(() async => await _authRepository.signOutAllDevices())
              .attempt()
              .mapLeftToFailure()
              .run()
              .then(
                (value) => value.fold(
                  (failure) => failure,
                  (auth) {
                    add(AuthEvent.signedOut());
                  },
                ),
              ),
    );
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthCheckRequested) {
      yield* _mapAuthUserChangedToState(event);
    } else if (event is SignedOut) {
      yield* _mapAuthUserChangedToState(null);
    } else if (event is DeleteAccount) {
      await _authRepository.deleteAccount();
      yield* _mapAuthUserChangedToState(null);
    }
  }

  Stream<AuthState> _mapAuthUserChangedToState(
      AuthCheckRequested? event) async* {
    if (event?.sessionId != null) {
      if (state != Authenticated) {
        yield AuthState.authenticated(event!.sessionId!);
      }
    } else {
      if (state != Unauthenticated) {
        yield AuthState.unauthenticated();
      }
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.maybeWhen(
      authenticated: (s) => AuthState.initial(s).toJson(),
      orElse: () => AuthState.initial(null).toJson(),
    );
  }
}
