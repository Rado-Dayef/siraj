import 'dart:convert';

import 'package:path/path.dart';
import 'package:siraj/data/models/azkar_model.dart';
import 'package:siraj/data/models/zekr_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseServices {
  static Database? _db;

  static const String dbName = "azkar.db";
  static const int dbVersion = 1;

  static const String morningTable = "morningAzkar";
  static const String eveningTable = "eveningAzkar";
  static const String wakingUpTable = "wakingUpAzkar";
  static const String sleepingTable = "sleepingAzkar";

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) async {
        await _createTable(db, wakingUpTable);
        await _createTable(db, morningTable);
        await _createTable(db, eveningTable);
        await _createTable(db, sleepingTable);
      },
    );
  }

  static Future<void> _createTable(Database db, String tableName) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        tableName TEXT NOT NULL,
        subTitle TEXT NOT NULL,
        count INTEGER NOT NULL,
        azkar TEXT NOT NULL   -- JSON string of ZekrModel list
      )
    ''');
  }

  static Future<int> insert(String table, AzkarModel model) async {
    final db = await database;
    final data = {"tableName": table, "title": model.title, "subTitle": model.subTitle, "count": model.count, "azkar": jsonEncode(model.azkar.map((e) => e.toJson()).toList())};

    return await db.insert(table, data);
  }

  static Future<List<AzkarModel>> getAll(String table) async {
    final db = await database;
    final result = await db.query(table);

    return result.map((row) {
      final azkarList = (jsonDecode(row["azkar"] as String) as List).map((e) => ZekrModel.fromJson(e)).toList();

      return AzkarModel(count: row["count"] as int, title: row["title"] as String, subTitle: row["subTitle"] as String, azkar: azkarList, tableName: row["tableName"] as String);
    }).toList();
  }

  static Future<int> update(String table, AzkarModel model) async {
    final db = await database;

    final data = {"tableName": table, "title": model.title, "subTitle": model.subTitle, "count": model.count, "azkar": jsonEncode(model.azkar.map((e) => e.toJson()).toList())};

    return await db.update(table, data);
  }

  static Future<int> delete(String table, int id) async {
    final db = await database;
    return await db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  static Future<void> deleteAll(String table) async {
    final db = await database;
    await db.delete(table);
  }
}
