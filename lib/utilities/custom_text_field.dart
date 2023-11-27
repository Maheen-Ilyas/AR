import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final String hintText;
  final TextInputType type;
  final bool enableSuggestions;
  final bool obscureText;
  const CustomTextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.type,
    required this.enableSuggestions,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: false,
      enableSuggestions: enableSuggestions,
      keyboardType: type,
      decoration: InputDecoration(
        icon: icon,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
