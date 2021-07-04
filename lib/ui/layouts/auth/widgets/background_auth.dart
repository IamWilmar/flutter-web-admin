import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class BackgroundAuth extends StatelessWidget {
  final isMobile;
  const BackgroundAuth({Key? key, this.isMobile = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      decoration: backgroundAuthDecoration(),
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: math.pi * 30 / 180,
                    child: Icon(
                      Icons.mark_email_unread_outlined,
                      color: Colors.white,
                      size: 200,
                    ),
                  ),
                  Text(
                    'Meet People around the world!',
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 60,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Join to one of the most exciting communities and get to know\nwhat the world has to offer you',
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration backgroundAuthDecoration() {
    return BoxDecoration(
      color: Color(0xFF30169D),
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
        topLeft: isMobile ? Radius.circular(20.0) : Radius.zero,
        bottomLeft: isMobile ? Radius.circular(20.0) : Radius.zero,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          blurRadius: 10,
          color: Colors.black,
          offset: Offset(1.0, 1.0),
        ),
      ],
    );
  }
}
