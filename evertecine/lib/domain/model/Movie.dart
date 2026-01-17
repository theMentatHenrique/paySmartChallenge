class Movie {
  final int id;
  final String title;
  final String posterPath;
  final List<String> genres;
  final String overview;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.genres,
    required this.overview,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json, Map<int, String> allGenres) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      genres: convertGenres(allGenres, List<int>.from(json['genre_ids'] ?? [])),
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
    );
  }

  static List<String> convertGenres(Map<int, String> allGenres, List<int> movieGenres) {
    return movieGenres.map((id) => allGenres[id] ?? '').toList();
  }

  static List<String> separeteGenres(String movies) {
    return movies.split(',');
  }

  String allGenres() {
    return genres.join(", ");
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'genres': allGenres() ,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      releaseDate: map['release_date'],
      genres: separeteGenres(map['genres']),
    );
  }

}