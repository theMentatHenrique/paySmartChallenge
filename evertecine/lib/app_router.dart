import 'package:evertecine/data/movie/MovieService.dart';
import 'package:evertecine/data/movie/local/LocalMovieRepositoryImpl.dart';
import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/data/movie/network/NetworkMoviesRepositoryImpl.dart';
import 'package:evertecine/ui/screen/detail/detail_screen.dart';
import 'package:evertecine/ui/screen/home/homeScreen.dart';
import 'package:evertecine/ui/viewModel/HomeViewModel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  final SharedPreferences _preferences;

  AppRouter({required preferences}) : _preferences = preferences;

  late final GoRouter  router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => HomeViewmodel(repository: MovieService(localRepo: LocalMovieRepositoryImpl(), networkRepo: NetworkMoviesRepositoryImpl(), prefs: _preferences)),
          child: const HomeScreen(),
        ),
      ),
      GoRoute(path: '/details',
          builder: (context, state) {
          return DetailScreen(movie: state.extra as Movie);
      })
    ],
  );
}