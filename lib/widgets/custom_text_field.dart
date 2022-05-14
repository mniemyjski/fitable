import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final String labelText;
  final IconData? icon;
  final ValueChanged<String>? onChange;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const CustomTextField(
      {Key? key,
      this.formKey,
      this.controller,
      this.validator,
      this.obscureText = false,
      this.labelText = '',
      this.icon,
      this.onChange,
      this.initialValue,
      this.textInputAction = TextInputAction.none,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 200, maxWidth: 450),
        child: Form(
          key: formKey,
          child: TextFormField(
            initialValue: initialValue,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: Colors.white38,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              icon: icon != null
                  ? FaIcon(
                      icon,
                      size: 40,
                      color: Colors.white,
                    )
                  : null,
            ),
            obscureText: obscureText,
            controller: controller,
            validator: validator,
            onChanged: (String txt) => onChange != null ? onChange!(txt) : null,
          ),
        ),
      ),
    );
  }
}
