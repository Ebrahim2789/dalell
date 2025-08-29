import 'package:dalell/product/models/database_helper.dart';
import 'package:dalell/product/models/product.dart';

class ProductMediaRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertMedia(Media media) async {
    final db = await dbHelper.database;
    return await db.insert('media', media.toMap());
  }

  Future<List<Media>> getMediaByProduct(int productId) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'media',
      where: 'productid = ?',
      whereArgs: [productId],
    );
    return result.map((e) => Media.fromMap(e)).toList();
  }

  Future<int> deleteMedia(int id) async {
    final db = await dbHelper.database;
    return await db.delete('media', where: 'id = ?', whereArgs: [id]);
  }


// final productRepo = ProductRepository();



// Fetch product with media
// List<Product> products = await productRepo.getAllProductsWithMedia();

// for (var p in products) {
//   print("Product: ${p.name}, Price: ${p.price}");
//   for (var m in p.media) {
//     print("   Media: ${m.mediaUrl} (${m.mediaType})");
//   }



// }

}






