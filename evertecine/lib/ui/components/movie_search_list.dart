import 'package:evertecine/domain/model/movie.dart';
import 'package:evertecine/ui/components/movie_card_item.dart';
import 'package:evertecine/ui/viewModel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchList extends StatelessWidget {
  const MovieSearchList({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewmodel viewmodel = context.read<HomeViewmodel>();
    List<Movie> movies = viewmodel.movies;

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        return MovieCardItem(movie: movies[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
