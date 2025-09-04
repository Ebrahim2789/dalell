class Category {
   int? id;
  final String name;

  Category({ this.id, required this.name});
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