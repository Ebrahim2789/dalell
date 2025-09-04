

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