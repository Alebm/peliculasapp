// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'f3fd596d627828915cea10d097ef9453';
  final String _baseUrl = 'api.themoviedb.org';
  final String _segment = '3/movie/now_playing';
  final String _language = 'es-ES';

  MoviesProvider() {
    print('MoviesProvider Inicializado');

    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, _segment, {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    print('getOnDisplayMovies');
  }
}
