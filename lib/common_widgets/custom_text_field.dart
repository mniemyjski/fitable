import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String suffix;
  final String hintText;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction;
  final bool autocorrect;

  const CustomTextField(
      {Key key,
      @required this.onChanged,
      this.name,
      this.suffix,
      this.hintText,
      this.autocorrect = true,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done})
      : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
      child: Card(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: name,
            suffix: suffix != null ? Text(suffix) : null,
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(left: 5, right: 5),
          ),
          autocorrect: autocorrect,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
