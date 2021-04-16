import 'package:fitable/app/sign_in/view_model/sign_in_view_model.dart';
import 'package:fitable/app/sign_in/widgets/email_field.dart';
import 'package:fitable/app/sign_in/widgets/header_app.dart';
import 'package:fitable/app/sign_in/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final model = context.read(providerSignInViewModel);

    try {
      await model.signInWithGoogle();
    } on Exception catch (e) {
      model.showSignInError(context, e);
    }
  }

  void _toggleRegister() {
    final model = context.read(providerSignInViewModel);
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _toggleEmailSignIn() {
    final model = context.read(providerSignInViewModel);
    model.toggleSignInType();
  }

  Future<void> _submit() async {
    final model = context.read(providerSignInViewModel);
    try {
      await model.submit();
    } on Exception catch (e) {
      model.showSignInError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerSignInViewModel);
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: model.signInType == SignInType.email
            ? AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => _toggleEmailSignIn()))
            : null,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    headerApp(context),
                    if (model.signInType == SignInType.main) SignInButton(social: Social.google, onPressed: () => _signInWithGoogle(context)),
                    if (model.signInType == SignInType.main) SignInButton(social: Social.mail, onPressed: () => _toggleEmailSignIn()),
                    if (model.signInType == SignInType.email)
                      EmailField(
                        emailController: _emailController,
                        emailFocusNode: _emailFocusNode,
                        passwordController: _passwordController,
                        passwordFocusNode: _passwordFocusNode,
                        onPressedSubmit: () => _submit(),
                        onPressedRegister: () => _toggleRegister(),
                      ),
                  ],
                )),
          ),
        ),
      );
    });
  }
}
