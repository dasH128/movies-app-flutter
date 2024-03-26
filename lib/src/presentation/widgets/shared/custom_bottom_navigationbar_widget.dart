import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
  });

  void onItemTapped(BuildContext context, int index) {
    context.go('/home/$index');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'configuración',
        ),
      ],
    );
  }
}
