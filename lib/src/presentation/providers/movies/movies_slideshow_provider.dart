import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  List<Movie> movies = ref.watch(nowPlayingMovies).movies;

  if (movies.isEmpty) return [];
  return movies.sublist(0, 6);
});
