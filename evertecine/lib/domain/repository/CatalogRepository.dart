
import 'package:evertecine/network/core/BaseNetworkResponse.dart';

import '../model/Movie.dart';

abstract class CatalogRepository {
  Future<BaseNetworkResponse<Movie>> getUpcomingMovies();
}