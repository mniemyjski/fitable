import 'package:fitable/models/sign_in_model.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final SignInModel model;
  final VoidCallback onPressedSubmit;
  final VoidCallback onPressedRegister;

  const EmailField({
    Key key,
    @required this.emailController,
    @required this.passwordController,
    @required this.emailFocusNode,
    @required this.passwordFocusNode,
    @required this.model,
    @required this.onPressedSubmit,
    @required this.onPressedRegister,
  }) : super(key: key);

  void _emailEditingComplete(BuildContext context) {
    final newFocus = model.emailValidator.isValid(model.email) ? passwordFocusNode : emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              focusNode: emailFocusNode,
              decoration: InputDecoration(labelText: 'Email'),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => _emailEditingComplete(context),
              onChanged: model.updateEmail,
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onEditingComplete: onPressedSubmit,
              onChanged: model.updatePassword,
            ),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.only(bottom: 8),
              child: RaisedButton(
                color: Colors.indigo,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Text(model.primaryButtonText),
                onPressed: onPressedSubmit,
              ),
            ),
            if (model.formType == EmailFormType.signIn) FlatButton(onPressed: () {}, child: Text("Forgot your password?")),
            FlatButton(
              onPressed: onPressedRegister,
              child: Text(model.secondaryButtonText),
            ),
          ],
        ),
      ),
    );
  }
}
