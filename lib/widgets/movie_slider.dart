import 'package:flutter/material.dart';
import 'package:peliculasapp/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> moviesPopular;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key,
    required this.moviesPopular,
    required this.onNextPage,
    this.title,
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  bool _canGetMore = false;

  @override
  void initState() {
    super.initState();
    // compruebo en que posicion esta el list view, y le mando la funcion creada anteriormente,
    // que tambien es un argumento que debo poner en el homescreen
    scrollController.addListener(
      () {
        final int pixelPosition = scrollController.position.pixels.toInt();
        final int finalPosition =
            scrollController.position.maxScrollExtent.toInt();
        final int result = (finalPosition).toInt();

        if (pixelPosition >= result) {
          _canGetMore = true;
          if (_canGetMore) {
            widget.onNextPage();
            _canGetMore = false;
          }
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.moviesPopular.isEmpty) {
      return const SizedBox(
        width: double.infinity,
        height: 300,
        child: Center(
          child: CircularProgressIndicator(
            value: 2,
          ),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(widget.title!),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.moviesPopular.length,
              itemBuilder: (_, int index) => _MoviePoster(
                movie: widget.moviesPopular[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  const _MoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroID = 'slider-${movie.id}';
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroID!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  placeholderFit: BoxFit.cover,
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                  width: 130,
                  height: 190,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
