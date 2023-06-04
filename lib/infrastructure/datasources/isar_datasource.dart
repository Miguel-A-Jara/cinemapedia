// Third Party
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Project
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieID) async {
    final isar = await db;

    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieID).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final Movie? favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null && favoriteMovie.isarID != null) {
      // If we found a movie, we delete it.
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarID!));
      return;
    }

    // If we didn't find a movie. We insert it.
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await db;
    final List<Movie> movies =
        await isar.movies.where().offset(offset).limit(limit).findAll();

    return movies;
  }
}
