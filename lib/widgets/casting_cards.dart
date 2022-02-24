import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastinCard extends StatelessWidget {
  // mandamos el id
  final int movieId;

  const CastinCard({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            height: 170,
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [CircularProgressIndicator.adaptive()]),
          );
        }

        final cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 32, top: 8),
          width: double.infinity,
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
<<<<<<< HEAD
            itemCount: cast.length,
=======
            itemCount: 10,
>>>>>>> 6f3de7b55a9c1bc3f960354455fef230aeb06509
            itemBuilder: (BuildContext context, int index) {
              return _CastCard(
                actor: cast[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 100,
      height: 150,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(actor.fullprofilePath),
              height: 130,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
