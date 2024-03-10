import 'package:dio/dio.dart';
import 'package:movies_app/src/config/constans/environments.dart';
import 'package:movies_app/src/domain/datasources/movies_datasource.dart';
import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/infraestructure/mappers/moviedb_movie_mapper.dart';
import 'package:movies_app/src/infraestructure/model/moviedb/moviedb_detail_response.dart';
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

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    MovieDbResponse movieDbResponse = MovieDbResponse.fromJson(json);
    List<Movie> movies = movieDbResponse.results
        .where((moviedb) => (moviedb.posterPath != 'no-poster'))
        .map((moviedb) => MovieDbMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }
    MovieDetailResponse movieDetail =
        MovieDetailResponse.fromJson(response.data);
    Movie movie = MovieDbMapper.movieDbDetailToEntity(movieDetail);
    return movie;
  }
}
