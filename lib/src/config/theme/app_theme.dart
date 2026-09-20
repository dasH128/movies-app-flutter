import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final bool isDarkMode;
  final Color colorTheme;

  AppTheme({
    this.isDarkMode = false,
    required this.colorTheme,
  });

  getTheme() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: (isDarkMode) ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colorTheme,
    );

    return base.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(base.textTheme),
    );
  }
}
