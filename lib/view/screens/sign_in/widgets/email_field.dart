import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final bool register;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final VoidCallback onPressed;

  const EmailField({
    Key key,
    this.register,
    this.emailController,
    this.passwordController,
    this.emailFocusNode,
    this.passwordFocusNode,
    this.onPressed,
  }) : super(key: key);

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
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              textInputAction: TextInputAction.done,
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
                child: !register ? Text("Sign in") : Text("Create an account"),
                onPressed: () {},
              ),
            ),
            if (!register) FlatButton(onPressed: () {}, child: Text("Forgot your password?")),
            FlatButton(onPressed: onPressed, child: !register ? Text("Need an account? Register") : Text("Have an account? Sign in")),
          ],
        ),
      ),
    );
  }
}
