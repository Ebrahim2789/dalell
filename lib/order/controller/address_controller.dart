// controllers/address_controller.dart

import 'package:dalell/order/models/address.dart';
import 'package:dalell/order/models/order.dart';
import 'package:dalell/product/models/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class AddressController {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertAddress(Address address) async {
    final db = await dbHelper.database;
    return await db.insert('addresses', address.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Address>> getAllAddresses() async {
    final db = await dbHelper.database;
    final result = await db.query('addresses');
    return result.map((map) => Address.fromMap(map)).toList();
  }

  Future<int> updateAddress(Address address) async {
    final db = await dbHelper.database;
    return await db.update('addresses', address.toMap(),
        where: 'id = ?', whereArgs: [address.id]);
  }

  Future<int> deleteAddress(String id) async {
    final db = await dbHelper.database;
    return await db.delete('addresses', where: 'id = ?', whereArgs: [id]);
  }

Future<int> insertOrder(Order order) async {
  final db = await dbHelper.database;
  return await db.insert('orders', order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}
}
