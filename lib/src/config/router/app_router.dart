import 'package:go_router/go_router.dart';
import 'package:movies_app/src/presentation/screens/screens.dart';

class AppRouter {
  getRouter() {
    return GoRouter(
      initialLocation: '/home/2',
      routes: [
        GoRoute(path: '/', redirect: (_, __) => '/home/0'),
        GoRoute(
          path: '/home/:page',
          name: HomeScreen.name,
          builder: (context, state) {
            final page = state.pathParameters['page'] ?? 0;
            int pageIndex = int.parse(page.toString());
            return HomeScreen(pageIndex: pageIndex);
          },
          routes: [
            GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';
                return MovieScreen(movieId: movieId);
              },
            ),
          ],
        ),
      ],
    );
  }
}
