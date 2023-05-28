// Project
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieFromMovieDb moviefromMovieDB) => Movie(
        adult: moviefromMovieDB.adult,
        backdropPath: (moviefromMovieDB.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviefromMovieDB.backdropPath}'
            : 'https://howfix.net/wp-content/uploads/2018/02/sIaRmaFSMfrw8QJIBAa8mA-article.png',
        genreIds: moviefromMovieDB.genreIds.map((e) => e.toString()).toList(),
        id: moviefromMovieDB.id,
        originalLanguage: moviefromMovieDB.originalLanguage,
        originalTitle: moviefromMovieDB.originalTitle,
        overview: moviefromMovieDB.overview,
        popularity: moviefromMovieDB.popularity,
        posterPath: (moviefromMovieDB.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviefromMovieDB.posterPath}'
            : 'no-poster',
        releaseDate: moviefromMovieDB.releaseDate,
        title: moviefromMovieDB.title,
        video: moviefromMovieDB.video,
        voteAverage: moviefromMovieDB.voteAverage,
        voteCount: moviefromMovieDB.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movieDetails) => Movie(
        adult: movieDetails.adult,
        backdropPath: (movieDetails.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}'
            : 'https://howfix.net/wp-content/uploads/2018/02/sIaRmaFSMfrw8QJIBAa8mA-article.png',
        genreIds: movieDetails.genres.map((e) => e.name).toList(),
        id: movieDetails.id,
        originalLanguage: movieDetails.originalLanguage,
        originalTitle: movieDetails.originalTitle,
        overview: movieDetails.overview,
        popularity: movieDetails.popularity,
        posterPath: (movieDetails.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}'
            : 'https://howfix.net/wp-content/uploads/2018/02/sIaRmaFSMfrw8QJIBAa8mA-article.png',
        releaseDate: movieDetails.releaseDate,
        title: movieDetails.title,
        video: movieDetails.video,
        voteAverage: movieDetails.voteAverage,
        voteCount: movieDetails.voteCount,
      );
}
