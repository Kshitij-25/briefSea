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

  Future<Response<dynamic>?> getReq({String? url, Object? body, String? jwtToken}) async {
    try {
      final headers = {
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      };
      final response = await _dio.get(
        url!,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioRequestException('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      handleDioError(e);
    }
    return null;
  }

  Future<Response<dynamic>?> postReq({String? url, Object? body, String? jwtToken}) async {
    try {
      final headers = {
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      };
      final response = await _dio.post(
        url!,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw DioRequestException('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      handleDioError(e);
    }
    return null;
  }

  Future<Response<dynamic>?> putReq({String? url, Object? body, String? jwtToken, int? contentType, String? mimeType}) async {
    try {
      final headers = {
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': contentType ?? 'application/json',
        if (jwtToken != null) 'Authorization': 'Bearer $jwtToken',
      };

      final response = await _dio.put(
        url!,
        data: body,
        options: Options(
          contentType: mimeType,
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioRequestException('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      handleDioError(e);
    }
    return null;
  }

  Future<Response<dynamic>?> deleteReq({String? url, Object? body, String? jwtToken}) async {
    try {
      final headers = {
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      };
      final response = await _dio.delete(
        url!,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioRequestException('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      handleDioError(e);
    }
    return null;
  }

  Future<Response<dynamic>?> patchReq({String? url, Object? body, String? jwtToken}) async {
    try {
      final headers = {
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      };
      final response = await _dio.patch(
        url!,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioRequestException('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      handleDioError(e);
    }
    return null;
  }

  void handleDioError(dynamic e) {
    // Handle Dio errors
    if (e is DioException) {
      throw DioRequestException('Dio error: ${e.message}');
    }

    // Handle other unexpected errors
    debugPrint('Unexpected error in DioRequest: $e');
  }
}
