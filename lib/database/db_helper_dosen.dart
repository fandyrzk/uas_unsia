
import 'package:tugas_crud_unsia/model/dosen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

/**
 * Nama: Devi Ardiana
 * NIM: 220101020015
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class DbHelperDosen {
  static final DbHelperDosen _instance = DbHelperDosen._internal();
  static Database? _database;

  final String tableName = 'tableDosen';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnEmail = 'email';

  DbHelperDosen._internal();
  factory DbHelperDosen() => _instance;

  //cek apakah database ada
  Future<Database?> get _db  async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'dosen.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // create table
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNama TEXT," "$columnEmail TEXT)";
    await db.execute(sql);
  }

  // insert
  Future<int?> saveDosen(Dosen dosen) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, dosen.toMap());
  }

  // read
  Future<List?> getAllDosen() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId, columnNama, columnEmail
    ]);

    return result.toList();
  }

  //update
  Future<int?> updateDosen(Dosen dosen) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, dosen.toMap(), where: '$columnId = ?', whereArgs: [dosen.id]);
  }

  //delete
  Future<int?> deleteDosen(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}