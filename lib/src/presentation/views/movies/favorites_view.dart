import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';
import 'package:movies_app/src/presentation/widgets/widgets.dart';

class FavoriteView extends ConsumerWidget {
  const FavoriteView({super.key});

  // loadNextPage(WidgetRef ref) async {
  //   final m = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  //   print('m t: ${m.length}');
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(favoriteMoviesProvider);
    List<Movie> movies = state.movies.values.toList();
    // if (state.isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    if (state.movies.isEmpty) {
      final color = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outlined,
              size: 60,
              color: color.primary,
            ),
            const SizedBox(height: 5),
            Text(
              'Sin peliculas favoritas',
              style: TextStyle(fontSize: 20, color: color.tertiary),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonryWidget(
        movies: movies,
        loadNextPage: ref.read(favoriteMoviesProvider.notifier).loadNextPage,
        // loadNextPage: loadNextPage,
      ),
    );
  }
}
