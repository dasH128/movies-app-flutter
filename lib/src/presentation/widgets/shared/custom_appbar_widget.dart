import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/presentation/delegates/search_movie_delegate.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';

class CustomAppBarWidget extends ConsumerWidget {
  final String title;

  const CustomAppBarWidget({super.key, this.title = 'Cinemapedia'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextStyle titleStyle = Theme.of(context).textTheme.titleMedium!;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_creation_sharp, color: color.primary),
              const SizedBox(width: 5),
              Text(title, style: titleStyle),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final movieRepository = ref.read(moviesRepositoryProvider);
                  showSearch<Movie?>(
                    context: context,
                    delegate: SearchMovieDelegate(
                      searchMoviesCallback: movieRepository.searchMovies,
                    ),
                  ).then((movie) {
                    if (movie != null) {
                      context.push('/movie/${movie.id}');
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
