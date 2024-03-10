import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/infraestructure/model/moviedb/moviedb_detail_response.dart';
import 'package:movies_app/src/infraestructure/model/moviedb/moviedb_moviedb.dart';

class MovieDbMapper {
  static Movie movieDbToEntity(MovieMovieDB moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://picsum.photos/250?image=9',
        genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'no-poster',
        releaseDate: moviedb.releaseDate,
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );

  static Movie movieDbDetailToEntity(MovieDetailResponse movieDetail) => Movie(
        adult: movieDetail.adult,
        backdropPath: (movieDetail.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath}'
            : 'https://picsum.photos/250?image=9',
        genreIds: movieDetail.genres.map((e) => e.name).toList(),
        id: movieDetail.id,
        originalLanguage: movieDetail.originalLanguage,
        originalTitle: movieDetail.originalTitle,
        overview: movieDetail.overview,
        popularity: movieDetail.popularity,
        posterPath: (movieDetail.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDetail.posterPath}'
            : 'https://picsum.photos/250?image=9',
        releaseDate: movieDetail.releaseDate,
        title: movieDetail.title,
        video: movieDetail.video,
        voteAverage: movieDetail.voteAverage,
        voteCount: movieDetail.voteCount,
      );
}
