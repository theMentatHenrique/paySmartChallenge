import 'package:evertecine/ui/components/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/model/movie.dart';

class MovieCardItem extends StatelessWidget {
  final Movie movie;
  static final imageUrl = "https://image.tmdb.org/t/p/w500";

  const MovieCardItem({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: cardContainer(),
      onTap: () {
        context.push('/details', extra: movie);
      },
    );
  }

  Widget cardContainer() {
    return Card(
      color: Colors.blue,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 120,
        color: AppColors.surface,
        child: Row(
          children: [
            // imagem
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  imageUrl + movie.posterPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // texts
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: AppTextStyles.titleMain,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.genres.isEmpty ? 'Unknow' : movie.genres[0],
                    style: AppTextStyles.categoryTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    movie.releaseDate,
                    style: AppTextStyles.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
