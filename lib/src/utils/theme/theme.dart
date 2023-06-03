import 'package:cse_talant_valmy/src/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonAppTheme {
  static ThemeData ligthTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.purple,
    fontFamily: GoogleFonts.openSans().fontFamily, //'Raleway',
    textTheme: MonTextTheme.ligthTextTheme,
    // ThemeData.light().textTheme.copyWith(
    //       bodyLarge: const TextStyle(
    //         color: Color.fromRGBO(20, 51, 51, 1),
    //       ),
    //       bodyMedium: const TextStyle(
    //         color: Color.fromRGBO(20, 51, 51, 1),
    //       ),
    //       titleLarge: const TextStyle(
    //         fontFamily: 'RobotoCondensed',
    //         fontSize: 20,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
        .copyWith(secondary: Colors.deepOrange),
  );
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark, textTheme: MonTextTheme.darkTextTheme);
}
