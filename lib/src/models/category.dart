import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String image;
  final String banner;

  Category(
      {required this.id,
      required this.name,
      required this.image,
      required this.banner});

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'banner': banner
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: map["_id"] as String? ?? "",
        name: map['name'] as String? ?? "",
        image: map['image'] as String? ?? "",
        banner: map['banner'] as String? ?? "");
  }
}
