import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeProvider = StateProvider<bool>((ref) => false);

final colorsThemeProvider = Provider<List<ColorTheme>>(
  (ref) => [
    ColorTheme(name: 'black', color: const Color(0xFF2862f5)),
    ColorTheme(name: 'black', color: Colors.amber),
    ColorTheme(name: 'black', color: Colors.blue),
    ColorTheme(name: 'black', color: Colors.green),
    ColorTheme(name: 'black', color: Colors.grey),
    ColorTheme(name: 'black', color: Colors.brown),
    ColorTheme(name: 'black', color: Colors.cyan),
    ColorTheme(name: 'black', color: Colors.deepOrange),
    ColorTheme(name: 'black', color: Colors.indigo),
    ColorTheme(name: 'black', color: Colors.lime),
    ColorTheme(name: 'black', color: Colors.orange),
    ColorTheme(name: 'black', color: Colors.pink),
    ColorTheme(name: 'black', color: Colors.purple),
    ColorTheme(name: 'black', color: Colors.teal),
    ColorTheme(name: 'black', color: Colors.yellow),
  ],
);

final colorSelectedProvider = StateProvider<int>((ref) => 0);

class ColorTheme {
  final String name;
  final Color color;
  ColorTheme({
    required this.name,
    required this.color,
  });
}
