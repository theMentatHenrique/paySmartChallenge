import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MovieDatabaseFactory {
  static final MovieDatabaseFactory instance = MovieDatabaseFactory._init();
  static Database? _database;

  MovieDatabaseFactory._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cine_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movie (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        poster_path TEXT,
        overview TEXT NOT NULL,
        release_date TEXT NOT NULL,
        genres TEXT NOT NULL
      )
    ''');
  }
}

