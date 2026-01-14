import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/domain/repository/CatalogRepository.dart';
import 'package:flutter/cupertino.dart';

class Homeviewmodel extends ChangeNotifier{
  final CatalogRepository repository;
  bool _isLoading = false;
  String? _errorMessage;
  List<Movie> _movies = [];

  Homeviewmodel({required this.repository});


  Future<void> loadUpcomingMovies() async {
    _isLoading = true;
    _errorMessage = null;

  }


  _updateLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

}