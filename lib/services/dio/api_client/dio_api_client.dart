import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioApiClient {
  static String baseUrl = "https://reqres.in";
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  // Get Request
  Future<Response> getData(
    String endpoint, {
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.get(
        Uri.encodeFull(endpoint),
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
