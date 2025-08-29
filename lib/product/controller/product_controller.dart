// product_repository.dart
import 'package:dalell/product/models/database_helper.dart';
import 'package:dalell/product/repositories/brand_repository.dart';
import 'package:dalell/product/repositories/generic_repository.dart';
import 'package:dalell/product/repositories/product_ateribute_repository.dart';
import 'package:dalell/product/repositories/product_media_repository.dart';
import 'package:dalell/product/repositories/product_repository.dart';
import 'package:dalell/product/view/orderconform.dart';
import 'package:dalell/utils/result.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';

class ProductController {
  final dbHelper = DatabaseHelper.instance;

  final mediaRepo = ProductMediaRepository();
  final categorRepo = CategoryRepository();
  final attributRepo = ProductAteributeRepository();

  final optionRepo = ProductOptionRepository();

  final productRepo = ProductRepository();

  final productRepoG = GenericRepository<Product>(
      tableName: 'products', fromMap: Product.fromMap);

  final brandRepo = BrandRepository();

  List<Product> _Products = [];

  List<Product> get Products => _Products;

  // GenericRepository<Brand>(
  //     tableName: 'brandes', fromMap: Brand.fromMap);

  // Future<Result<Brand?>> fetchProducts(int id) async {

  //   return brandRepo.getById(id);
  // }

  Future<int> insertProduct(Product product) async {
    final db = await dbHelper.database;

    final brandRepo = BrandRepository();

// Insert a brand
    List<Brand> brand = await brandRepo.getAllBrands();
    if (brand.isEmpty) {
      brandRepo.inite();
    }

    List<Category> category = await categorRepo.getAllCategory();
    if (category.isEmpty) {
      categorRepo.inite();
    }

    product.media.addAll(product.media.toList());
    product.attributes.addAll(product.attributes.toList());

    // product.brandId=brandId;
    int productId = await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final pr = await productRepo.getAllProductsWithMedia();

    for (var attribut in product.attributes) {
      attribut.productId = productId;
      int attributid = await attributRepo.insertProductAteribute(attribut);

      for (var option in attribut.options) {
        option.attributeId = attributid;

        await optionRepo.insertProductOption(option);
      }
    }
    for (var p in pr) {
      if (p.media.isEmpty) {
        for (var p in product.media) {
          p.productid = productId;
          mediaRepo.insertMedia(p);
        }
      }
    }

    return productId;
  }

  Future<List<Product>> getAllProducts() async {
    // final list =await productRepoG.getAll();

    // Fetch product with media
    List<Product> products = await productRepo.getAllProductsWithMedia();



    for (var p in products) {
      print("Product: ${p.name}, Price: ${p.price}");
      List<Media> list = await mediaRepo.getMediaByProduct(p.id!);

      for (var m in list ) {
        print("   Media is : ${m.url} (${m.type})");
        p.media.add(m);

           
        
      }

  
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

  Future<int> deleteProduct(String id) async {
    final db = await dbHelper.database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}
