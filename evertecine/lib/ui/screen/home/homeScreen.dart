import 'package:evertecine/ui/components/movie_search_list.dart';
import 'package:evertecine/ui/screen/home/movie_list.dart';
import 'package:evertecine/ui/viewModel/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewmodel>();

    return Scaffold(
      appBar: AppBar(
        title: _customSearchTextField(viewModel.searchMovie),
      ),
      body: viewModel.searching ? MovieSearchList() : MovieList(),
    );
  }

  Widget _customSearchTextField(void Function(String) onChange) {
    return TextField(
      onChanged: onChange,
      decoration: const InputDecoration(
        hintText: 'Search movies...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}



