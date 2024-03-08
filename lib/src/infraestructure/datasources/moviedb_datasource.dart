import 'package:dio/dio.dart';
import 'package:movies_app/src/config/constans/environments.dart';
import 'package:movies_app/src/domain/datasources/movies_datasource.dart';
import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/infraestructure/mappers/moviedb_mapper.dart';
import 'package:movies_app/src/infraestructure/model/moviedb/moviedb_response.dart';

class MovieDbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environments.theMobieDbApiKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    MovieDbResponse movieDbResponse = MovieDbResponse.fromJson(response.data);
    var movies = movieDbResponse.results
        .where((moviedb) => (moviedb.posterPath != 'no-poster'))
        .map((moviedb) => MovieDbMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }
}

// https://api.themoviedb.org/3/movie/now_playing?api_key=8a7b2921285d0acce6475620c371b67e&language=es-MX