import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieInfoNotifier, MovieInfoState>((ref) {
  final getMovie = ref.watch(moviesRepositoryProvider).getMovieById;

  return MovieInfoNotifier(getMovie: getMovie);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieInfoNotifier extends StateNotifier<MovieInfoState> {
  final GetMovieCallback getMovie;

  MovieInfoNotifier({required this.getMovie})
      : super(MovieInfoState(moviesCache: {}));

  Future<void> loadMovie(String movieId) async {
    if (state.moviesCache[movieId] != null) return;

    final movie = await getMovie(movieId);
    state = state.copyWith(moviesCache: {
      ...state.moviesCache,
      movieId: movie,
    });
  }
}

class MovieInfoState {
  final Map<String, Movie> moviesCache;

  MovieInfoState({required this.moviesCache});

  MovieInfoState copyWith({
    Map<String, Movie>? moviesCache,
  }) {
    return MovieInfoState(
      moviesCache: moviesCache ?? this.moviesCache,
    );
  }
}
