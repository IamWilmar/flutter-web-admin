import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final bool isFilled;
  const CustomPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFF30169D),
    this.isFilled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF30169D),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: GoogleFonts.montserratAlternates(fontSize: 17),
        ),
      ),
    );
  }
}
