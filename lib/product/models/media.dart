

class Media {
  int? id;
  int? productid;
  final String url;
  final String type; // e.g., 'image', 'video'

  Media(
      {this.id,
       this.productid,
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