
import 'package:dalell/product/models/basemodel.dart';
import 'package:dalell/product/models/brand.dart';
import 'package:dalell/product/models/category.dart';
import 'package:dalell/product/models/media.dart';
import 'package:dalell/product/models/product_attribute.dart';



class Product extends Basemodel {
  @override
  int? id;
  final String name;
  final String description;
  final double price;
   Brand? brand;
   int? brandId;

  Category? category;
 int? categoryId;
  final List<Media> media;
  final List<ProductAttribute> attributes;
  final List<ProductOption> options;




  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.brandId,
     brand,
 
    category,
    this.categoryId,
    List<Media>? media,
   List<ProductAttribute>? attributes,
    List<ProductOption>? options,
  })

  : media = media ?? [],
        attributes = attributes ?? [],options=options?? [];

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brandId': brandId,
      'categoryId': categoryId,
      'price': price,
      // 'media': media,
      // 'attributes': attributes,
      // 'options': options,
    };
  }

  factory Product.fromMap(
    Map<dynamic, dynamic> map, {
 Brand? brand,
Category? category,
   List<Media>? media,
   List<ProductAttribute>? attributes,
    List<ProductOption>? options,
  }) =>
      Product(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        brandId: map['brandId'],
        categoryId:map['categoryId'],
        price: map['price'],
        media: media,
        attributes: attributes,
        options: options,
      );
}

class StaticData {
  static final List<Product> products = [
    Product(
      id: 6,
      name: 'Wireless Headphones',
      description: 'High-quality wireless headphones with noise cancellation.',
      price: 199.99,
      brand: 
      Brand(
          id: 1, name: 'SoundMax', logoUrl: 'assets/images/image2.jpg'),
      category: 

      Category(id: 1, name: 'Electronics'),
      media: [
        Media(
            id: 3,
            url: 'assets/images/image2.jpg',
            type: 'image',
            productid: 1),
        Media(
            id: 4,
            url: 'assets/images/image2.jpg',
            type: 'image',
            productid: 1),
      ],
      attributes: [
        ProductAttribute(
          name: "Color",
          options: [
            ProductOption( value: "Black"),
            ProductOption( value: "White"),
          ],
        ),
        ProductAttribute(
          name: "Storage",
          options: [
            ProductOption( value: "128GB"),
            ProductOption( value: "256GB"),
          ],
        ),
      ],
      // options: [
      //   ProductOption(name: 'Size', value: ['Small', 'Medium', 'Large']),
      //   ProductOption(name: 'Connectivity', value: ['Bluetooth', 'Wired']),
      // ],
    ),
    Product(
      id: 4,
      name: 'Smart Watch',
      description: 'Sleek smartwatch with fitness tracking and notifications.',
      price: 299.99,
      brand: 

       Brand(
        id: 2,
        name: 'TechTrend',
        logoUrl: 'assets/images/image2.jpg',
      ),
      category: Category(id: 2, name: 'Wearables'),
      media: [
        Media(
            id: 5,
            url: 'assets/images/image2.jpg',
            type: 'image',
            productid: 1),
      ],
      attributes: [
        ProductAttribute(
          name: "Color",
          options: [
            ProductOption( value: "Black"),
            ProductOption( value: "White"),
          ],
        ),
      ],
      // options: [
      //   ProductOption(name: 'Strap Color', value: ['Black', 'Blue', 'Red']),
      // ],
    ),
  ];
}


// class Product {

//   final String id;
//   final String name;
//   final String description;
//   final Brand brandId;
//   final Category categoryId;
//   final List<Media> media;
//   final List<ProductAttribute> attributes;

//   final List<String> options; // e.g., ['Small', 'Medium', 'Large']
//   final double price;

//   Product(this.options, {
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.brandId,
//     required this.categoryId,
//     required this.media,
//     required this.attributes,
//     required this.price,
//   });


//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'brandId': brandId,
//       'categoryId': categoryId,
//       'price': price,
//     };
//   }

//   factory Product.fromMap(Map<dynamic, dynamic> map) => Product(
//       id: map['id'],
//       name: map['name'],
//       description: map['description'],
//       brandId: map['brandId'],
//       categoryId: map['categoryId'],
//       price: map['price'],
//        media: [], 
//        attributes: [],
//     );
  


// }




// // final repo = ProductRepository();
// // final products = repo.getAllProducts();

// // for (var p in products) {
// //   print("${p.name} - ${p.brand.name} - ${p.category.name}");
// //   for (var attr in p.attributes) {
// //     print("  ${attr.name}: ${attr.options.map((o) => o.value).join(", ")}");
// //   }
// // }

