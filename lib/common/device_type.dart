import 'package:flutter/material.dart';

import 'enums.dart';

DeviceType getDeviceType(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < 600) {
    return DeviceType.Mobile;
  } else if (screenWidth >= 600 && screenWidth < 1025) {
    return DeviceType.Tablet;
  } else {
    return DeviceType.Desktop;
  }
}
