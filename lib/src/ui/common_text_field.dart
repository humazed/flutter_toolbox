import 'package:flutter/material.dart';
import 'package:flutter_toolbox/generated/i18n.dart';

class CommonTextField extends StatelessWidget {
  final String hint;
  final String label;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final bool obscureText;
  final TextEditingController controller;
  final Icon suffixIcon;
  final TextInputType keyboardType;
  final int maxLines;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          validator: validator,
          onSaved: onSaved,
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          initialValue: initialValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: hint,
            labelText: label,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }

  CommonTextField({
    this.hint,
    this.label,
    this.validator,
    this.onSaved,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.initialValue,
  });
}

class RequiredTextField extends StatelessWidget {
  final String hint;
  final String label;
  final FormFieldSetter<String> onSaved;
  final String missingMessage;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String initialValue;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      hint: hint,
      label: label,
      onSaved: onSaved,
      validator: (value) =>
          value.isEmpty ? missingMessage ?? S.of(context).required_field : null,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      initialValue: initialValue,
      maxLines: maxLines,
    );
  }

  RequiredTextField({
    this.hint,
    this.label,
    this.onSaved,
    this.missingMessage,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.initialValue,
    this.maxLines = 1,
  });
}
