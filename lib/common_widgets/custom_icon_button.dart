import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color buttonColorDisable;
  final Color iconColor;
  final IconData icon;

  const CustomIconButton({
    Key key,
    this.onPressed,
    this.iconColor = Colors.white,
    this.buttonColor = Colors.indigo,
    this.buttonColorDisable = Colors.grey,
    this.icon = Icons.add,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: onPressed != null ? buttonColor : buttonColorDisable,
      child: Container(
        height: 48,
        width: 48,
        child: IconButton(
          color: iconColor,
          icon: Icon(icon),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
