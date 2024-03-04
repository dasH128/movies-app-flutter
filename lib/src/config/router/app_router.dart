import 'package:go_router/go_router.dart';
import 'package:movies_app/src/presentation/screens/screens.dart';

class AppRouter {
  getRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
  }
}
