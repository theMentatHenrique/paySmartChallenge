import 'dart:async';

import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/data/movie/ImovieRepository.dart';
import 'package:evertecine/data/movie/MoviesRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeViewmodel extends ChangeNotifier {
  final IMovieRepository _repository;

  bool _searching = false;
  bool get searching => _searching ;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;


  Timer? _debounce;

  HomeViewmodel({required MoviesRepository repository}) : _repository = repository;


  Future<void> loadUpcomingMovies(int pageKey, PagingController<int, Movie> pagingController) async {
    try {
      final response = await _repository.getUpcomingMovies(page: pageKey);
      if (!response.success) {
        pagingController.error = response.message;
        return;
      }
      final List<Movie> newMovies = response.results ?? [];
      final isLastPage = newMovies.length < 20;

      if (isLastPage) {
        pagingController.appendLastPage(newMovies);
        return;
      }
      pagingController.appendPage(newMovies, pageKey + 1);
    } catch(e) {
      pagingController.error = e.toString();
    }
  }

  void searchMovie(String value) {
    if (value.isEmpty) {
      _searching = false;
      notifyListeners();
    }
    _debounce?.cancel();
    if (value.length >= 3) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 800), () async {
        refreshMovieList(value);
      });

    }

  }

  void refreshMovieList(String value) async {
    final response = await _repository.searchMovieByName(value);
    if (!response.success) return;

    _movies = response.results ?? [];
    _searching = true;
    notifyListeners();
  }

}
