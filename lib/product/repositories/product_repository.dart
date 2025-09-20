// product_repository.dart

import 'dart:core';

import 'package:dalell/product/models/database_helper.dart';
import 'package:dalell/product/models/product.dart';
import 'package:dalell/product/models/media.dart';

class ProductRepository {
  final dbHelper = DatabaseHelper.instance;



  Future<int> insertProduct(Product product) async {
    final db = await dbHelper.database;
    return await db.insert('product', product.toMap());
  }

  Future<List<Product>> getAllProductsWithMedia() async {
    final db = await dbHelper.database;

    // Get all products
    final productResult = await db.query('products');

    List<Product> products = [];

    for (var prodMap in productResult) {
      // Get product media
      final mediaResult = await db.query(
        'media',
        where: 'productId = ?',
        whereArgs: [prodMap['id']],
      );

        List<Media> mediaList = mediaResult.map((e) => Media.fromMap(e)).toList();
      products.add(Product.fromMap(prodMap, media: mediaList, ));


    }

    return products;
  }




  Future<Product?> getProductById(String id) async {
    final db = await dbHelper.database;
    final result =
        await db.query('products', where: 'id = ?', whereArgs: [id], limit: 1);
    if (result.isNotEmpty) return Product.fromMap(result.first);
    return null;
  }

  Future<int> updateProduct(Product product) async {
    final db = await dbHelper.database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await dbHelper.database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}
