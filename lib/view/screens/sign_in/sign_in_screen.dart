import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitable/services/auth.dart';
import 'package:fitable/view/Screens/sign_in/widgets/sign_in_button.dart';
import 'package:fitable/view/screens/sign_in/widgets/email_field.dart';
import 'package:fitable/view/widgets/show_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'widgets/header_app.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  bool _isLoading = false;
  bool _emailSignIn = false;
  bool _register = false;

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException && exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    print(exception);
    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);

      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _toggleRegister() {
    setState(() {
      _register ? _register = false : _register = true;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _toggleEmailSignIn() {
    setState(() {
      if (_emailSignIn) {
        _emailSignIn = false;
        _register = false;
        _emailController.clear();
        _passwordController.clear();
      } else {
        _emailSignIn = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                headerApp(context),
                if (!_emailSignIn) SignInButton(social: Social.google, onPressed: () => signInWithGoogle(context)),
                if (!_emailSignIn) SignInButton(social: Social.mail, onPressed: () => _toggleEmailSignIn()),
                if (_emailSignIn)
                  EmailField(
                    register: _register,
                    emailController: _emailController,
                    emailFocusNode: _emailFocusNode,
                    passwordController: _passwordController,
                    passwordFocusNode: _passwordFocusNode,
                    onPressed: () => _toggleRegister(),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _emailSignIn
          ? BottomAppBar(
              color: Colors.indigo,
              child: Container(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FaIcon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                    FlatButton(
                        onPressed: () => _toggleEmailSignIn(),
                        child: Text(
                          "Back to other sign in",
                          style: TextStyle(color: Colors.white),
                        )),
                    Container()
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
