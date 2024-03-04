import 'package:flutter/material.dart';
import 'package:movies_app/src/config/router/app_router.dart';
import 'package:movies_app/src/config/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().getRouter(),
      debugShowCheckedModeBanner: false,                                                                                           
      theme: AppTheme().getTheme(),
      title: 'Material App',
    );
  }
}
 