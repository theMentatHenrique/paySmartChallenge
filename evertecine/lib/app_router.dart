import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/data/movie/MoviesRepository.dart';
import 'package:evertecine/ui/screen/detail/detail_screen.dart';
import 'package:evertecine/ui/screen/home/homeScreen.dart';
import 'package:evertecine/ui/viewModel/HomeViewModel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static GoRouter get router => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => HomeViewmodel(repository: MoviesRepository()),
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