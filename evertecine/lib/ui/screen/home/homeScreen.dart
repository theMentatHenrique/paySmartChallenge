import 'package:evertecine/ui/components/movie_search_list.dart';
import 'package:evertecine/ui/components/styles.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor:AppColors.background,
        title: _customSearchTextField(viewModel.searchMovie),
      ),
      body: viewModel.searching ? MovieSearchList() : MovieList(),
    );
  }

  Widget _customSearchTextField(void Function(String) onChange) {
    return TextField(
      onChanged: onChange,
      style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: 'Search movies...',
        hintStyle: AppTextStyles.body,
        filled: true,
        fillColor: AppColors.surface,
        prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.5),
            width: 1.0,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2.0,
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}



