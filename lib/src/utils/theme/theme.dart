import 'package:flutter/material.dart';

import 'widget_themes/outlined_button_theme.dart';
import 'widget_themes/text_theme.dart';
import 'widget_themes/elevated_button_theme.dart';

class MonAppTheme {
  MonAppTheme._(); //Permet de créer un constructeur privé inaccessible de l'extérieur.

  static ThemeData ligthTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.purple,
    textTheme: MonTextTheme.ligthTextTheme,
    outlinedButtonTheme: TOulinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: MonTextTheme.darkTextTheme,
    outlinedButtonTheme: TOulinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
