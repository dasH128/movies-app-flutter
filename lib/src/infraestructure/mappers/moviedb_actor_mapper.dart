import 'package:movies_app/src/domain/entities/actor.dart';
import 'package:movies_app/src/infraestructure/model/moviedb/moviedb_credits_response.dart';

class MovieDbActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://www.talentbid.com/images/no-image.png',
        characters: cast.character,
      );
}
