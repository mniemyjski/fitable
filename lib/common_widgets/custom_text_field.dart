import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final Color textColor;
  final String suffix;
  final String hintText;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction;
  final bool autocorrect;
  final bool enabled;
  final TextEditingController controller;
  final String initialValue;
  final int maxLines;
  final int minLines;

  const CustomTextField(
      {Key key,
      this.onChanged,
      this.name,
      this.textColor = Colors.black87,
      this.suffix,
      this.hintText,
      this.controller,
      this.initialValue,
      this.autocorrect = true,
      this.enabled = true,
      this.maxLines = 1,
      this.minLines,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done})
      : super(key: key);

  TextStyle textStyle() {
    if (textColor != null && textColor != Colors.black87) {
      return TextStyle(color: textColor, fontWeight: FontWeight.bold);
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
      child: Card(
        child: TextFormField(
          style: textStyle(),
          maxLines: maxLines,
          minLines: minLines,
          decoration: InputDecoration(
            labelText: name,
            suffix: suffix != null ? Text(suffix) : null,
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(left: 5, right: 5),
          ),
          controller: controller,
          initialValue: initialValue,
          enabled: enabled,
          autocorrect: autocorrect,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
