import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/domain/repository/CatalogRepository.dart';
import 'package:evertecine/network/core/BaseNetworkResponse.dart';
import 'package:evertecine/ui/viewModel/home_state.dart';
import 'package:flutter/cupertino.dart';

class Homeviewmodel extends ChangeNotifier {
  final UpcomingMoviesRepository repository;
  HomeState _state = HomeState();

  HomeState get state => _state;

  Homeviewmodel({required this.repository});


  Future<void> loadUpcomingMovies() async {
    if (_state.paging) return;

    try {      
      BaseNetworkResponse<Movie> response = await repository.getUpcomingMovies(page: _state.actualPage);
      if (!response.success) {
       _updateState(_state.copyWith(paging: false, errorMessage: response.message));
        return;
      }
      final List<Movie> newMovies = response.results ?? [];
      _updateState(_state.copyWith(paging: false, loading: false, movies: [..._state.movies,...newMovies], actualPage: _state.actualPage + 1));

    } catch(e) {
      _updateState(_state.copyWith(paging: false, errorMessage: e.toString()));
    }
  }

  void _updateState(HomeState newState) {
    _state = newState;
    notifyListeners();

  }
}
