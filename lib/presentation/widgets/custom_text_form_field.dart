import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.readOnly,
    this.hintColor,
    this.border,
    this.obscureText,
  });

  final String? hintText;
  final bool? readOnly;
  final TextEditingController? controller;
  final Color? hintColor;
  final InputBorder? border;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor ?? Colors.grey),
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }
}
