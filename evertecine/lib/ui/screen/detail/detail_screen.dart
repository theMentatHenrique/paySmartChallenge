import 'package:evertecine/domain/model/movie.dart';
import 'package:evertecine/ui/components/movie_card_item.dart';
import 'package:flutter/material.dart';
import '../../components/styles.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    MovieCardItem.imageUrl + movie.posterPath,
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.background],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: AppTextStyles.titleMain),
                  const SizedBox(height: 32),
                  Text(
                    movie.releaseDate,
                    style: AppTextStyles.body.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Text(movie.overview, style: AppTextStyles.titleMain),

                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 8,
                    children: movie.genres
                        .toList()
                        .map(
                          (genre) => Chip(
                            backgroundColor: AppColors.surface,
                            label: Text(
                              genre,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            side: BorderSide(
                              color: AppColors.primary.withOpacity(0.3),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
