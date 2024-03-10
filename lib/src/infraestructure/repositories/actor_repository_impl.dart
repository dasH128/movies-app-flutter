// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:movies_app/src/domain/datasources/actors_datasource.dart';
import 'package:movies_app/src/domain/entities/actor.dart';
import 'package:movies_app/src/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return await datasource.getActorsByMovie(movieId);
  }
}
