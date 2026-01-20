import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Widget? label;

  const CustomTextField({
    Key? key,
    this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        label: label,
        hintText: hint,
        hintStyle: TextStyle(fontSize: context.sp(34)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.w(30),
          vertical: context.h(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w(15)),
        ),
      ),
      style: TextStyle(fontSize: context.sp(40)),
    );
  }
}
