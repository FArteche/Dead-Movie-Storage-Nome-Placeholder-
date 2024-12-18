import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'movielist.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE filme (
        id INTEGER PRIMARY KEY,
        nomeFilme TEXT NOT NULL,
        posterPath TEXT NOT NULL,
        isAssistido INTEGER NOT NULL
      );''');
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
