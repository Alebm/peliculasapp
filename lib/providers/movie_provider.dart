// ignore_for_file: avoid_print

import 'dart:async';

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

  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider Inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  //ceramos esto para optimizar el codigo ya que hay fragmentos iguales, en los get...

  Future<dynamic> _getJsonData(String _segment, [int page = 1]) async {
    final url = Uri.https(_baseUrl, _segment, {
      'api_key': _apiKey,
      'language': _language,
      'page': page.toString(),
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    /* final url = Uri.https(_baseUrl, _segmentNowPlaying, {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url); //!hacia arriba esta parte esta duplicada y optimizamos */

    final jsonData = await _getJsonData(_segmentNowPlaying);
    //hago un cambio por el mapeo que hice en el NowPlayingResponse y el Movie
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    //forma anterior para hacer el mapa
    //final Map<String, dynamic> decodeData = jsonDecode(response.body);

    print(nowPlayingResponse.results[5].title);
    onDisplayMovie = nowPlayingResponse.results;

    //este notifyListeners notifica a los widgets para que se actualicen
    notifyListeners();
  }

  getPopularMovies() async {
    /* final url = Uri.https(_baseUrl, _segmentPopular, {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);//! esta es la otra parte duplicada */

    _popularPage++;

    final jsonData = await _getJsonData(_segmentPopular, _popularPage);

    final popularMovieslist = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularMovieslist.results];
    notifyListeners();
    print(_popularPage);
  }
}
