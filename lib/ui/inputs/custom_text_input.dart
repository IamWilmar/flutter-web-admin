import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextInput {
  static InputDecoration inputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Color(0xFF30169D).withOpacity(0.6)),
      labelStyle: TextStyle(color: Color(0xFF30169D).withOpacity(0.5)),
      hintStyle: TextStyle(color: Color(0xFF30169D).withOpacity(0.5)),
      border:
          OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF30169D))),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF30169D).withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF30169D)),
      ),
    );
  }

  static InputDecoration searchInputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
      hintStyle: GoogleFonts.montserratAlternates(),
      prefixIcon: Icon(icon),
      enabledBorder: InputBorder.none,
      border: InputBorder.none,
      hintText: hint,
    );
  }

  static InputDecoration formInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Color(0xFF30169D).withOpacity(0.6)),
      labelStyle: TextStyle(color: Color(0xFF30169D).withOpacity(0.5)),
      hintStyle: TextStyle(color: Color(0xFF30169D).withOpacity(0.5)),
      border:
          OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF30169D))),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF30169D).withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF30169D)),
      ),
    );
  }
}
