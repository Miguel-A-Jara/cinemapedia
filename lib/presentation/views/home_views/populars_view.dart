// Flutter
import 'package:flutter/material.dart';

// Third Party
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Project
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';

class PopularsView extends ConsumerWidget {
  const PopularsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularMoviesWatch = ref.watch(popularMoviesProvider);
    final popularMoviesRead = ref.read(popularMoviesProvider.notifier);

    if (popularMoviesWatch.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return MovieMasonry(
      loadNextPage: () => popularMoviesRead.loadNextPage(),
      movies: popularMoviesWatch,
    );
  }
}
