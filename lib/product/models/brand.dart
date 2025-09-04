
import 'package:dalell/product/models/basemodel.dart';

class Brand extends Basemodel {


  @override
  int? id;
  final String name;
  final String logoUrl;

  Brand({ this.id, required this.name, required this.logoUrl});

  @override
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