// Project
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieID);

  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0});
}
