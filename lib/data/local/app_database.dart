import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const String likedTable = 'liked';
  static const String likedIdColumn = 'property_id';

  static Database? _database;

  static Future<Database> get instance async => _database ??= await _open();

  static Future<Database> _open() async {
    final String path = join(await getDatabasesPath(), 'cityhome.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) =>
          db.execute('CREATE TABLE $likedTable ($likedIdColumn INTEGER PRIMARY KEY)'),
    );
  }
}
