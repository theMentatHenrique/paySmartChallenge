import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/model/Movie.dart';

class MovieCardList extends StatelessWidget {
  final Movie movie;
  static final _IMAGE_URL = "https://image.tmdb.org/t/p/w500";

  MovieCardList({required this.movie});

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(8),
        child: Row (
          children: [
            // imagem
            AspectRatio(
              aspectRatio:  1,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _IMAGE_URL + movie.posterImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                  )
              ),
            ),
            const SizedBox(width: 16),
            // texts
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.genres[0],
                    style: TextStyle(color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    movie.releaseDate,
                    style: TextStyle(color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
        color: Colors.red,
      ),
    );
  }

}