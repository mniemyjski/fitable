import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double height;

  const CustomButton({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.color = Colors.white,
    this.height = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        // color: color,
        // textColor: textColor,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
