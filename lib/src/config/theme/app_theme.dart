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
    return ThemeData(
      useMaterial3: true,
      // colorSchemeSeed: Colors.amber,
      textTheme: GoogleFonts.nunitoTextTheme(),
      brightness: (isDarkMode) ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colorTheme,
    );
  }
}
