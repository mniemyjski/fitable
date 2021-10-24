import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/app/auth/models/auth_model.dart';
import 'package:fitable/app/failure/models/failure_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';
part 'sign_in_cubit.freezed.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthBloc _authBloc;
  SignInCubit({required AuthBloc authBloc})
      : _authBloc = authBloc,
        super(SignInState.sign_in());

  changeFormSignIn() {
    emit(SignInState.sign_in());
  }

  changeFormSignUp() {
    emit(SignInState.sign_up());
  }

  changeFormReset() {
    emit(SignInState.reset());
  }

  Future<Failure?> sign({required String name, required String email, required String password}) async {
    Auth auth = Auth(
      name: name,
      email: email,
      password: password,
    );

    return await state.when(
      sign_in: () async {
        return await _authBloc.signInWithEmail(auth);
      },
      sign_up: () async {
        return await _authBloc.signUpWithEmail(auth);
      },
      reset: () => null,
    );
  }
}
