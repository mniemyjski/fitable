import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/app/auth/models/auth_model.dart';
import 'package:fitable/app/failure/models/failure_model.dart';
import 'package:fitable/widgets/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

  sign({required String email, required String password}) async {
    await state.when(
      sign_in: () async {
        try {
          await _authBloc.signInWithEmail(email: email, password: password);
        } on Failure catch (f) {
          if (f.massage != null) customFlashBar(f.massage!);
        }
      },
      sign_up: () async {
        try {
          await _authBloc.signUpWithEmail(email: email, password: password);
        } on Failure catch (f) {
          if (f.massage != null) customFlashBar(f.massage!);
        }
      },
      reset: () => null,
    );
  }
}
