import 'package:flutter/material.dart';

class ScreenSize {
  static double height(context) => MediaQuery.of(context).size.height;

  static double width(context) => MediaQuery.of(context).size.width;
}
