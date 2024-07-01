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
    this.validator,
    this.onEditingComplete,
  });

  final String? hintText;
  final bool? readOnly;
  final TextEditingController? controller;
  final Color? hintColor;
  final InputBorder? border;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      validator: validator,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor ?? Colors.grey),
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }
}
