import 'package:flutter/material.dart';

import '../../common/app_utils/screen_size.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.readOnly = false,
    this.hintColor,
    this.border,
    this.obscureText = false,
    this.autofillHints,
    this.validator,
    this.onEditingComplete,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    this.maxLines = 1,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.enabled = true,
    this.focusNode,
    this.cursorColor,
    this.style,
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final bool readOnly;
  final Color? hintColor;
  final InputBorder? border;
  final bool obscureText;
  final Iterable<String>? autofillHints;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final bool autofocus;
  final bool enabled;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize.width(context) / ScaleSize.textScaleFactor(context),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        obscureText: obscureText,
        validator: validator,
        onEditingComplete: onEditingComplete,
        textInputAction: textInputAction,
        autofillHints: autofillHints,
        maxLength: maxLength,
        maxLines: maxLines,
        onTap: onTap,
        autofocus: autofocus,
        enabled: enabled,
        focusNode: focusNode,
        cursorColor: cursorColor,
        textAlign: textAlign,
        style: style ??
            Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontSize: 14 * ScaleSize.textScaleFactor(context),
                ),
        decoration: InputDecoration(
          isDense: true,
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black),
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
          hintStyle: TextStyle(color: hintColor ?? Colors.grey, fontSize: 14 * ScaleSize.textScaleFactor(context)),
          fillColor: Theme.of(context).colorScheme.surfaceContainer,
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
