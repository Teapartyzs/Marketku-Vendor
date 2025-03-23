import 'dart:convert';

import 'package:marketku_vendor/src/models/abstract/json_serialize.dart';

class Vendor extends JsonSerialize {
  final String id;
  final String fullname;
  final String email;
  final String password;
  final String city;
  final String role;
  final String fullAddress;

  Vendor(
      {required this.id,
      required this.fullname,
      required this.email,
      required this.password,
      required this.city,
      required this.role,
      required this.fullAddress});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'password': password,
      'city': city,
      'role': role,
      'fullAddress': fullAddress
    };
  }

  @override
  String toJson() => jsonEncode(toMap());

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
        id: map['_id'] as String? ?? "",
        fullname: map['fullname'] as String? ?? "",
        email: map['email'] as String? ?? "",
        password: map['password'] as String? ?? "",
        city: map['city'] as String? ?? "",
        role: map['role'] as String? ?? "",
        fullAddress: map['fullAddress'] as String? ?? "");
  }

  factory Vendor.fromJson(String json) =>
      Vendor.fromMap(jsonDecode(json) as Map<String, dynamic>);
}
