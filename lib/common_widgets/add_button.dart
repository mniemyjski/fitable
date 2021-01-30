import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: onPressed != null ? Colors.indigo : Colors.grey,
      child: Container(
        height: 48,
        width: 48,
        child: IconButton(
          color: Colors.white,
          icon: Icon(Icons.add),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
