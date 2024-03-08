import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/domain/datasources/movies_datasource.dart';
import 'package:movies_app/src/infraestructure/datasources/moviedb_datasource.dart';
import 'package:movies_app/src/infraestructure/repositories/movie_repository_impl.dart';

final moviesRepositoryProvider = Provider((ref) {
  MoviesDatasource datasource = MovieDbDatasource();
  return MovieRepositoryImpl(datasource);
});
