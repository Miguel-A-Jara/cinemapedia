// Flutter
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

// Third Party
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool _isLastPage = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (_isLoading || _isLastPage) return;
    _isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    _isLoading = false;

    if (movies.isEmpty) _isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMoviesWatch = ref.watch(favoriteMoviesProvider);
    final favoriteMoviesList = favoriteMoviesWatch.values.toList();

    if (favoriteMoviesList.isEmpty) {
      final colors = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border_sharp, size: 60, color: colors.primary),
            Text(
              'No tienes favoritos!',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            Text(
              'Agrega algunas películas para verlas aquí.',
              style: TextStyle(fontSize: 20, color: colors.secondary),
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.go('/'),
              child: const Text('Empieza a buscar'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMoviesList,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
