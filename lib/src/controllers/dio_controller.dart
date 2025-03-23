import 'dart:convert';

import 'package:dio/dio.dart';

final dio = Dio();

extension UrlString on String {
  Future<void> postData(
    Map data,
    void Function(dynamic result, String message) onSuccess,
  ) async {
    try {
      // final requestBody = data.toJson();
      final response = await dio.post(this, data: data);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        onSuccess(response.data, response.statusMessage!);
      }
    } on DioException catch (e) {
      throw e.response?.data;
    }
  }

  Future<List<T>> getDataList<T>(T Function(dynamic json) fromJson) async {
    try {
      final response = await dio.get(this);

      return (response.data as List).map((item) => fromJson(item)).toList();
    } on DioException catch (e) {
      throw e.response?.data ?? 'An error occurred';
    }
  }
}
