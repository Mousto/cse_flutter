import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class MonTextTheme {
  static TextTheme ligthTextTheme = TextTheme(
    titleMedium:
        GoogleFonts.montserrat(color: tSudLinda, fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.poppins(color: Colors.black87),
  );
  static TextTheme darkTextTheme = TextTheme(
    titleMedium: GoogleFonts.montserrat(
        color: Colors.white70, fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.poppins(color: Colors.white60),
  );
}
