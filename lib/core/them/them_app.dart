import 'package:flutter/material.dart';
import 'package:task_flutter/core/utils/responsive.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(255, 0, 135, 217); 
  static const Color secondaryColor = Color(0xFF218621); 
  static const Color backgroundColor = Colors.white; 
  static const Color textColor = Color(0xFF353434); 
  static const Color buttonTextColor = Colors.white; 


  static TextTheme textTheme(BuildContext context) {
  return TextTheme(
    displayLarge: TextStyle(fontSize: context.sp(60), fontWeight: FontWeight.bold, color: textColor),
    displayMedium: TextStyle(fontSize: context.sp(50), fontWeight: FontWeight.bold, color: textColor),
    bodyLarge: TextStyle(fontSize: context.sp(45), color: textColor),
    bodyMedium: TextStyle(fontSize: context.sp(40), color: textColor),
    labelLarge: TextStyle(fontSize: context.sp(45), fontWeight: FontWeight.bold, color: buttonTextColor),
  );
}


  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: textTheme(context),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: context.sp(60),
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: buttonTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.w(15)),
          ),
          textStyle: TextStyle(
            fontSize: context.sp(45),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: context.h(20),
          horizontal: context.w(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w(15)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
