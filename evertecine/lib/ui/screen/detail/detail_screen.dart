import 'package:evertecine/domain/model/Movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static final _IMAGE_URL = "https://image.tmdb.org/t/p/w500";
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Text(movie.title)),
      body: CenterContent(),
    );
  }



  Widget CardImage() {
    return AspectRatio(
      aspectRatio:  1,
      child: ClipRRect(
          child: Image.network(
            _IMAGE_URL + movie.posterPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
          )
      ),
    );
  }

  Widget CenterContent() {
    return Column(
      children: [
        CardImage(),
        Text(movie.overview),
        Text(movie.allGenres()),
        Text(movie.releaseDate),
      ],
    );
  }
}
