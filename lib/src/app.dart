import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/config/config.dart';

import 'presentation/providers/providers.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final isDarkMode = ref.watch(darkModeProvider);
    final colorsTheme = ref.watch(colorsThemeProvider);
    final colorSelected = ref.watch(colorSelectedProvider);

    return MaterialApp.router(
      routerConfig: AppRouter().getRouter(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme(
        isDarkMode: isDarkMode,
        colorTheme: colorsTheme[colorSelected].color,
      ).getTheme(),
      title: 'Material App',
    );
  }
}
