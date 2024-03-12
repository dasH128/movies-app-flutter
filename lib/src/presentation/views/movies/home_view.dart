import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';
import 'package:movies_app/src/presentation/widgets/widgets.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) {
      return const CustomFullscreenLoaderWidget();
    }

    var nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    var popularMovies = ref.watch(popularMoviesProvider);
    var topRatedMovies = ref.watch(topRatedMoviesProvider);
    var upcomingMovies = ref.watch(upcomingMoviesProvider);

    var slideshowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBarWidget(),
          ),
          // title: CustomAppBarWidget(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  // const CustomAppBarWidget(),
                  MoviesSlidesShowWidget(movies: slideshowMovies),
                  MovieHorizontalListViewWidget(
                    movies: nowPlayingMovies.movies,
                    title: 'En cines',
                    subTitle: 'Lunes 20',
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),
                  MovieHorizontalListViewWidget(
                    movies: upcomingMovies.movies,
                    title: 'Próximamente',
                    subTitle: 'Este mes',
                    loadNextPage: () {
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  MovieHorizontalListViewWidget(
                    movies: popularMovies.movies,
                    title: 'Populares',
                    loadNextPage: () {
                      ref.read(popularMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  MovieHorizontalListViewWidget(
                    movies: topRatedMovies.movies,
                    title: 'Mejor calificados',
                    subTitle: 'Desde siempre',
                    loadNextPage: () {
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}
