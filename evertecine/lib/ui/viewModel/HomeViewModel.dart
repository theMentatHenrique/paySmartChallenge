import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/domain/repository/CatalogRepository.dart';
import 'package:evertecine/network/service/MovieService.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeViewmodel extends ChangeNotifier {
  final UpcomingMoviesRepository _repository;

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
}
