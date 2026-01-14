import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/domain/repository/CatalogRepository.dart';
import 'package:evertecine/network/core/BaseNetworkResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Homeviewmodel extends ChangeNotifier {
  final UpcomingMoviesRepository repository;
  HomeState homeState = HomeState();

  Homeviewmodel({required this.repository});


  Future<void> loadUpcomingMovies() async {
    try {
      BaseNetworkResponse<Movie> response = await repository.getUpcomingMovies();
      if (!response.success) {
        homeState.errorMessage = response.message ?? "Unknow error";
        homeState.loading = false;
        return;
      }
      homeState.errorMessage = "";
      homeState.loading = false;
      homeState.movies = response.results ?? [];

    } catch(e) {
      homeState.errorMessage = e.toString();
      homeState.loading = false;
    } finally {
      notifyListeners();
    }
  }

  bool isLoadingData() {
    return homeState.loading;
  }

  List<Movie> getMovieList() {
    return homeState.movies;
  }
}

class HomeState {
  List<Movie> movies = [];
  bool loading = true;
  String errorMessage = "";
}