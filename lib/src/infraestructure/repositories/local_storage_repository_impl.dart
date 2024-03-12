import 'package:movies_app/src/domain/datasources/local_storage_datasource.dart';
import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}
