import 'package:evertecine/data/movie/local/i_local_movie_repository.dart';
import 'package:evertecine/data/movie/local/movie_database_factory.dart';
import 'package:evertecine/domain/model/movie.dart';
import 'package:evertecine/network/core/base_network_response.dart';
import 'package:sqflite/sqflite.dart';

class LocalMovieRepositoryImpl implements ILocalMovieRepository {
  final MovieDatabaseFactory _dataBase = MovieDatabaseFactory.instance;

  @override
  Future<void> insert(List<Movie> movies) async {
    final db = await _dataBase.database;
    final batch = db.batch();

    for (var movie in movies) {
      batch.insert(
        'movie',
        movie.toMap(),
        //update if exist
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<BaseAPIResponse<Movie>> getUpcomingMovies({int page = 1}) async {
    try {
      final db = await _dataBase.database;
      if (!db.isOpen) return BaseAPIResponse(success: false, message: "DATABASE IS CLOSED", statusCode: 500);

      final List<Map<String, dynamic>> maps = await db.rawQuery('''
        SELECT * FROM movie ORDER BY id DESC LIMIT 20  ''');
      if (maps.isEmpty) return BaseAPIResponse(success: false, message: "DATABASE return nothing", statusCode: 204);

      final movies = maps.map((m) => Movie.fromLocalDataBase(m)).toList().reversed.toList();
      if (movies.isEmpty) return BaseAPIResponse(success: false, message: "No movies found", statusCode: 204);

      return BaseAPIResponse<Movie>(
        success: true,
        statusCode: 200,
        results: movies,
      );
    } catch(e) {
      return BaseAPIResponse(success: false, message: e.toString());
    }

  }
}