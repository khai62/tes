// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tes/pustaka.dart';

class DatabaseInstance {
  final String _databaseName = 'my_database'; // Nama database.
  final int _databaseVersion = 1; // Versi database.

  // Tabel produk dan kolom-kolomnya.
  final String tabel = 'produk';
  final String id = 'id';
  final String name = 'name';
  final String category = 'category';
  final String createAt = 'create_at';
  final String updateAt = 'update_at';

  // Variabel untuk menyimpan instance database.
  Database? _database;

  // fungsi untuk mengecek apakah database sudah ada atau belum
  Future<Database> database() async {
    if (_database != null)
      return _database!; // jika sudah ada pakai yg sudah ada
    _database = await _initDatabase(); //jika blm  ada buat databasenya
    return _database!;
  }

  // fungsi untuk membuat database
  Future _initDatabase() async {
    Directory documentDirectory =
        await getApplicationDocumentsDirectory(); // menentukan derektory mana database kita akan di simpan
    String path = join(documentDirectory.path,
        _databaseName); //gabungkan nama derektory dengan nama database kita
    return openDatabase(path,
        version: _databaseVersion, // Versi database.
        onCreate:
            _onCreate); // Menjalankan fungsi _onCreate ketika database dibuat.
  }

  //fungsi yang di jalankan ketika database di buat
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tabel ($id INTEGER PRIMARY KEY, $name TEXT NULL, $category TEXT NULL, $createAt TEXT NULL, $updateAt TEXT NUll)'); // Membuat tabel dalam database.
  }

  // Fungsi untuk mendapatkan semua data produk dari database.
  Future<List<ProdukModel>> all() async {
    final data = await _database!.query(
        tabel); // Melakukan query untuk mendapatkan semua data dari tabel.
    List<ProdukModel> result = data
        .map((e) => ProdukModel.fromJson(e))
        .toList(); // Mengubah hasil query menjadi list produk
    return result;
  }

  // Fungsi untuk menambahkan data ke dalam database.
  Future<int> insert(Map<String, dynamic> row) async {
    final query =
        await _database!.insert(tabel, row); // Menyisipkan data ke dalam tabel.
    return query; // Mengembalikan hasil dari operasi penyisipan.
  }

  // fungsi untuk updata
  Future<int> update(int idParam, Map<String, dynamic> row) async {
    final query = await _database!
        .update(tabel, row, where: '$id = ? ', whereArgs: [idParam]);
    return query;
  }

  //fungsi delete
  Future delete(int idParam) async {
    await _database!.delete(tabel, where: '$id = ? ', whereArgs: [idParam]);
  }

  // cek data id
  Future<bool> checkId(int id) async {
    final List<Map<String, dynamic>> result = await _database!.query(
      tabel,
      where: '$id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty;
  }

// cek nama di database
  Future<bool> checkName(String name) async {
    final List<Map<String, dynamic>> result = await _database!.query(
      tabel,
      where: '$name = ?',
      whereArgs: [name],
    );

    return result.isNotEmpty;
  }
}
