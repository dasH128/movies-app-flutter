import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/domain/datasources/actors_datasource.dart';
import 'package:movies_app/src/infraestructure/datasources/actor_moviedb_datasource.dart';
import 'package:movies_app/src/infraestructure/repositories/actor_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  ActorsDatasource datasource = ActorMovieDbDatasource();
  return ActorRepositoryImpl(datasource);
});
