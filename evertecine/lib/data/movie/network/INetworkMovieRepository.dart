import 'package:evertecine/data/movie/IMovieRepository.dart';

import '../../../domain/model/Movie.dart';
import '../../../network/core/BaseNetworkResponse.dart';

abstract class Inetworkmovierepository extends IMovieRepository{
  Future<BaseNetworkResponse<Movie>> searchMovieByName(String value);
}