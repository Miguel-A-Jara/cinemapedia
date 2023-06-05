// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    void handleOnPressed() async {
      final searchMovies = ref.read(searchedMoviesProvider);
      final searchQuery = ref.read(searchQueryProvider);

      showSearch(
        query: searchQuery,
        context: context,
        delegate: SearchMovieDelegate(
          initalMovies: searchMovies,
          searchMovies:
              ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery,
        ),
      );

      // if (context.mounted && movie != null) {
      //   context.push('/movie/${movie.id}');
      // }
    }

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () => handleOnPressed(),
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }
}
