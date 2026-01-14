import 'dart:convert';
import 'package:evertecine/domain/model/Movie.dart';
import 'package:http/http.dart' as http;

import '../core/BaseNetworkResponse.dart';

class MovieService {
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = '';

  Future<BaseNetworkResponse<Movie>> fetchUpcomingFilms() async {
    final url = Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey&language=pt-BR&page=1');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        final List<Movie> movies = results.map((item) => Movie.fromJson(item)).toList();
        if (movies.isEmpty) return BaseNetworkResponse(success: false, message: "Empty movies list");
        return BaseNetworkResponse(success: true, results: movies, statusCode: 200);

      }
      return BaseNetworkResponse(success: false, message: "Request failed", statusCode: response.statusCode);
    } catch (e) {
      return BaseNetworkResponse(success: false, message: e.toString());
    }

  }
}
