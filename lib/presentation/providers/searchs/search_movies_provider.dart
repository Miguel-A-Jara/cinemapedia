// Third Party
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
      ref: ref, searchedMovies: movieRepository.searchMovies);
});

typedef SearchedMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchedMoviesCallback _searchedMovies;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.ref,
    required Future<List<Movie>> Function(String) searchedMovies,
  })  : _searchedMovies = searchedMovies,
        super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    ref.read(searchQueryProvider.notifier).update((state) => query);

    final List<Movie> movies = await _searchedMovies(query);
    state = movies;

    return movies;
  }
}
