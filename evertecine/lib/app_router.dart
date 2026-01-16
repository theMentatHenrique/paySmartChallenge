import 'package:evertecine/network/service/MovieService.dart';
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
    ],
  );
}