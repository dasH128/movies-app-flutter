import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/src/domain/entities/movie.dart';

class MoviePosterLinkWidget extends StatelessWidget {
  final Movie movie;
  const MoviePosterLinkWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.push('/home/0/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            height: 170,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
