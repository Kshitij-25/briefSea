import 'dart:io';

import 'package:dio/dio.dart';

class DioErrorHandler {
  String? errorMessage;

  DioErrorHandler(DioException dioError) {
    setErrorMessage(dioError);
  }

  void setErrorMessage(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timed out. Please try again later.";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Request send timeout. Please try again.";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Response receive timeout. Please try again.";
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleHttpResponse(dioError.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        errorMessage = "Request to the server was cancelled. Please try again.";
        break;
      case DioExceptionType.badCertificate:
        errorMessage = "Invalid certificate received from the server. Please check your network security settings.";
        break;
      case DioExceptionType.connectionError:
        errorMessage = "Connection error. Please check your internet connection and try again.";
        break;
      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          errorMessage = "Network error. Please check your connection and try again.";
        } else {
          errorMessage = "An unexpected error occurred. Please try again.";
        }
        break;
    }
  }

  String _handleHttpResponse(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Oops! Something went wrong. Please try again.";
      case 401:
        return "Whoops! You need to log in to access this.";
      case 403:
        return "Sorry, you don't have permission to do that.";
      case 404:
        return "Uh-oh! We can't find what you're looking for.";
      case 500:
        return "Yikes! Something broke on our end. Please try later.";
      case 502:
        return "Hmmm... We got a bad response from the server.";
      case 503:
        return "Sorry! Our service is currently unavailable. Check back soon.";
      case 504:
        return "Oops! The server took too long to respond. Try again later.";
      default:
        return "An unexpected error occurred. Please try again.";
    }
  }
}
