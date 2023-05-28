// Third Party
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final fetchMovieInfo = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieMapNotifier(getMovie: fetchMovieInfo);
});

/* 
  This is what the MovieMapNotifier state looks like
  {
    '505642': Movie(),
    '205341': Movie(),
    '105232': Movie(),
    '312332': Movie(),
  }
*/

typedef GetMovieCallback = Future<Movie> Function(String movieID);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;
  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieID) async {
    if (state[movieID] != null) return;

    final movie = await getMovie(movieID);
    state = {...state, movieID: movie};
  }
}
