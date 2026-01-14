import 'package:evertecine/ui/components/movie_card_list.dart';
import 'package:evertecine/ui/viewModel/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<Homeviewmodel>();

    return Scaffold(
      body: Center(
        child: movieList(context),
      ),
    );
  }
}



final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

Widget movieList(BuildContext context) {
  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: entries.length,
    itemBuilder: (BuildContext context, int index) {
      return MovieCardList();
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );
}

