
import 'package:evertecine/network/core/BaseNetworkResponse.dart';

import '../../domain/model/Movie.dart';

abstract class IMovieRepository {
  Future<BaseNetworkResponse<Movie>> getUpcomingMovies({int page = 1});
}

