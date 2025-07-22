import 'dart:math';

import 'package:flutter/material.dart';

class ScreenSize {
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static double width(BuildContext context) => MediaQuery.of(context).size.width;
}

class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
