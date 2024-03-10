import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String title;

  const CustomAppBarWidget({super.key, this.title = 'Cinemapedia'});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextStyle titleStyle = Theme.of(context).textTheme.titleMedium!;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_creation_sharp, color: color.primary),
              const SizedBox(width: 5),
              Text(title, style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }
}
