import 'package:cse_talant_valmy/src/constants/colors.dart';
import 'package:flutter/material.dart';

class TTextFormField {
  TTextFormField._(); //Constructeur privé

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: tSudLinda,
    floatingLabelStyle: TextStyle(color: tSudLinda),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: tSudLinda),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: tSignUpDarkFieldColor,
    floatingLabelStyle: TextStyle(color: tSignUpDarkFieldColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: tSignUpDarkFieldColor),
    ),
  );
}
