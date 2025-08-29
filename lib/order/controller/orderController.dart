// controllers/address_controller.dart
import 'dart:core';

import 'package:dalell/order/models/order.dart';
import 'package:dalell/product/models/database_helper.dart';
import 'package:sqflite/sqflite.dart';



class OrderController {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertOrder(Order order) async {
    final db = await dbHelper.database;
    return await db.insert('orders', order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Order>> getAllOrders() async {
    final db = await dbHelper.database;
    final result = await db.query('orders');
    return result.map((map) => Order.fromMap(map)).toList();
  }

  Future<int> updateOrder(Order order) async {
    final db = await dbHelper.database;
    return await db.update('orders', order.toMap(),
        where: 'id = ?', whereArgs: [order.id]);
  }

  Future<int> deleteOrder(String id) async {
    final db = await dbHelper.database;
    return await db.delete('orders', where: 'id = ?', whereArgs: [id]);
  }
}
