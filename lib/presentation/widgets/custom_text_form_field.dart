import 'package:flutter/material.dart';

import '../../common/app_utils/device_type.dart';
import '../../common/app_utils/screen_size.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.readOnly,
    this.hintColor,
    this.border,
    this.obscureText,
    this.validator,
    this.onEditingComplete,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    this.maxLines,
  });

  final String? hintText;
  final bool? readOnly;
  final TextEditingController? controller;
  final Color? hintColor;
  final InputBorder? border;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Function()? onEditingComplete;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getDeviceType(context) == DeviceType.Tablet ? 70 : 60,
      width: ScreenSize.width(context) / ScaleSize.textScaleFactor(context),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        validator: validator,
        onEditingComplete: onEditingComplete,
        textInputAction: textInputAction,
        maxLength: maxLength,
        maxLines: maxLines,
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
          hintStyle: TextStyle(color: hintColor ?? Colors.grey, fontSize: 14 * ScaleSize.textScaleFactor(context)),
          fillColor: Colors.grey[200],
          filled: true,
        ),
        style: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
      ),
    );
  }
}
