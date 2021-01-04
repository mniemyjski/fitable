import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitable/models/sign_in_model.dart';
import 'package:fitable/services/auth.dart';
import 'package:fitable/view/Screens/sign_in/widgets/sign_in_button.dart';
import 'package:fitable/view/screens/sign_in/widgets/email_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'widgets/header_app.dart';

class SignInScreen extends StatefulWidget {
  static const route = '/SignInScreen';

  final SignInModel model;
  const SignInScreen({Key key, this.model}) : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(auth: auth),
      child: Consumer<SignInModel>(
        builder: (_, model, __) => SignInScreen(model: model),
      ),
    );
  }

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  SignInModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await model.signInWithGoogle();
    } on Exception catch (e) {
      model.showSignInError(context, e);
    }
  }

  void _toggleRegister() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _toggleEmailSignIn() {
    model.toggleSignInType();
  }

  Future<void> _submit() async {
    try {
      await widget.model.submit();
    } on FirebaseAuthException catch (e) {
      model.showSignInError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: model.signInType == SignInType.email
          ? AppBar(
              actions: [
                IconButton(
                  icon: FaIcon(
                    Icons.cancel_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () => _toggleEmailSignIn(),
                )
              ],
            )
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
                    model: model,
                    emailController: _emailController,
                    emailFocusNode: _emailFocusNode,
                    passwordController: _passwordController,
                    passwordFocusNode: _passwordFocusNode,
                    onPressedSubmit: () => _submit(),
                    onPressedRegister: () => _toggleRegister(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
