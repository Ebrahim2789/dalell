// product_media_repository.dart

import 'package:dalell/product/models/brand.dart';
import 'package:dalell/product/models/database_helper.dart';
import 'package:dalell/product/repositories/generic_repository.dart';

class BrandRepository {
  final dbHelper = DatabaseHelper.instance;

    final brandGenirc = GenericRepository<Brand>(
      tableName: 'brands', fromMap: Brand.fromMap);

  Future<int> insertBrand(Brand brand) async {
    final db = await dbHelper.database;
    return await db.insert('brands', brand.toMap());
  }

  Future<List<Brand>> getAllBrands() async {
    final db = await dbHelper.database;
    final result = await db.query('brands');
    return result.map((e) => Brand.fromMap(e)).toList();
  }

    Future<Brand> getBrandById(int id) async {
    final db = await dbHelper.database;
    final result= await db.query('brands', where: 'id = ?', whereArgs: [id]);

    return result.map((e)=>Brand.fromMap(e)).first;
  }
  void inite() {
    insertBrand(
      Brand(id: 1, name: 'SoundMax', logoUrl: 'assets/images/image2.jpg'),
    );
  }
}
