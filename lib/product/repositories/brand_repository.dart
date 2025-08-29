// product_media_repository.dart

import 'package:dalell/data/repositories/product_repostory.dart';
import 'package:dalell/product/models/database_helper.dart';
import 'package:dalell/product/models/product.dart';

class BrandRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertBrand(Brand brand) async {
    final db = await dbHelper.database;
    return await db.insert('brands', brand.toMap());
  }

  Future<List<Brand>> getAllBrands() async {
    final db = await dbHelper.database;
    final result = await db.query('brands');
    return result.map((e) => Brand.fromMap(e)).toList();
  }

  void inite() {
    insertBrand(
      Brand(id: 1, name: 'SoundMax', logoUrl: 'assets/images/image2.jpg'),
    );
  }
}

class CategoryRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertCategory(Category category) async {
    final db = await dbHelper.database;
    return await db.insert('categories', category.toMap());
  }

  Future<List<Category>> getAllCategory() async {
    final db = await dbHelper.database;
    final result = await db.query('categories');
    return result.map((e) => Category.fromMap(e)).toList();
  }

  void inite() {
    insertCategory(Category(id: 1, name: 'Electronics'));
    insertCategory(Category(id: 2, name: 'Wearables'));
  }
}
