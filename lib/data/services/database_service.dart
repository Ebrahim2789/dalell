import 'dart:async';
import 'package:dalell/data/models/product.dart';
import 'package:dalell/utils/result.dart';
import 'package:path/path.dart';
//in main.dart write this:
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class DatabaseService {
  DatabaseService({required this.databaseFactory});

  final DatabaseFactory databaseFactory;

  // #docregion Table
  static const _kTableProduct = 'Product';
  static const _kColumnId = '_id';
  static const _kColumnTask = 'task';
  // #enddocregion Table

  Database? _database;

  bool isOpen() => _database != null;

  // #docregion Open
  Future<void> open() async {
    _database = await databaseFactory.openDatabase(
      join(await databaseFactory.getDatabasesPath(), 'app_database.db'),
      options: OpenDatabaseOptions(
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE $_kTableProduct($_kColumnId INTEGER PRIMARY KEY AUTOINCREMENT, $_kColumnTask TEXT)',
          );
        },
        version: 1,
      ),
    );
  }
  // #enddocregion Open

  // #docregion Insert
  Future<Result<Product>> insert(String task) async {
    try {
      final id = await _database!.insert(_kTableProduct, {_kColumnTask: task});
      return Result.ok(Product(id: id, description: task,name: '',price: 0,imageUrl: ''));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
  // #enddocregion Insert

  // #docregion GetAll
  Future<Result<List<Product>>> getAll() async {
    try {
      final entries = await _database!.query(
        _kTableProduct,
        columns: [_kColumnId, _kColumnTask],
      );
      final list = entries
          .map(
            (element) => Product(
              id: element[_kColumnId] as int,
              description: element[_kColumnTask] as String, name: '', price: 0, imageUrl: '',
            ),
          )
          .toList();
      return Result.ok(list);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
  // #enddocregion GetAll

  // #docregion Delete
  Future<Result<void>> delete(int id) async {
    try {
      final rowsDeleted = await _database!.delete(
        _kTableProduct,
        where: '$_kColumnId = ?',
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

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}