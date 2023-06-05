// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Project
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final Future<void> Function()? loadNextPage;

  const MovieMasonry({
    required this.movies,
    this.loadNextPage,
    super.key,
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() async {
      final maxScrollHeight = _scrollController.position.maxScrollExtent;
      final currentPosition = _scrollController.position.pixels;

      if (currentPosition + 50 >= maxScrollHeight) {
        if (widget.loadNextPage case final loadNextPage?) {
          await loadNextPage();
          // We await 1 second, so we are sure the user isn't scrolling anymore
          await Future.delayed(const Duration(seconds: 1));

          _scrollController.animateTo(
            currentPosition + 200,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: _scrollController,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];

          if (index == 1) {
            return Padding(
              padding: const EdgeInsets.only(top: 40),
              child: MoviePosterLink(movie: movie),
            );
          }

          return MoviePosterLink(movie: movie);
        },
      ),
    );
  }
}
