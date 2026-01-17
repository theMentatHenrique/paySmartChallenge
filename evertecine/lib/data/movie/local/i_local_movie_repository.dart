import 'package:evertecine/domain/model/movie.dart';
import 'package:evertecine/data/movie/i_movie_repository.dart';

abstract class ILocalMovieRepository extends IMovieRepository {
  Future<void> insert(List<Movie> movies);
}