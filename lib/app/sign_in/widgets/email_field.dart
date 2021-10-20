import 'package:fitable/app/sign_in/view_model/sign_in_view_model.dart';
import 'package:fitable/common_widgets/custom_button.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailField extends ConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final VoidCallback onPressedSubmit;
  final VoidCallback onPressedRegister;

  const EmailField({
    Key key,
    @required this.emailController,
    @required this.passwordController,
    @required this.emailFocusNode,
    @required this.passwordFocusNode,
    @required this.onPressedSubmit,
    @required this.onPressedRegister,
  }) : super(key: key);

  void _emailEditingComplete(BuildContext context) {
    final model = context.read(providerSignInViewModel);
    final newFocus = model.emailValidator.isValid(model.email) ? passwordFocusNode : emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final model = watch(providerSignInViewModel);

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              focusNode: emailFocusNode,
              decoration: InputDecoration(labelText: Languages.email()),
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
              decoration: InputDecoration(labelText: Languages.password()),
              obscureText: true,
              textInputAction: TextInputAction.done,
              onEditingComplete: onPressedSubmit,
              onChanged: model.updatePassword,
            ),
            SizedBox(height: 8.0),
            CustomButton(
              child: Text(model.primaryButtonText),
              color: Colors.indigo,
              onPressed: onPressedSubmit,
            ),
            if (model.formType == EmailFormType.signIn) TextButton(onPressed: () {}, child: Text(Languages.forgot_your_password())),
            TextButton(
              onPressed: onPressedRegister,
              child: Text(model.secondaryButtonText),
            ),
          ],
        ),
      ),
    );
  }
}
