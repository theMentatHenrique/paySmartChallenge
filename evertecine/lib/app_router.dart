import 'package:evertecine/data/movie/movie_service.dart';
import 'package:evertecine/data/movie/local/local_movie_repository_impl.dart';
import 'package:evertecine/domain/model/movie.dart';
import 'package:evertecine/data/movie/network/network_movies_repository_impl.dart';
import 'package:evertecine/ui/screen/detail/detail_screen.dart';
import 'package:evertecine/ui/screen/home/home_screen.dart';
import 'package:evertecine/ui/viewModel/home_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  final SharedPreferences _preferences;

  AppRouter({required SharedPreferences preferences})
    : _preferences = preferences;

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => HomeViewmodel(
            repository: MovieService(
              localRepo: LocalMovieRepositoryImpl(),
              networkRepo: NetworkMoviesRepositoryImpl(),
              prefs: _preferences,
            ),
          ),
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) {
          return DetailScreen(movie: state.extra as Movie);
        },
      ),
    ],
  );
}
