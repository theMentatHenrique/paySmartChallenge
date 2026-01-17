import 'package:evertecine/data/movie/i_movie_repository.dart';

import '../../../domain/model/movie.dart';
import '../../../network/core/base_network_response.dart';

abstract class Inetworkmovierepository extends IMovieRepository{
  Future<BaseAPIResponse<Movie>> searchMovieByName(String value);
}