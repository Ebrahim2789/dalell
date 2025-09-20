// product_repository.dart
import 'package:dalell/product/models/database_helper.dart';
import 'package:dalell/product/repositories/brand_repository.dart';
import 'package:dalell/product/repositories/category_repository.dart';
import 'package:dalell/product/repositories/generic_repository.dart';
import 'package:dalell/product/repositories/product_ateribute_repository.dart';
import 'package:dalell/product/repositories/product_media_repository.dart';
import 'package:dalell/product/repositories/product_repository.dart';
import '../models/product.dart';
import 'package:dalell/product/models/brand.dart';
import 'package:dalell/product/models/category.dart';
import 'package:dalell/product/models/media.dart';
import 'package:dalell/product/models/product_attribute.dart';

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

  final List<Product> _Products = [];

  List<Product> get Products => _Products;


  Future<int> insertProduct(Product product) async {
    final db = await dbHelper.database;

    final brandRepo = BrandRepository();
    brandRepo.brandGenirc.getByName('LTA');

// Insert a brand
    List<Brand> brand = await brandRepo.getAllBrands();
    if (brand.isEmpty) {
      brandRepo.inite();
    }

    List<Category> category = await categorRepo.getAllCategory();
    if (category.isEmpty) {
      categorRepo.inite();
    }

    // print(product.attributes);

    // product.media.addAll(product.media.toList());
    // product.attributes.addAll(product.attributes.toList());
    int pid = await db.rawInsert(
        "INSERT INTO products ('id', 'name', 'description','brandId','categoryId', 'price') values (?, ?, ?, ?, ?,?)",
        [
          product.id,
          product.name,
          product.description,
          product.brand!.id,
          product.category!.id,
          product.price
        ]);

    // product.brandId=brandId;
    int productId = pid;
    //
    // await db.insert(
    //   'products',
    //   product.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );

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
    // Fetch product with media
    List<Product> products = await productRepo.getAllProductsWithMedia();
    for (var p in products) {
      // print("Product: ${p.name}, Price: ${p.price}");
      List<Media> list = await mediaRepo.getMediaByProduct(p.id!);

      for (var m in list) {
        // print("   Media is : ${m.url} (${m.type})");
        p.media.add(m);
      }
      List<ProductAttribute> attributList =
          await attributRepo.getAProductAteribute(p.id!);

      for (var atterMap in attributList) {
        List<ProductOption> optionList =
            await optionRepo.getProductOptionByProduct(atterMap.id!);

        p.attributes.add(
            ProductAttribute.fromMap(atterMap.toMap(), options: optionList));

        Category category = await categorRepo.getCategoryById(p.categoryId!);
        p.category = category;

        var brand = await brandRepo.getBrandById(p.brandId!);

        p.brand = brand;
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
