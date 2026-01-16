import 'package:evertecine/ui/viewModel/HomeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../../domain/model/Movie.dart';
import '../../components/movie_card_list.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final PagingController<int, Movie> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<HomeViewmodel>().loadUpcomingMovies(pageKey, _pagingController);
    },);
  }

  @override
  void dispose() {
    // Avoiding memory leak
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
        pagingController: _pagingController,
        separatorBuilder: (context, index) => const Divider(),
        builderDelegate: PagedChildBuilderDelegate<Movie>(
            itemBuilder: (context, movie, index) => MovieCardList(movie: movie),
            firstPageProgressIndicatorBuilder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          newPageErrorIndicatorBuilder: (_) => const Center(child: Padding(padding: EdgeInsetsGeometry.all(16), child: CircularProgressIndicator(),),),
          firstPageErrorIndicatorBuilder: (_) => const Center(child: Text('Occours error'),)
        ),
    );

  }
}