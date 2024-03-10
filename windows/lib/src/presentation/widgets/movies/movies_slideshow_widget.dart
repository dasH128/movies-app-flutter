import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:movies_app/src/domain/entities/movie.dart';

class MoviesSlidesShowWidget extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlidesShowWidget({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 210,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        itemCount: movies.length,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            size: 8,
            color: color.secondary,
            activeColor: color.primary,
          ),
        ),
        itemBuilder: (_, index) => _SlideMovieView(movie: movies[index]),
      ),
    );
  }
}

class _SlideMovieView extends StatelessWidget {
  final Movie movie;

  const _SlideMovieView({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ],
    );

    /*return Container(
      padding: const EdgeInsets.only(bottom: 30),
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          movie.backdropPath,
          fit: BoxFit.cover,
        ),
      ),
    );*/

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black12),
                );
              }
              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}
