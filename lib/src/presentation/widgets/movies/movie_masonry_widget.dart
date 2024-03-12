import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movies_app/src/domain/entities/movie.dart';
import 'package:movies_app/src/presentation/widgets/widgets.dart';

class MovieMasonryWidget extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonryWidget({
    super.key,
    required this.movies,
    this.loadNextPage,
  });

  @override
  State<MovieMasonryWidget> createState() => _MovieMasonryWidgetState();
}

class _MovieMasonryWidgetState extends State<MovieMasonryWidget> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      // print(
      //     '${controller.position.pixels} --- ${controller.position.maxScrollExtent}');
      //if(controller.position.pixels-120){}
      if (widget.loadNextPage == null) return;

      if (controller.position.pixels + 100 >=
          controller.position.maxScrollExtent) {
        widget.loadNextPage!();
        //print('${controller.position.pixels}llege al maximo');
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
          controller: controller,
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: widget.movies.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = widget.movies[index];
            if (index == 1) {
              return Column(
                children: [
                  const SizedBox(height: 40),
                  MoviePosterLinkWidget(movie: movie)
                ],
              );
            }
            return MoviePosterLinkWidget(movie: movie);
          }),
    );
  }
}
