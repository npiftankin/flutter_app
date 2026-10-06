import 'package:flutter_app/data/local/app_database.dart';
import 'package:flutter_app/data/repositories/like_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqliteLikeRepository extends LikeRepository {
  @override
  Future<List<int>> loadAll() async {
    final db = await AppDatabase.instance;
    final rows = await db.query(AppDatabase.likedTable);
    return rows.map((row) => row[AppDatabase.likedIdColumn] as int).toList();
  }

  @override
  Future<void> add(int id) async {
    final db = await AppDatabase.instance;
    await db.insert(AppDatabase.likedTable, {
      AppDatabase.likedIdColumn: id,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<void> remove(int id) async {
    final db = await AppDatabase.instance;
    await db.delete(
      AppDatabase.likedTable,
      where: '${AppDatabase.likedIdColumn} = ?',
      whereArgs: [id],
    );
  }
}
