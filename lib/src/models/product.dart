import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final int productPrice;
  final String vendorId;
  final String fullname;
  final int quantity;
  final String description;
  final String category;
  final String subCategory;
  final List<String> images;
  final bool popular;
  final bool recommend;

  Product(
      {required this.id,
      required this.productName,
      required this.productPrice,
      required this.vendorId,
      required this.fullname,
      required this.quantity,
      required this.description,
      required this.category,
      required this.subCategory,
      required this.images,
      required this.popular,
      required this.recommend});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "productName": productName,
      "productPrice": productPrice,
      "vendorId": vendorId,
      "fullname": fullname,
      "quantity": quantity,
      "description": description,
      "category": category,
      "subCategory": subCategory,
      "images": images,
      "popular": popular,
      "recommend": recommend,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map["_id"] as String? ?? "",
        productName: map['productName'] as String? ?? "",
        productPrice: map['productPrice'],
        vendorId: map['vendorId'] as String? ?? "",
        fullname: map['fullname'] as String? ?? "",
        quantity: map['quantity'],
        description: map['description'] as String? ?? "",
        category: map['category'],
        subCategory: map['subCategory'],
        images: map['images'],
        popular: map['popular'],
        recommend: map['recommend']);
  }
}
