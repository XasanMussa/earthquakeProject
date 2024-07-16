import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notifications.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, subtitle TEXT, details TEXT, date TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertNotification(Map<String, String> notification) async {
    final db = await database;
    await db.insert(
      'notifications',
      notification,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getNotifications() async {
    final db = await database;
    return await db.query('notifications');
  }

  Future<void> clearNotifications() async {
    final db = await database;
    await db.delete('notifications');
  }
}
