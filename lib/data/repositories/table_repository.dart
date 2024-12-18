import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_app/data/models/assignment_model.dart';

class TableRepository {
  late Database db;

  Future<void> init() async {
    final dbPath = join(await getDatabasesPath(), 'restaurant.db');
    // await deleteDatabase(dbPath);

    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE tables(id INTEGER PRIMARY KEY, name TEXT, status TEXT)',
        );
        await db.execute(
          'CREATE TABLE assignments(id INTEGER PRIMARY KEY AUTOINCREMENT, tableName TEXT, waiterName TEXT)',
        );
      },
    );
  }



  Future<void> assignWaiter(String table, String waiter) async {
    try {
      // Попробуйте сначала проверить, существует ли запись для данного стола
      final List<Map<String, dynamic>> existing = await db.query(
        'assignments',
        where: 'tableName = ?',
        whereArgs: [table],
      );

      if (existing.isNotEmpty) {
        // Если запись существует, обновляем её
        await db.update(
          'assignments',
          {'waiterName': waiter},
          where: 'tableName = ?',
          whereArgs: [table],
        );
      } else {
        // Если записи нет, добавляем новую
        await db.insert(
          'assignments',
          {'tableName': table, 'waiterName': waiter},
        );
      }
    } catch (e) {
      print('Ошибка при назначении официанта: $e');
      throw Exception(e);
    }
  }

  Future<List<AssignmentModel>> getAssignments() async {
    final List<Map<String, dynamic>> maps = await db.query('assignments');
    return List.generate(maps.length, (i) {
      return AssignmentModel.fromMap(maps[i]);
    });
  }
}
