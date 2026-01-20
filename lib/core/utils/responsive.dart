import 'package:flutter/material.dart';

const double baseWidth = 1080;
const double baseHeight = 2408;

extension Responsive on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double w(double width) => (width / baseWidth) * screenWidth;

  double h(double height) => (height / baseHeight) * screenHeight;

  double sp(double fontSize) => (fontSize / baseWidth) * screenWidth;
}
