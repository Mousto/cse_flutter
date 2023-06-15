import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class TOulinedButtonTheme {
  TOulinedButtonTheme._(); //Constructeur privé pour éviter la creation d'une instance à l'extérieur.

  // Ligth theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      //shape: const RoundedRectangleBorder(),
      foregroundColor: tSecondaryColor,
      side: const BorderSide(color: tSudLinda),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
    ),
  );

  // Dark theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: tWhiteColor,
      side: const BorderSide(color: tWhiteColor),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
    ),
  );
}
