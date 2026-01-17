import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final appRouter = AppRouter(preferences: sharedPreferences);
  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'EverteCine',
      routerConfig: appRouter.router,
    );
  }
}
