// ignore_for_file: constant_identifier_names

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

enum DeviceType {
  Mobile,
  Tablet,
  Desktop,
}

DeviceType getDeviceType(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  final double devicePixelRatio = ui.PlatformDispatcher.instance.implicitView!.devicePixelRatio;
  if (devicePixelRatio == 2 && (screenWidth >= 1000 || screenHeight >= 1000)) {
    return DeviceType.Tablet;
  } else if ((screenWidth <= 1000 || screenHeight <= 1000)) {
    return DeviceType.Mobile;
  } else {
    return DeviceType.Desktop;
  }
}
