import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String title;

  const CustomAppBarWidget({super.key, this.title = 'titlee'});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextStyle textStyle = Theme.of(context).textTheme.displayMedium!;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_creation_sharp, color: color.primary),
              const SizedBox(width: 5),
              Text(title, style: textStyle),
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
