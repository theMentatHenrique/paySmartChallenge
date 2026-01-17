import 'package:evertecine/data/movie/IMovieRepository.dart';
import 'package:evertecine/data/movie/local/ILocalMovieRepository.dart';
import 'package:evertecine/data/movie/network/INetworkMovieRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/model/Movie.dart';
import '../../network/core/BaseNetworkResponse.dart';

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
  
  Future<BaseNetworkResponse<Movie>> getUpcomingMovies({int page = 1}) async {
    try {
      if (_useLocalData(page: page)) {
        return _localRepo.getUpcomingMovies(page: page);
      }
      _prefs.setInt('page', page);
      final BaseNetworkResponse<Movie> responseNetwork = await _networkRepo.getUpcomingMovies(page: page);
      if (responseNetwork.success && responseNetwork.results != []) {
        _updateLocalStorage(responseNetwork.results);
      }
      return responseNetwork;
    } catch (e) {
      return BaseNetworkResponse(success: false, message: e.toString());
    }
  }

  bool _useLocalData({int page = 1}) {
    final actualPage = _prefs.getInt('page') ?? 0;
    final lastUpdate = _prefs.getInt('last_update') ?? 0;
    final actualMoment = DateTime.now().millisecondsSinceEpoch;
    bool refresh = (actualMoment - lastUpdate) >  5 * 60 * 60 * 1000; // 5 hours in milliseconds
    return !refresh && actualPage >= page;
  }

  void _updateLocalStorage(List<Movie>? results) {
    if (results!.isEmpty) return;
    _localRepo.insert(results);
    _prefs.setInt('last_update', DateTime.now().millisecondsSinceEpoch);
  }

  Future<BaseNetworkResponse<Movie>> searchMovieByName(String value) async {
    final localResponse = await _localRepo.searchMovieByName(value);
    if (localResponse.success && localResponse.results!.isNotEmpty) {
      return localResponse;
    }
    return _networkRepo.searchMovieByName(value);
  }

}