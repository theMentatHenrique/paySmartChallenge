import 'package:evertecine/ui/components/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

import '../../domain/model/Movie.dart';

class MovieCardItem extends StatelessWidget {
  final Movie movie;
  static final _IMAGE_URL = "https://image.tmdb.org/t/p/w500";

  MovieCardItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CardContent(),
      onTap: () {
        context.push('/details', extra: movie);
      },
    );
  }

  Widget CardContent() {
    return Card(
      color: Colors.blue,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 120,
        child: Row (
          children: [
            // imagem
            AspectRatio(
              aspectRatio:  1,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    _IMAGE_URL + movie.posterPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                  )
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
                    style: AppTextStyles.CategoryTitle,
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
            )
          ],
        ),
        color: AppColors.surface,
      ),
    );
  }

}