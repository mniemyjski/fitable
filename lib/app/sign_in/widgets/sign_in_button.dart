import 'package:fitable/common_widgets/custom_button.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              Text(
                Languages.sign_in_with_google(),
                style: TextStyle(color: Colors.black87),
              ),
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
              Text(Languages.sign_in_with_facebook()),
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
              Text(Languages.sign_in_with_email()),
              Container(),
            ],
          ),
          color: Colors.teal[700],
          onPressed: onPressed);
    }
  }
}
