
import 'package:evertecine/network/core/BaseNetworkResponse.dart';

import '../model/Movie.dart';

abstract class UpcomingMoviesRepository {
  Future<BaseNetworkResponse<Movie>> getUpcomingMovies({int page = 1});
}