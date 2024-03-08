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
}
