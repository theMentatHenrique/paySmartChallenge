class Movie {
  final int id;
  final String name;
  final String posterImage;
  final List<String> genres;
  final String overView;
  final String releaseDate;


  Movie({
    required this.id,
    required this.name,
    required this.posterImage,
    required this.genres,
    required this.overView,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json, Map<int, String> allGenres) {
    return Movie(
      id: json['id'] ?? 0,
      name: json['title'] ?? '',
      posterImage: json['poster_path'] ?? '',
      genres: convertGenres(allGenres, List<int>.from(json['genre_ids'] ?? [])),
      overView: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
    );
  }

  static List<String> convertGenres(Map<int, String> allGenres, List<int> movieGenres) {
    return movieGenres.map((id) => allGenres[id] ?? '').toList();
  }

  String allGenres() {
    return genres.join(", ");
  }

}