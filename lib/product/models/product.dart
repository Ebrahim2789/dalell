
import 'package:dalell/product/models/basemodel.dart';


class Brand extends Basemodel {
  @override
  int? id;
  final String name;
  final String logoUrl;

  Brand({required this.id, required this.name, required this.logoUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
    };
  }

  factory Brand.fromMap(Map<dynamic, dynamic> map) =>
      Brand(id: map['id'], name: map['name'], logoUrl: map['logoUrl']);
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Category.fromMap(Map<dynamic, dynamic> map) => Category(
        id: map['id'],
        name: map['name'],
      );
}

class Media {
  int? id;
  int productid;
  final String url;
  final String type; // e.g., 'image', 'video'

  Media(
      {this.id,
      required this.productid,
      required this.url,
      required this.type});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productid': productid,
      'url': url,
      'type': type,
    };
  }

  factory Media.fromMap(Map<dynamic, dynamic> map) => Media(
      id: map['id'],
      productid: map['productid'],
      url: map['url'],
      type: map['type']);
}
// attribute.dart

class ProductAttribute {
  int? id;
  final String name;
  int? productId;
  final List<ProductOption> options;

  ProductAttribute({this.id, this.productId, required this.name, required this.options});

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'productId':productId,
    };
  }

  factory ProductAttribute.fromMap(
    Map<dynamic, dynamic> map, {
    List<ProductOption> options = const [],
  }) =>
      ProductAttribute(name: map['name'], 
      id:map['id'],
      productId: map['productId'],
      
      options: options);
}

class ProductOption {

  int? attributeId;
  final String value;

  ProductOption({ required this.value});

  Map<String, dynamic> toMap() {
    return { 'value': value,'attributeId':attributeId};
  }

  factory ProductOption.fromMap(
    Map<dynamic, dynamic> map,
  ) =>
      ProductOption(
   
        value: map['value'],
      );
}

class Product extends Basemodel {
  @override
  int? id;
  final String name;
  final String description;
  final double price;
  int brandId;
  int categoryId;
  final List<Media> media;
  final List<ProductAttribute> attributes;
  final List<ProductOption> options;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.brandId,
    required this.categoryId,
    this.media = const [],
    this.attributes = const [],
    this.options = const [],
  });

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
    List<Media> media = const [],
    List<ProductAttribute> attributes = const [],
    List<ProductOption> option = const [],
  }) =>
      Product(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        brandId: map['brandId'],
        categoryId: map['categoryId'],
        price: map['price'],
        media: media,
        attributes: attributes,
        options: option,
      );
}

class StaticData {
  static final List<Product> products = [
    Product(
      id: 6,
      name: 'Wireless Headphones',
      description: 'High-quality wireless headphones with noise cancellation.',
      price: 199.99,
      brandId: 2,
      // Brand(
      //     id: 1, name: 'SoundMax', logoUrl: 'assets/images/image2.jpg'),
      categoryId: 1,

      // Category(id: 1, name: 'Electronics'),
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
      brandId: 1,

      //  Brand(
      //   id: 2,
      //   name: 'TechTrend',
      //   logoUrl: 'assets/images/image2.jpg',
      // ),
      categoryId: 2,

      //  Category(id: 2, name: 'Wearables'),
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

