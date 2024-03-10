import 'package:dio/dio.dart';
import 'package:movies_app/src/config/config.dart';
import 'package:movies_app/src/domain/datasources/actors_datasource.dart';
import 'package:movies_app/src/domain/entities/actor.dart';
import 'package:movies_app/src/infraestructure/mappers/moviedb_actor_mapper.dart';
import 'package:movies_app/src/infraestructure/model/moviedb/moviedb_credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
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
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    CreditsResponse resp = CreditsResponse.fromJson(response.data);
    var actors =
        resp.cast.map((cast) => MovieDbActorMapper.castToEntity(cast)).toList();

    return actors;
  }
}
