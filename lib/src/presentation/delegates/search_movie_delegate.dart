import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/config/config.dart';
import 'package:movies_app/src/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  List<Movie> initialMovies;
  final SearchMoviesCallback searchMoviesCallback;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMoviesCallback,
    required this.initialMovies,
  });

  void clearStreams() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    //print('Query stream cambio');
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // if (query.isEmpty) {
      //   debouncedMovies.add([]);
      //   return;
      // }

      final movies = await searchMoviesCallback(query);
      isLoadingStream.add(false);
      initialMovies = movies;
      debouncedMovies.add(movies);
    });
  }

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
          //initialData: false,
          stream: isLoadingStream.stream,
          builder: (_, snapshot) {
            var isLoading = snapshot.data ?? false;
            if (isLoading) {
              return SpinPerfect(
                duration: const Duration(seconds: 1),
                spins: 10,
                infinite: true,
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    query = '';
                  },
                ),
              );
            }
            return FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  query = '';
                },
              ),
            );
          }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        clearStreams();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // return StreamBuilder(
    //   initialData: initialMovies,
    //   stream: debouncedMovies.stream,
    //   builder: (context, snapshot) {
    //     final movies = snapshot.data ?? [];
    //     return ListView.builder(
    //       itemCount: movies.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         final movie = movies[index];
    //         return _MovieItemView(
    //           movie: movie,
    //           onMovieSelected: (context, movie) {
    //             clearStreams();
    //             close(context, movie);
    //           },
    //         );
    //       },
    //     );
    //   },
    // );
    return _buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    // return StreamBuilder(
    //   // future: searchMoviesCallback(query),
    //   stream: debouncedMovies.stream,
    //   initialData: initialMovies,
    //   builder: (context, snapshot) {
    //     final movies = snapshot.data ?? [];
    //     return ListView.builder(
    //       itemCount: movies.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         final movie = movies[index];
    //         return _MovieItemView(
    //           movie: movie,
    //           onMovieSelected: (context, movie) {
    //             clearStreams();
    //             close(context, movie);
    //           },
    //         );
    //       },
    //     );
    //   },
    // );
    return _buildResultsAndSuggestions();
  }

  Widget _buildResultsAndSuggestions() {
    return StreamBuilder(
      // future: searchMoviesCallback(query),
      stream: debouncedMovies.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            return _MovieItemView(
              movie: movie,
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class _MovieItemView extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItemView({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    var colorAux = Colors.yellow.shade800;

    return FadeIn(
      child: GestureDetector(
        onTap: () {
          onMovieSelected(context, movie);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.posterPath,
                    loadingBuilder: (context, child, loadingProgress) {
                      return child;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: size.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.titleMedium,
                    ),
                    (movie.overview.length > 100)
                        ? Text('${movie.overview.substring(0, 100)}...')
                        : Text(movie.overview),
                    Row(
                      children: [
                        Icon(Icons.star_half, color: colorAux),
                        const SizedBox(width: 5), //voteAverage

                        Text(
                          HumanFormats.getNumber(movie.voteAverage, 1),
                          style:
                              textStyle.bodyMedium!.copyWith(color: colorAux),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
