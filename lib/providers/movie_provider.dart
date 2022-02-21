// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculasapp/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'f3fd596d627828915cea10d097ef9453';
  final String _baseUrl = 'api.themoviedb.org';
  final String _segmentNowPlaying = '3/movie/now_playing';
  final String _segmentPopular = '3/movie/popular';
  final String _language = 'es-ES';

//LLamo una lista de tipo Movie,
  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('MoviesProvider Inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    final url = Uri.https(_baseUrl, _segmentNowPlaying, {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    //hago un cambio por el mapeo que hice en el NowPlayingResponse y el Movie
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    //forma anterior para hacer el mapa
    //final Map<String, dynamic> decodeData = jsonDecode(response.body);

    print(nowPlayingResponse.results[5].title);
    onDisplayMovie = nowPlayingResponse.results;

    //este notifyListeners notifica a los widgets para que se actualicen
    notifyListeners();
  }

  getPopularMovies() async {
    final url = Uri.https(_baseUrl, _segmentPopular, {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);

    final popularMovieslist = PopularResponse.fromJson(response.body);
    popularMovies = popularMovieslist.results;
    print(popularMovieslist.results[5].title);
  }
}
