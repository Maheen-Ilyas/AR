import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final TextInputType type;
  final bool enableSuggestions;
  final bool obscureText;
  final String labelText;
  const CustomTextField({
    super.key,
    required this.icon,
    required this.type,
    required this.enableSuggestions,
    required this.controller,
    required this.obscureText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: false,
      enableSuggestions: enableSuggestions,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.lato().toString(),
        ),
        icon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
