// Third Party
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_impl.dart';

// This is inmutable
final movieRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(MovieDbDataSource());
});
