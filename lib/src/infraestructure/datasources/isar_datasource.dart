import 'package:isar/isar.dart';
import 'package:movies_app/src/domain/datasources/local_storage_datasource.dart';
import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;
  IsarDatasource() {
    db = openDB();
  }
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? movie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();
    if (movie == null) return false;
    return true;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    List<Movie> movies =
        await isar.movies.where().offset(offset).limit(limit).findAll();

    return movies;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final movieDB = await isar.movies.filter().idEqualTo(movie.id).findFirst();
    if (movieDB == null) {
      isar.writeTxnSync(() => isar.movies.putSync(movie));
      return;
    }
    isar.writeTxnSync(() => isar.movies.deleteSync(movieDB.isarId!));
  }
}
