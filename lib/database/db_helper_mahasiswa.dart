
import 'package:tugas_crud_unsia/model/mahasiswa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

/**
 * Nama: Fandy Rizky
 * NIM: 220101020038
 * Kelas: SI701
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class DbHelperMahasiswa {
  static final DbHelperMahasiswa _instance = DbHelperMahasiswa._internal();
  static Database? _database;

  final String tableName = 'tableMahasiswa';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnNip = 'nip';
  final String columnEmail = 'email';
  final String columnProdi = 'prodi';

  DbHelperMahasiswa._internal();
  factory DbHelperMahasiswa() => _instance;

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
    String path = join(databasePath, 'mahasiswa.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // create table
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNama TEXT," "$columnNip TEXT," "$columnEmail TEXT,"
        "$columnProdi TEXT)";
    await db.execute(sql);
  }

  // insert
  Future<int?> saveMahasiswa(Mahasiswa mahasiswa) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, mahasiswa.toMap());
  }

  // read
  Future<List?> getAllMahasiswa() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId, columnNama, columnProdi, columnNip, columnEmail
    ]);

    return result.toList();
  }

  //update
  Future<int?> updateMahasiswa(Mahasiswa mahasiswa) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, mahasiswa.toMap(), where: '$columnId = ?', whereArgs: [mahasiswa.id]);
  }

  //delete
  Future<int?> deleteMahasiswa(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}