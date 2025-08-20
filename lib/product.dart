
class Product {
  late final int? id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl});

  // Product.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       name = json['name'],
  //       description = json['description'],
  //       price = json['price'],
  //       imageUrl = json['imageUrl'];

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "imageUrl": imageUrl
      };

  factory Product.fromMap(Map<dynamic, dynamic> data) {
    return Product(
     id:  data['id'],
     name:  data['name'],
     description:  data['description'],
     price:  data['price'],
     imageUrl:  data['imageUrl'],
    );
  }
}



