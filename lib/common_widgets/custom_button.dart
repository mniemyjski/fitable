import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const CustomButton({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.color = Colors.white,
    this.textColor = Colors.black87,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(bottom: 8),
      child: RaisedButton(
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
