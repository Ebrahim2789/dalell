// product_media_repository.dart

import 'package:dalell/product/models/database_helper.dart';
import 'package:dalell/product/models/product_attribute.dart';

class ProductAteributeRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertProductAteribute(ProductAttribute attributes) async {
    final db = await dbHelper.database;
    return await db.insert('attributes', attributes.toMap());
  }

  Future<List<ProductAttribute>> getAllProductAteribute() async {
    final db = await dbHelper.database;
    final result = await db.query('attributes');
    return result.map((e) => ProductAttribute.fromMap(e)).toList();
  }

    Future<List<ProductAttribute>> getAProductAteribute(int productId) async {
    final db = await dbHelper.database;
    final result = await db.query(
           'attributes',
        where: 'productId = ?',
        whereArgs: [productId],
    );
    return result.map((e) => ProductAttribute.fromMap(e)).toList();
  }

  void inite() {
    insertProductAteribute(
         ProductAttribute(
          name: "Color",
          options: [
            ProductOption( value: "Black"),
            ProductOption( value: "White"),
          ],
        ),


        // ProductAttribute(
        //   name: "Storage",
        //   options: [
        //     ProductOption(id: "o3", value: "128GB"),
        //     ProductOption(id: "o4", value: "256GB"),
        //   ],
        // ),
    
    );
  }
}



class ProductOptionRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertProductOption(ProductOption option) async {
    final db = await dbHelper.database;
    return await db.insert('attribute_options', option.toMap());
  }

  Future<List<ProductOption>> getAllProductOption() async {
    final db = await dbHelper.database;
    final result = await db.query('attribute_options');
    return result.map((e) => ProductOption.fromMap(e)).toList();
  }

    Future<List<ProductOption>> getProductOptionByProduct(int attributeId) async {
    final db = await dbHelper.database;
    final result = await db.query(
          'attribute_options',
          where: 'attributeId = ?',
        whereArgs: [attributeId],
    );
    return result.map((e) => ProductOption.fromMap(e)).toList();
  }

  void inite() {
    insertProductOption(
         ProductOption( value: 'Black' ),
    
    );
  }
}