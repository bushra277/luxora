import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:task_flutter/core/them/them_app.dart';
import 'package:task_flutter/core/utils/responsive.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  static void screenInfo(BuildContext context) {
    _logger.i('--- Screen Info ---');
    _logger.i('Screen Width: ${context.screenWidth}');
    _logger.i('Screen Height: ${context.screenHeight}');
  }

  static void sizeInfo(BuildContext context, {double? width, double? height, double? fontSize}) {
    if (width != null) _logger.i('Responsive Width: ${context.w(width)}');
    if (height != null) _logger.i('Responsive Height: ${context.h(height)}');
    if (fontSize != null) _logger.i('Responsive FontSize: ${context.sp(fontSize)}');
  }

  static void colorsInfo() {
    _logger.i('--- Colors ---');
    _logger.i('Primary Color: ${AppTheme.primaryColor}');
    _logger.i('Secondary Color: ${AppTheme.secondaryColor}');
    _logger.i('Background Color: ${AppTheme.backgroundColor}');
    _logger.i('Text Color: ${AppTheme.textColor}');
    _logger.i('Button Text Color: ${AppTheme.buttonTextColor}');
  }

  static void buttonPressed(String buttonName) {
    _logger.i('Button Pressed: $buttonName');
  }

  static void navigateTo(String pageName) {
    _logger.d('Navigated to: $pageName');
  }

  static void warning(String message) => _logger.w(message);
  static void error(String message) => _logger.e(message);
  static void info(String message) => _logger.i(message);
}
