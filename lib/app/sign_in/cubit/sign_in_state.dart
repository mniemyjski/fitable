part of 'sign_in_cubit.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.sign_in() = SignIn;
  const factory SignInState.sign_up() = SignUp;
  const factory SignInState.reset() = Reset;
}
