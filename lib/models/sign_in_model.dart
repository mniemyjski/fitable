import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitable/services/auth.dart';
import 'package:fitable/view/screens/sign_in/validators.dart';
import 'package:fitable/view/widgets/show_exception_alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum EmailFormType { signIn, register }
enum SignInType { main, email }

class SignInModel with EmailAndPasswordValidators, ChangeNotifier {
  SignInModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.formType = EmailFormType.signIn,
    this.signInType = SignInType.main,
    this.isLoading = false,
    this.submitted = false,
  });
  final AuthBase auth;
  String email;
  String password;
  EmailFormType formType;
  SignInType signInType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException && exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      updateWith(isLoading: true);
      return await signInMethod();
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

  String get primaryButtonText {
    return formType == EmailFormType.signIn ? 'Sign in' : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailFormType.signIn ? 'Need an account? Register' : 'Have an account? Sign in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) && passwordValidator.isValid(password) && !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  void toggleFormType() {
    final formType = this.formType == EmailFormType.signIn ? EmailFormType.register : EmailFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      signInType: signInType,
      isLoading: false,
      submitted: false,
    );
  }

  void toggleSignInType() {
    final signInType = this.signInType == SignInType.main ? SignInType.email : SignInType.main;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      signInType: signInType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String email,
    String password,
    EmailFormType formType,
    SignInType signInType,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.signInType = signInType ?? this.signInType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
