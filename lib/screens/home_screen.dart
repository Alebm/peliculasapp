import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/movie_provider.dart';
import 'package:peliculasapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//con esto voy a llamar las peliculas para mostrarlas
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en Cine'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(
              movies: moviesProvider.onDisplayMovie,
            ),
            MovieSlider(
              moviesPopular: moviesProvider.popularMovies,
              title: 'Popular',
            ),
            //listado de peliculas horizontal
          ],
        ),
      ),
    );
  }
}
