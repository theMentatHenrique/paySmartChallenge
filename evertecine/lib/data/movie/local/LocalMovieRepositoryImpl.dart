import 'package:evertecine/data/movie/local/ILocalMovieRepository.dart';
import 'package:evertecine/data/movie/local/MovieDatabaseFactory.dart';
import 'package:evertecine/domain/model/Movie.dart';
import 'package:evertecine/network/core/BaseNetworkResponse.dart';
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
  Future<BaseNetworkResponse<Movie>> getUpcomingMovies({int page = 1}) async {
    try {
      final db = await _dataBase.database;
      if (!db.isOpen) return BaseNetworkResponse(success: false, message: "DATABASE IS CLOSED", statusCode: 500);

      final List<Map<String, dynamic>> maps = await db.rawQuery('''
        SELECT * FROM movie ORDER BY id DESC LIMIT 20  ''');
      if (maps.isEmpty) return BaseNetworkResponse(success: false, message: "DATABASE return nothing", statusCode: 204);

      final movies = maps.map((m) => Movie.fromLocalDataBase(m)).toList().reversed.toList();
      if (movies.isEmpty) return BaseNetworkResponse(success: false, message: "No movies found", statusCode: 204);

      return BaseNetworkResponse<Movie>(
        success: true,
        statusCode: 200,
        results: movies,
      );
    } catch(e) {
      return BaseNetworkResponse(success: false, message: e.toString());
    }

  }
}