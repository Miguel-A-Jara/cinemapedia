// Third Party
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project
import 'package:cinemapedia/presentation/providers/providers.dart';

final isFavoriteMovieProvider =
    FutureProvider.autoDispose.family<bool, int>((ref, movieID) {
  final localStorageRead = ref.read(localStorageRepositoryProvider);
  return localStorageRead.isMovieFavorite(movieID);
});
