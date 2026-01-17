import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/data/movie/IMovieRepository.dart';

abstract class ILocalMovieRepository extends IMovieRepository {
  void insert(List<Movie> movies);
}