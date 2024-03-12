import 'package:flutter/material.dart';
import 'package:movies_app/src/presentation/views/views.dart';
import 'package:movies_app/src/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewsRoutes = const [
    HomeView(),
    SizedBox(),
    FavoriteView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewsRoutes,
      ),
      bottomNavigationBar:
          CustomBottomNavigationBarWidget(currentIndex: pageIndex),
    );
  }
}
