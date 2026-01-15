import 'package:evertecine/domain/model/Movie.dart';

class HomeState {
  final List<Movie> movies;
  final bool loading;    
  final bool paging;     
  final String? errorMessage;
  final int actualPage;

  HomeState({
    this.movies = const [],
    this.loading = true,
    this.paging = false,
    this.errorMessage,
    this.actualPage = 1,
  });

 
  HomeState copyWith({
    List<Movie>? movies,
    bool? loading,
    bool? paging,
    String? errorMessage,
    int? actualPage,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
      loading: loading ?? this.loading,
      paging: paging ?? this.paging,
      errorMessage: errorMessage ?? this.errorMessage,
      actualPage: actualPage ?? this.actualPage,
    );
  }
}