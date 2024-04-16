// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tes/pustaka.dart';

class DatabaseDB {
  final String databaseName = 'cobalagi';
  final int _databaseVersion = 3;

  final String tabel = 'cobaa';
  final String id = 'id';
  final String name = 'name';
  final String text = 'text';
  final String image = 'image';
  // final dynamic height = 'height';

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tabel ($id INTEGER PRIMARY KEY, $name TEXT NULL, $text TEXT NULL, $image TEXT NULL )'); // Membuat tabel dalam database.
  }

  Future<List<Category>> all() async {
    final data = await _database!.query(tabel);
    List<Category> result = data.map((e) => Category.fromJson(e)).toList();
    return result;
  }

// fungsi insert 
  Future<int> insert(Map<String, dynamic> row) async {
    final existingRows = await _database!
        .query(tabel, where: '$name = ?', whereArgs: [row[name]]);

    if (existingRows.isEmpty) {
      final query = await _database!.insert(tabel, row);
      return query;
    } else {
      print('data sudah ada di database');
      return -1;
    }
  }

  //fungsi delete
  Future delete(int idParam) async {
    await _database!.delete(tabel, where: '$id = ? ', whereArgs: [idParam]);
  }


}
