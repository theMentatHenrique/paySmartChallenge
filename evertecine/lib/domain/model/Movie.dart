class Movie {
  final int id;
  final String name;
  final String posterImage;
  final List<int> genreIds;
  final String overView;
  final String releaseDate;


  Movie({
    required this.id,
    required this.name,
    required this.posterImage,
    required this.genreIds,
    required this.overView,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      name: json['title'] ?? '',
      posterImage: json['poster_path'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      overView: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
    );
  }

}