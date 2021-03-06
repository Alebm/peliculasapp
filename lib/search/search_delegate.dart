import 'package:flutter/material.dart';
import 'package:peliculasapp/models/models.dart';
import 'package:peliculasapp/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResult');
  }

  Widget empty() {
    return SizedBox(
      child: Center(
          child: Image.asset(
        'assets/pel.png',
        width: 150,
      )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return empty();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context);
    //moviesProvider.getSuggestionsByQuery(query);

//TODO: luego implementar el Stream builder por que no esta funcionando
    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return empty();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return ListSearch(
              movie: movies[index],
            );
          },
        );
      },
    );
  }
}

class ListSearch extends StatelessWidget {
  final Movie movie;

  const ListSearch({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroID = 'seach-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroID!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage(
              movie.fullPosterImg,
            ),
            width: 50,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle, overflow: TextOverflow.ellipsis),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
