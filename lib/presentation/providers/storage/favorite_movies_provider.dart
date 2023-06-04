// Third Party
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepositoryWatch = ref.watch(localStorageRepositoryProvider);
  return FavoriteMoviesNotifier(localStorageRepositoryWatch);
});

/// Shape:
/// ```
/// {
///    1235: Movie,
///    9576: Movie,
///    7581: Movie,
/// }
/// ````
class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  FavoriteMoviesNotifier(this.localStorageRepository) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
      offset: page * 10,
      limit: 20,
    );
    page++;

    final Map<int, Movie> tempMoviesMap = {};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
