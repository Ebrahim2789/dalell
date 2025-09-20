// product_repository.dart


class Address {
  @override
  int? id;
  final String customerName;
  final String phone;
  final String city;
  final String street;
  final String zipCode;

  Address({
     this.id,
    required this.customerName,
    required this.phone,
    required this.city,
    required this.street,
    required this.zipCode,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'customerName': customerName,
        'phone': phone,
        'city': city,
        'street': street,
        'zipCode': zipCode,
      };

  factory Address.fromMap(Map<String, dynamic> map) => Address(
        id: map['id'],
        customerName: map['customerName'],
        phone: map['phone'],
        city: map['city'],
        street: map['street'],
        zipCode: map['zipCode'],
      );
}
