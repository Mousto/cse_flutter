import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonTextTheme {
  static TextTheme ligthTextTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(
      color: Colors.black87,
    ),
    headlineSmall: GoogleFonts.poppins(
      color: Colors.black54,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(
      color: Colors.white70,
    ),
    headlineSmall: GoogleFonts.poppins(
      color: Colors.white60,
    ),
  );
}
