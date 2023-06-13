//Ligth and dark Elevated Button theme

import 'package:cse_talant_valmy/src/constants/colors.dart';
import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //Constructeur privé pour éviter la creation d'une instance à l'extérieur.

  // Ligth theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 10,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      //shape: const RoundedRectangleBorder(),
      //side: const BorderSide(color: tSudLinda),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
    ),
  );
  // Dark theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 10,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      foregroundColor: tSecondaryColor,
      backgroundColor: tWhiteColor,
      shape: const RoundedRectangleBorder(),
      side: const BorderSide(color: tSudLinda),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
    ),
  );
}
