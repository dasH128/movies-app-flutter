// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/domain/repositories/local_storage_repository.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, FavoriteMoviesState>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return FavoriteMoviesNotifier(localStorageRepository: localStorageRepository);
});

class FavoriteMoviesNotifier extends StateNotifier<FavoriteMoviesState> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  FavoriteMoviesNotifier({required this.localStorageRepository})
      : super(FavoriteMoviesState(movies: const {})) {
    //state = state.copyWith(isLoading: true);
    // loadDataInit();
    loadNextPage();
  }

  // Future loadDataInit() async {
  //   await _loadNextPage();
  //   state = state.copyWith(isLoading: false);
  // }

  loadNextPage() async {
    // print(
    //     'das provider ${state.isLoading} - ${state.isLastPage} - ${state.movies}');
    if (state.isLoading || state.isLastPage) return;
    state = state.copyWith(isLoading: true);

    final movies = await _loadNextPage();
    state = state.copyWith(isLoading: false);

    if (movies.isEmpty) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<List<Movie>> _loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
      offset: page * 10,
      //limit: 20,
    ); // TODO Limit 20
    print('das 3* off:${page * 10} - lim:${20}');
    page++;
    final Map<int, Movie> tempMoviesMap = {};
    for (var movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }
    state = state.copyWith(movies: {...state.movies, ...tempMoviesMap});
    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);

    final bool isMovieIsFavorite = state.movies[movie.id] != null;
    if (isMovieIsFavorite) {
      state.movies.remove(movie.id);
      state = state.copyWith(movies: {...state.movies});
    } else {
      state = state.copyWith(movies: {...state.movies, movie.id: movie});
    }
  }
}

class FavoriteMoviesState {
  final Map<int, Movie> movies;
  final bool isLoading;
  final bool isLastPage;

  FavoriteMoviesState({
    required this.movies,
    this.isLoading = false,
    this.isLastPage = false,
  });

  // FavoriteMoviesState copyWith({
  //   Map<int, Movie>? movies,
  //   bool? isLoading,
  // }) {
  //   return FavoriteMoviesState(
  //     movies ?? this.movies,
  //     isLoading ?? this.isLoading,
  //   );
  // }

  FavoriteMoviesState copyWith({
    Map<int, Movie>? movies,
    bool? isLoading,
    bool? isLastPage,
  }) {
    return FavoriteMoviesState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}
