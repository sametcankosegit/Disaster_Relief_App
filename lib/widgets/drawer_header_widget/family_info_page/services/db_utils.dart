import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/family_member.dart';

class DbUtils {
  static final DbUtils _dbUtils = DbUtils._internal();

  DbUtils._internal();

  factory DbUtils() {
    return _dbUtils;
  }

  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String path = join(await getDatabasesPath(), 'familia_database.db');
    var dbFamilyMembers =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return dbFamilyMembers;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE family_members(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)");
  }

  Future<void> deleteTable() async {
    final Database? db = await this.db;
    db?.delete('family_members');
  }

  Future<void> insertFamilyMember(FamilyInfo member) async {
    final Database? db = await this.db;
    await db?.insert(
      'family_members',
      member.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FamilyInfo>> members() async {
    // Get a reference to the database.
    final Database? db = await this.db;

    final List<Map<String, Object?>>? maps = await db?.query('family_members');

    return List.generate(maps!.length, (i) {
      return FamilyInfo(
        id: int.parse(maps[i]['id'].toString()),
        name: maps[i]['name'].toString(),
        age: int.parse(maps[i]['age'].toString()),
      );
    });
  }

  Future<void> updateFamilyMember(FamilyInfo member) async {
    final db = await this.db;
    await db?.update(
      'family_members',
      member.toMap(),
      where: "id = ?",
      whereArgs: [member.id],
    );
  }

  Future<void> deleteFamilyMember(int id) async {
    final db = await this.db;
    await db?.delete(
      'family_members',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
