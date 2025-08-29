 // models/order.dart

class Order  {
  
  final int? id;
  final int? productId;
  final int quantity;
  final double total;
  final String status;
  final String createdAt;
  final String addressId; // new field

  Order({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.addressId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'productId': productId,
        'quantity': quantity,
        'total': total,
        'status': status,
        'createdAt': createdAt,
        'addressId': addressId,
      };

  factory Order.fromMap(Map<String, dynamic> map) => Order(
        id: map['id'],
        productId: map['productId'],
        quantity: map['quantity'],
        total: map['total'],
        status: map['status'],
        createdAt: map['createdAt'],
        addressId: map['addressId'],
      );
}



// models/delivery.dart
class Delivery {
  final int? id;
  final int? orderId;
  final String address;
  final String status; // pending, shipped, delivered
  final String? deliveredAt;

  Delivery({
    required this.id,
    required this.orderId,
    required this.address,
    required this.status,
    this.deliveredAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'orderId': orderId,
        'address': address,
        'status': status,
        'deliveredAt': deliveredAt,
      };

  factory Delivery.fromMap(Map<String, dynamic> map) => Delivery(
        id: map['id'],
        orderId: map['orderId'],
        address: map['address'],
        status: map['status'],
        deliveredAt: map['deliveredAt'],
      );
}
