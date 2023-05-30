// Flutter & Dart
import 'dart:async';
import 'package:flutter/material.dart';

// Third Party
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';

// Project
import 'package:cinemapedia/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  final List<Movie> initalMovies;
  List<Movie> _foundMovies = [];

  final StreamController<List<Movie>> _debouncedMovies =
      StreamController.broadcast();
  final StreamController<bool> _isLoading = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate({required this.initalMovies, required this.searchMovies})
      : super(searchFieldLabel: 'Busca...');

  void clearStreams() {
    _debouncedMovies.close();
    _debounceTimer?.cancel();
  }

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      _isLoading.add(true);

      final movies = await searchMovies(query);

      _debouncedMovies.add(movies);
      _foundMovies = movies;

      _isLoading.add(false);
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: _isLoading.stream,
        initialData: false,
        builder: (ctx, snapshot) {
          if (snapshot.data!) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              child: const IconButton(
                onPressed: null,
                icon: Icon(Icons.refresh),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _SearchResults(
      initMovies: _foundMovies,
      movieStream: _debouncedMovies.stream,
      onMovieSelected: (ctx, movie) {
        clearStreams();
        close(ctx, movie);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return _SearchResults(
      initMovies: initalMovies,
      movieStream: _debouncedMovies.stream,
      onMovieSelected: (ctx, movie) {
        clearStreams();
        close(ctx, movie);
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<Movie> initMovies;
  final Stream<List<Movie>> movieStream;

  final Function(BuildContext ctx, Movie movie) onMovieSelected;

  const _SearchResults(
      {required this.initMovies,
      required this.movieStream,
      required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: initMovies,
      stream: movieStream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, idx) =>
              _MovieItem(movie: movies[idx], onMovieSelected: onMovieSelected),
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext context, Movie movie) onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(
                    child: child,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                  ),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
