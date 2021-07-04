import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final bool isFilled;
  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFF30169D),
    this.isFilled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(),
      style: OutlinedButton.styleFrom(
        primary: color,
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: GoogleFonts.montserratAlternates(fontSize: 17),
        ),
      ),
    );
  }
}
