import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
}

extension ResponsiveExtension on BuildContext {
  double percentageOfWidth(int percentage) {
    return MediaQuery.sizeOf(this).width * percentage / 100;
  }

  double percentageOfHeight(int percentage) {
    return MediaQuery.sizeOf(this).height * percentage / 100;
  }
}
