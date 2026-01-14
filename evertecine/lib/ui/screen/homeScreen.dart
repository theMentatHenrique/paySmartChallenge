import 'package:evertecine/domain/model/Movie.dart';
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
      body: content(context, viewModel),
    );
  }
}


Widget content(BuildContext context, Homeviewmodel vm) {
  return vm.isLoadingData()
      ? Center(child: CircularProgressIndicator())
      : movieList(context, vm.getMovieList() );
}

Widget movieList(BuildContext context, List<Movie> movies) {
  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: movies.length,
    itemBuilder: (BuildContext context, int index) {
      return MovieCardList(movie: movies[index]);
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );
}

