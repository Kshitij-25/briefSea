import 'package:flutter/material.dart';

import '../../common/app_utils/device_type.dart';
import '../../common/app_utils/screen_size.dart';

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
      height: height != null
          ? height
          : getDeviceType(context) == DeviceType.Tablet
              ? 70
              : 50,
      width: width ?? ScreenSize.width(context) / ScaleSize.textScaleFactor(context),
      child: ElevatedButton.icon(
        style: ButtonStyle(
          enableFeedback: true,
          backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
        label: Text(
          buttonLabel!,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
          textScaler: TextScaler.linear(
            ScaleSize.textScaleFactor(context),
          ),
        ),
      ),
    );
  }
}
