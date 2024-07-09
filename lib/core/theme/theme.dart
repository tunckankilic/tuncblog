import 'package:flutter/material.dart';
import 'package:tuncblog/core/theme/color_palette.dart';

class AppTheme {
  static _border([Color color = ColorPalette.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorPalette.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        ColorPalette.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(ColorPalette.gradient2),
      errorBorder: _border(ColorPalette.errorColor),
    ),
  );
}
