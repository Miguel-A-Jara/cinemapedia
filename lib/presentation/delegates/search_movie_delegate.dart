// Flutter & Dart
import 'dart:async';
import 'package:flutter/material.dart';

// Third Party
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

// Project
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<void> {
  final SearchMoviesCallback searchMovies;
  final List<Movie> initalMovies;
  List<Movie> _foundMovies = [];

  final StreamController<List<Movie>> _debouncedMovies =
      StreamController.broadcast();
  final StreamController<bool> _isLoading = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate({required this.initalMovies, required this.searchMovies})
      : super(searchFieldLabel: 'Busca...');

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
        _debounceTimer?.cancel();
        _debouncedMovies.close();

        context.pop();
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
        _debounceTimer?.cancel();

        context.push('/movie/${movie.id}');
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
        _debounceTimer?.cancel();

        context.push('/movie/${movie.id}');
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
    final colors = Theme.of(context).colorScheme;

    return StreamBuilder(
      initialData: initMovies,
      stream: movieStream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, idx) => FadeInRight(
            delay: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 500),
            child: _MovieItem(
              movie: movies[idx],
              onMovieSelected: onMovieSelected,
            ),
          ),
          separatorBuilder: (context, index) => Divider(
            color: colors.primary.withOpacity(0.5),
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                fit: BoxFit.cover,
                width: size.width * 0.25,
                height: 150,
                movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) => FadeIn(
                  child: child,
                ),
              ),
            ),
            // Description
            SizedBox(
              width: size.width * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                  ),
                  Text(movie.overview,
                      maxLines: 3, overflow: TextOverflow.ellipsis),
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
