// Third Party
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

// Project
import 'package:cinemapedia/domain/entities/movie.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        scale: 0.8,
        autoplay: true,
        viewportFraction: 0.8,
        itemCount: movies.length,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, idx) => _Slide(movie: movies[idx]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 10)),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _MovieSlideItem(movie: movie, textTheme: textTheme),
        ),
      ),
    );
  }
}

class _MovieSlideItem extends StatelessWidget {
  const _MovieSlideItem({
    required this.movie,
    required this.textTheme,
  });

  final Movie movie;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          width: double.infinity,
          fit: BoxFit.cover,
          movie.backdropPath,
          loadingBuilder: (_, child, loadingProgress) {
            if (loadingProgress != null) {
              return const _ImagePlaceholder();
            }

            return FadeIn(child: child);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            color: Colors.black54,
            child: Text(
              movie.title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(color: Colors.black12),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.black26,
        ),
      ),
    );
  }
}
