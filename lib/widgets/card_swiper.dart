import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculasapp/models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(
            value: 2,
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Swiper(
          viewportFraction: 0.6,
          scale: 0.4,
          itemCount: movies.length,
          layout: SwiperLayout.DEFAULT,
          itemWidth: size.width * 0.4,
          itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];

            movie.heroID = 'swiper-${movie.id}';

            return GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, 'details', arguments: movie),
              child: Hero(
                tag: movie.heroID!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FadeInImage(
                    fadeInDuration: const Duration(milliseconds: 300),
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: NetworkImage(movie.fullPosterImg),
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
