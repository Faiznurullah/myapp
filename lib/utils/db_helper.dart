import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/restaurant.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> _initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'favorites.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id TEXT PRIMARY KEY, name TEXT, city TEXT, pictureId TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await DBHelper.database;
    await db.insert('favorites', restaurant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> removeFavorite(String id) async {
    final db = await DBHelper.database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await DBHelper.database;
    return db.query('favorites');
  }
}
