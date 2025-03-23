import 'dart:convert';

class CategorySub {
  final String id;
  final String categoryId;
  final String categoryName;
  final String image;
  final String subCategoryName;

  CategorySub(
      {required this.id,
      required this.categoryId,
      required this.categoryName,
      required this.image,
      required this.subCategoryName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "_id": id,
      "categoryId": categoryId,
      "categoryName": categoryName,
      "image": image,
      "subCategoryName": subCategoryName
    };
  }

  String toJson() => jsonEncode(toMap());

  factory CategorySub.fromMap(Map<String, dynamic> map) {
    return CategorySub(
        id: map['_id'] as String? ?? "",
        categoryId: map['categoryId'] as String? ?? "",
        categoryName: map["categoryName"] as String? ?? "",
        image: map["image"] as String? ?? "",
        subCategoryName: map["subCategoryName"] as String? ?? "");
  }
}
