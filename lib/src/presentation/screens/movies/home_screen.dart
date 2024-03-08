import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';
import 'package:movies_app/src/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _HomeWidget(),
      ),
    );
  }
}

class _HomeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(nowPlayingMovies);
    var slideshowMovies = ref.watch(moviesSlideshowProvider);

    if (state.isLoading) return const CircularProgressIndicator();
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBarWidget(),
          MoviesSlidesShowWidget(movies: slideshowMovies),
          MovieHorizontalListViewWidget(
            movies: state.movies,
            title: 'En cines',
            subTitle: 'Lunes 20',
          )
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: state.movies.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       var movie = state.movies[index];
          //       return Text('${movie.title} ');
          //     },
          //   ),
          // )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBarWidget(),
    );
  }
}
