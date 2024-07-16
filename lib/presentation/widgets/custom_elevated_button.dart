import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_utils/device_type.dart';
import '../../common/app_utils/screen_size.dart';
import '../../common/enums/enums.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.buttonLabel,
    this.onPressed,
    this.height,
    this.width,
  });

  final void Function()? onPressed;
  final String? buttonLabel;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: getDeviceType(context) == DeviceType.Tablet ? 90 : 50,
      height: height ?? 50,
      width: width ?? ScreenSize.width(context),
      child: ElevatedButton.icon(
        style: ButtonStyle(
          enableFeedback: true,
          backgroundColor: WidgetStateProperty.all<Color>(Colors.grey[200]!),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: onPressed,
        label: Text(
          buttonLabel!,
          style: GoogleFonts.raleway(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textScaler: TextScaler.linear(
            getDeviceType(context) == DeviceType.Tablet ? 2 : 1,
          ),
        ),
      ),
    );
  }
}
