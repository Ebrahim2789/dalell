// product_repository.dart

import 'package:dalell/product/models/basemodel.dart';
import 'package:dalell/product/models/database_helper.dart';
import 'package:dalell/utils/result.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GenericRepository<T extends Basemodel> {

  final String tableName;
  final T Function(Map<String, dynamic>) fromMap;
 final dbHelper = DatabaseHelper.instance;

  GenericRepository({ required this.tableName, required this.fromMap});

  /// singleton pattern

  static Database? _database;


  /// gets database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
        final db = await dbHelper.database;
 
    return db;
  }

  // #docregion Insert
  Future<Result<int>> insert(T items) async {
    try {

      final id = await _database!.insert(tableName, items.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return Result.ok(id);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  // #docregion Delete
  Future<Result<void>> delete(int id) async {
    try {
      final rowsDeleted = await _database!.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      if (rowsDeleted == 0) {
        return Result.error(Exception('No Product found with id $id'));
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
  // #enddocregion Delete


  // #docregion rowsUpdate
  Future<Result<void>> update(T items) async {
    try {
      final rowsUpdate= await _database!.update(
        tableName,
        items.toMap(),
        where: 'id = ?',
        whereArgs: [items.id],
      );
      if (rowsUpdate == 0) {
        return Result.error(Exception('No Product found with id $items.id'));
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
  // #enddocregion rowsUpdate
  Future<Result<T?>> getById(int id) async {
    try {
      final maps = await _database?.query(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      return Result.ok(fromMap(maps!.first));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  // #docregion GetAll
  Future<Result<List<T>>> getAll() async {
    try {
      final List<Map<String, dynamic>> maps = await _database!.query(tableName);
      final list = List.generate(maps.length, (i) => fromMap(maps[i]));
      return Result.ok(list);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
  // #enddocregion GetAll


}


