import 'dart:async';

import 'package:evertecine/data/movie/movie_service.dart';
import 'package:evertecine/domain/model/movie.dart';
import 'package:evertecine/data/movie/i_movie_repository.dart';
import 'package:evertecine/data/movie/network/network_movies_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeViewmodel extends ChangeNotifier {
  final MovieService _service;

  bool _searching = false;
  bool get searching => _searching ;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;


  Timer? _debounce;

  HomeViewmodel({required MovieService repository}) : _service = repository;


  Future<void> loadUpcomingMovies(int pageKey, PagingController<int, Movie> pagingController) async {
    try {
      final response = await _service.getUpcomingMovies(pageKey);
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
    final response = await _service.searchMovieByName(value);
    if (!response.success) return;

    _movies = response.results ?? [];
    _searching = true;
    notifyListeners();
  }

}
