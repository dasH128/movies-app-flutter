import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMovies = StateNotifierProvider<MoviesNotifier, MoviesState>(
  (ref) {
    final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getNowPlaying;

    return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
  },
);

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<MoviesState> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super(MoviesState(movies: [])) {
    print('super MoviesNotifier');
    loadNextPage();
  }

  Future loadNextPage() async {
    currentPage++;
    state = state.copyWith(isLoading: true);
    List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = state.copyWith(
      movies: [...state.movies, ...movies],
      isLoading: false,
    );
  }
}

class MoviesState {
  final List<Movie> movies;
  final bool isLoading;

  MoviesState({
    required this.movies,
    this.isLoading = true,
  });

  MoviesState copyWith({
    List<Movie>? movies,
    bool? isLoading,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
