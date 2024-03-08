import 'package:flutter/material.dart';

class CustomBottomNavigationBarWidget extends StatelessWidget {
  const CustomBottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'categorias',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'favorites',
        ),
      ],
    );
  }
}
