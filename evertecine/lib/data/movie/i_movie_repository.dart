
import 'package:evertecine/network/core/base_network_response.dart';

import '../../domain/model/movie.dart';

abstract class IMovieRepository {
  Future<BaseAPIResponse<Movie>> getUpcomingMovies({int page = 1});
}

