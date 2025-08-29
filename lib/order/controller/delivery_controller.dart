// models/order.dart

import 'package:dalell/order/models/order.dart';
import 'package:dalell/product/models/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DeliveryController {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertDelivery(Delivery delivery) async {
    final db = await dbHelper.database;
    return await db.insert('deliveries', delivery.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Delivery>> getAllDeliveries() async {
    final db = await dbHelper.database;
    final result = await db.query('deliveries');
    return result.map((map) => Delivery.fromMap(map)).toList();
  }

  Future<int> updateDelivery(Delivery delivery) async {
    final db = await dbHelper.database;
    return await db.update('deliveries', delivery.toMap(),
        where: 'id = ?', whereArgs: [delivery.id]);
  }

  Future<int> deleteDelivery(String id) async {
    final db = await dbHelper.database;
    return await db.delete('deliveries', where: 'id = ?', whereArgs: [id]);
  }
}
