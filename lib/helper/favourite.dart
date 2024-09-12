import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/quote_model.dart';

class DatabaseHelper {
  static DatabaseHelper databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  String databaseName = 'quotes.db';
  String favouritesTable = 'like';

  Database? _database;

  Future<Database?> get database async => _database ?? await initializeDatabase();

  Future<Database?> initializeDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, databaseName);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
      CREATE TABLE $favouritesTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      quote TEXT NOT NULL,
      author TEXT NOT NULL,
      category TEXT NOT NULL,
      isFavourite INTEGER DEFAULT 0
      )
      ''';
        db.execute(sql);
      },
    );
  }

  Future<int> insertFavoriteQuote(
      String quote, String author, String category, int isFavourite) async {
    final db = await database;
    String sql = '''
    INSERT INTO $favouritesTable (quote, author, category, isFavourite)
    VALUES (?, ?, ?, ?)
    ''';
    List args = [quote, author, category, isFavourite];
    return await db!.rawInsert(sql, args);
  }

  Future<List<QuotesModel>> fetchFavoriteQuotes() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $favouritesTable
    ''';
    final map = await db!.rawQuery(sql);
    return List.generate(
      map.length,
          (index) => QuotesModel.fromMap(map[index]),
    );
  }

  Future<int> removeFavoriteQuote(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $favouritesTable WHERE id = ?
    ''';
    List args = [id];
    return await db!.rawDelete(sql, args);
  }
}
