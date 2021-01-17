import 'package:fitable/common_widgets/custom_button.dart';
import 'package:fitable/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

enum Social { google, facebook, mail }

class SignInButton extends StatelessWidget {
  final Social social;
  final VoidCallback onPressed;
  const SignInButton({Key key, @required this.social, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (social == Social.google) {
      return CustomButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Image.asset("resources/images/google-logo.png"),
              ),
              Text(Constants.sign_in_with_google.tr()),
              Container(),
            ],
          ),
          onPressed: onPressed);
    } else if (social == Social.facebook) {
      return CustomButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Image.asset("resources/images/facebook-logo.png"),
              ),
              Text(Constants.sign_in_with_facebook.tr()),
              Container(),
            ],
          ),
          onPressed: onPressed);
    } else {
      return CustomButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(
                Icons.mail,
                size: 40,
                color: Colors.white,
              ),
              Text(Constants.sign_in_with_email.tr()),
              Container(),
            ],
          ),
          textColor: Colors.white,
          color: Colors.teal[700],
          onPressed: onPressed);
    }
  }
}
