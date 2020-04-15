import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:networkapi/model/movie.dart';

class ApiProvider {
  Client client = Client();
  static final _apiKey = 'ec807a8669c2840110b6c0b1da738d24';
  static final String _baseUrl = 'http://api.themoviedb.org/3/movie';

  Future<Movie> getMovieList() async {
    final response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }
}
