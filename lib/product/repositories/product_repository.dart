// product_repository.dart

import 'dart:core';

import 'package:dalell/product/models/database_helper.dart';
import 'package:dalell/product/models/product.dart';
import 'package:dalell/product/repositories/generic_repository.dart';
import 'package:dalell/utils/result.dart';

// class ProductRepository {

//   final dbHelper = DatabaseHelper.instance;

//   final List<Product> _products = [
//      Product(
//       id: 1,
//       name: 'Wireless Headphones',
//       description: 'High-quality wireless headphones with noise cancellation.',
//       price: 199.99,
//       brandId: 1,
//       // Brand(id: 1, name: 'SoundMax', logoUrl: 'assets/images/image2.jpg'),
//       categoryId: 2,
//       // Category(id: 1, name: 'Electronics'),
//       media: [
//         Media(id: 1, url:  'assets/images/image2.jpg', type: 'image', productid: 1),
//         Media(id: 2, url:  'assets/images/image2.jpg', type: 'image', productid: 2),
//       ],
//       attributes: [
//         ProductAttribute(name: 'Color', value: 'Black'),
//         ProductAttribute(name: 'Battery Life', value: '20 hours'),
//       ],
//       options: [
//         ProductOption(name: 'Size', values: ['Small', 'Medium', 'Large']),
//         ProductOption(name: 'Connectivity', values: ['Bluetooth', 'Wired']),
//       ],
//     ),
//   ];

// final productRepo =GenericRepository<Product>(tableName: 'products', fromMap:Product.fromMap);

// final brandRepo =GenericRepository<Product>(tableName: 'brandes', fromMap:Product.fromMap);

//   Future<Result<List<Product>>> fetchProducts() async {

//     return productRepo.getAll();
//   }

//   // Future<Result<Product>> createProduct(Product p) async {
//   //   if (!productRepo.isOpen()) {
//   //     await productRepo.open();
//   //   }
//   //   return productRepo.insert( _products.first);
//   // }

//   // Future<Result<void>> deleteProduct(int id) async {
//   //   if (!productRepo.isOpen()) {
//   //     await productRepo.open();
//   //   }
//   //   return productRepo.delete(id);
//   // }

//   List<Product> getAllProducts() => _products;

//   Product? getProductById(String id) =>
//       _products.firstWhere((p) => p.id == id, orElse: () => null as Product);

//   List<Product> getProductsByCategory(String categoryId) =>
//       _products.where((p) => p.categoryId == categoryId).toList();

//   List<Product> getProductsByBrand(String brandId) =>
//       _products.where((p) => p.brandId == brandId).toList();

//   void addProduct(Product product) {
//     _products.add(product);
//   }

//   Future<List<Product>> getAllProductsWithMedia() async {
//     final db = await dbHelper.database;

//     // Get all products
//     final productResult = await db.query('product');

//     List<Product> products = [];

//     for (var prodMap in productResult) {
//       // Get product media
//       final mediaResult = await db.query(
//         'media',
//         where: 'product_id = ?',
//         whereArgs: [prodMap['id']],
//       );

//       List<Media> mediaList =
//           mediaResult.map((e) => Media.fromMap(e)).toList();

//       // Attach media to product
//       products.add(Product.fromMap(prodMap, media: mediaList));
//     }

//     return products;
//   }

// // final mediaRepo = ProductMediaRepository();
// // final productRepo = ProductRepository();

// // // Add product media (images, videos, etc.)
// // await mediaRepo.insertMedia(Media(
// //   productId: productId,
// //   mediaUrl: "https://example.com/image1.jpg",
// //   mediaType: "image",
// // ));

// // await mediaRepo.insertMedia(Media(
// //   productId: productId,
// //   mediaUrl: "https://example.com/image2.jpg",
// //   mediaType: "image",
// // ));

// // await mediaRepo.insertMedia(Media(
// //   productId: productId,
// //   mediaUrl: "https://example.com/demo.mp4",
// //   mediaType: "video",
// // ));

// }

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

    


    // products.add(Product.fromMap(prodMap, attributes: attributList));
      // for (var atterMap in attributList) {
      //   final optionResult = await db.query(
      //     'attribute_options',
      //     where: 'attributeId = ?',
      //     whereArgs: [atterMap.id],
      //   );
    

        // List<ProductOption> optionList =
        //     optionResult.map((e) => ProductOption.fromMap(e)).toList();

        // // attributList
        // //     .add(ProductAttribute.fromMap(prodMap, options: optionList));
      // }
      // // Attach media to product
        List<Media> mediaList = mediaResult.map((e) => Media.fromMap(e)).toList();
      products.add(Product.fromMap(prodMap, media: mediaList));

      // print(products.first.attributes.first.name);
    }

    return products;
  }
}
