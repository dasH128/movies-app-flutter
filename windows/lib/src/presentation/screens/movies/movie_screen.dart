import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String name = 'movie-screen';
  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId,
  });

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    Movie? movie = ref.watch(movieInfoProvider).moviesCache[widget.movieId];

    if (movie == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _SliverAppBarView(
            movie: movie,
          ),
          _SliverListView(
            movie: movie,
          ),
        ],
      ),
    );
  }
}

class _SliverListView extends StatelessWidget {
  final Movie movie;
  const _SliverListView({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        movie.posterPath,
                        width: size.width * 0.3,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: (size.width - 40) * 0.7,
                      child: Column(
                        children: [
                          Text(movie.title, style: textStyle.titleLarge),
                          Text(movie.overview),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    ...movie.genreIds.map(
                      (genre) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Chip(
                          label: Text(genre),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // TODO: mostrar actores
              SizedBox(height: 100),
            ],
          );
        },
        childCount: 1,
      ),
    );
  }
}

class _SliverAppBarView extends StatelessWidget {
  final Movie movie;

  const _SliverAppBarView({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsetsDirectional.symmetric(
          horizontal: 12,
          vertical: 5,
        ),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(movie.posterPath, fit: BoxFit.cover),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.75, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.25],
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
