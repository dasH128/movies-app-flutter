import 'package:movies_app/src/domain/datasources/movies_datasource.dart';
import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return await datasource.getNowPlaying();
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return await datasource.getPopular();
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return await datasource.getTopRated();
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return await datasource.getUpcoming();
  }

  @override
  Future<Movie> getMovieById(String id) async {
    return await datasource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    return await datasource.searchMovies(query);
  }
}
