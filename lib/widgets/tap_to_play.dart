import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class TapToPlay extends StatelessWidget {
  const TapToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment(0, 0.2),
        child: Text(
          'Tap to Play'.toUpperCase(),
          style: GoogleFonts.chewy(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2387FC),
            letterSpacing: 4,
            fontSize: 38,
          ),
        ),
      )
          .animate(
            onPlay: (controller) => controller.repeat(reverse: true),
          )
          .scale(
            duration: Duration(milliseconds: 500),
            end: Offset(1.2, 1.2),
            begin: Offset(1, 1),
          ),
    );
  }
}
