import 'package:evertecine/data/movie/local/i_local_movie_repository.dart';
import 'package:evertecine/data/movie/network/i_network_movie_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/model/movie.dart';
import '../../network/core/base_network_response.dart';

class MovieService {
  final ILocalMovieRepository _localRepo;
  final Inetworkmovierepository _networkRepo;
  final SharedPreferences _prefs;


  MovieService({
    required ILocalMovieRepository localRepo,
    required Inetworkmovierepository networkRepo,
    required SharedPreferences prefs
  }) :_localRepo = localRepo, 
        _networkRepo = networkRepo, 
        _prefs = prefs;
  
  Future<BaseAPIResponse<Movie>> getUpcomingMovies(int page) async {
    try {
      final actualPage = _prefs.getInt('page') ?? 0;
      if (_refreshLocalDataBase() || page > 1) {
        await _updateLocalDataBase(actualPage + 1);
      }
      return await _localRepo.getUpcomingMovies();
    } catch (e) {
      return BaseAPIResponse(success: false, message: e.toString());
    }
  }

  bool _refreshLocalDataBase() {
    final actualPage = _prefs.getInt('page') ?? 0;
    final lastUpdate = _prefs.getInt('last_update') ?? 0;
    final actualMoment = DateTime.now().millisecondsSinceEpoch;
    bool refresh = (actualMoment - lastUpdate) >  5 * 60 * 60 * 1000; // 5 hours in milliseconds
    return refresh || actualPage == 0;
  }

  Future<void> _addNewMovies(List<Movie>? results) async {
    if (results!.isEmpty) return;
    _localRepo.insert(results);
    _prefs.setInt('last_update', DateTime.now().millisecondsSinceEpoch);
    final int actualPage = _prefs.getInt('page') ?? 0;
    _prefs.setInt('page', actualPage + 1);
  }

  Future<BaseAPIResponse<Movie>> searchMovieByName(String value) async {
    return _networkRepo.searchMovieByName(value);
  }

  Future<void> _updateLocalDataBase(int page) async {
    final response = await _networkRepo.getUpcomingMovies(page: page);
    if (!response.success || response.results!.isEmpty) return;
    _addNewMovies(response.results);
  }

}