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
      return Container(
        width: double.infinity,
        height: 48,
        margin: const EdgeInsets.only(bottom: 8),
        child: RaisedButton(
          color: Colors.white,
          textColor: Colors.black87,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
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
          onPressed: onPressed,
        ),
      );
    } else if (social == Social.facebook) {
      return Container(
        width: double.infinity,
        height: 48,
        margin: const EdgeInsets.only(bottom: 8),
        child: RaisedButton(
          color: Color(0xDD334D92),
          textColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
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
          onPressed: onPressed,
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 48,
        margin: const EdgeInsets.only(bottom: 16),
        child: RaisedButton(
          color: Colors.teal[700],
          textColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(
                Icons.mail,
                size: 40,
              ),
              Text(Constants.sign_in_with_email.tr()),
              Container(),
            ],
          ),
          onPressed: onPressed,
        ),
      );
    }
  }
}
