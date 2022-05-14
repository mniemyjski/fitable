import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class TextFieldWithTitle extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final FormFieldValidator<String>? validator;
  final String title;
  final ValueChanged<String>? onChange;
  final String? initialValue;
  final EdgeInsetsGeometry? padding;

  const TextFieldWithTitle({
    Key? key,
    required this.formKey,
    required this.validator,
    required this.title,
    required this.onChange,
    required this.initialValue,
    this.padding,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.only(left: 8, top: 4),
          child: Text('$title:', style: Theme.of(context).textTheme.bodyText2),
        ),
        CustomTextField(
          formKey: formKey,
          labelText: '',
          onChange: onChange,
          validator: validator,
          initialValue: initialValue,
        ),
      ],
    );
  }
}
