import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioRequestException implements Exception {
  DioRequestException(this.message);
  final String message;

  @override
  String toString() => 'DioRequestException: $message';
}

class ApiClient {
  ApiClient(this._dio);
  final Dio _dio;

  Future<Response<dynamic>?> _makeRequest({
    required String method,
    required String url,
    Object? body,
    String? jwtToken,
    int? contentType,
    String? mimeType,
  }) async {
    try {
      final headers = {
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': contentType ?? 'application/json',
        if (jwtToken != null) 'Authorization': 'Bearer $jwtToken',
      };

      final options = Options(
        method: method,
        headers: headers,
        contentType: mimeType,
      );

      Response<dynamic>? response;

      switch (method) {
        case 'GET':
          response = await _dio.get(url, data: body, options: options);
          break;
        case 'POST':
          response = await _dio.post(url, data: body, options: options);
          break;
        case 'PUT':
          response = await _dio.put(url, data: body, options: options);
          break;
        case 'DELETE':
          response = await _dio.delete(url, data: body, options: options);
          break;
        case 'PATCH':
          response = await _dio.patch(url, data: body, options: options);
          break;
        default:
          throw DioRequestException('Invalid HTTP method: $method');
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else {
        throw DioRequestException('HTTP error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw DioRequestException('Dio error: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error in DioRequest: $e');
      rethrow;
    }
  }

  Future<Response<dynamic>?> getReq({String? url, Object? body, String? jwtToken}) async {
    return _makeRequest(method: 'GET', url: url!, body: body, jwtToken: jwtToken);
  }

  Future<Response<dynamic>?> postReq({String? url, Object? body, String? jwtToken}) async {
    return _makeRequest(method: 'POST', url: url!, body: body, jwtToken: jwtToken);
  }

  Future<Response<dynamic>?> putReq({String? url, Object? body, String? jwtToken, int? contentType, String? mimeType}) async {
    return _makeRequest(
      method: 'PUT',
      url: url!,
      body: body,
      jwtToken: jwtToken,
      contentType: contentType,
      mimeType: mimeType,
    );
  }

  Future<Response<dynamic>?> deleteReq({String? url, Object? body, String? jwtToken}) async {
    return _makeRequest(method: 'DELETE', url: url!, body: body, jwtToken: jwtToken);
  }

  Future<Response<dynamic>?> patchReq({String? url, Object? body, String? jwtToken}) async {
    return _makeRequest(method: 'PATCH', url: url!, body: body, jwtToken: jwtToken);
  }
}
