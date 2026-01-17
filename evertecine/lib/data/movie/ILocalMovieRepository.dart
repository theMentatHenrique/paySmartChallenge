import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/data/movie/ImovieRepository.dart';

abstract class Ilocalmovierepository extends IMovieRepository {
  void insert(List<Movie> movies);
}