import 'dart:convert';
import 'package:evertecine/data/movie/network/INetworkMovieRepository.dart';
import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/data/movie/IMovieRepository.dart';
import 'package:http/http.dart' as http;

import '../../../network/core/BaseNetworkResponse.dart';

class NetworkMoviesRepositoryImpl implements Inetworkmovierepository {
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = 'df6f065db6e892ecbc291c2ecb07fe13';
  Map<int, String> _genres = {};

  NetworkMoviesRepositoryImpl() {
    // first time load genres
    initializeGenres();
  }

  @override
  Future<BaseNetworkResponse<Movie>> getUpcomingMovies({int page = 1}) async {
    final url = Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey&language=pt-BR&page=$page');

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        return BaseNetworkResponse(success: false, message: "Request failed", statusCode: response.statusCode);
      }
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      final List<Movie> movies = results.map((item) => Movie.fromNetwork(item, _genres)).toList();
      if (movies.isEmpty) return BaseNetworkResponse(success: false, message: "Empty movies list");
      return BaseNetworkResponse(success: true, results: movies, statusCode: 200);
    } catch (e) {
      return BaseNetworkResponse(success: false, message: e.toString());
    }
  }

  Future<void> initializeGenres() async {
    final url = Uri.parse('$_baseUrl/genre/movie/list?api_key=$_apiKey&language=pt-BR');
    if (_genres.isNotEmpty) return;
    try {
      final response = await http.get(url);

      if (response.statusCode != 200) return;
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> genresList = data['genres'];

      _genres = {
        for (var item in genresList)
          (item['id'] as int) : (item['name'] as String)
      };
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  Future<BaseNetworkResponse<Movie>> searchMovieByName(String value) async {
    final url = Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$value&language=pt-BR');
    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        return BaseNetworkResponse(success: false, message: "Request failed", statusCode: response.statusCode);
      }
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      final List<Movie> movies = results.map((item) => Movie.fromNetwork(item, _genres)).toList();
      if (movies.isEmpty) return BaseNetworkResponse(success: false, message: "Empty movies list");
      return BaseNetworkResponse(success: true, results: movies, statusCode: 200);
    } catch (e) {
      return BaseNetworkResponse(success: false, message: e.toString());
    }

  }

}
