// product_media_repository.dart

import 'package:dalell/product/models/category.dart';
import 'package:dalell/product/models/database_helper.dart';

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

    Future<Category> getCategoryById(int id) async {
    final db = await dbHelper.database;
    final result= await db.query('categories', where: 'id = ?', whereArgs: [id]);

    return result.map((e)=>Category.fromMap(e)).first;
  }

  void inite() {
    insertCategory(Category(id: 1, name: 'Electronics'));
    insertCategory(Category(id: 2, name: 'Wearables'));
  }
}
