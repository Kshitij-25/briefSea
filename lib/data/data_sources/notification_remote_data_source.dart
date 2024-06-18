import 'dart:developer';

import 'package:dio/dio.dart';

import '../../main.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<void> postNewNotification(Map<String, dynamic> requestBody, bool isNewRegister);
  Future<List<NotificationModel>> getAllNotifications();
  Future<bool> deleteNotification(String? notificationId);
  Future<bool> deleteAllNotifications();
  Future<bool> deleteMessageNotification(String? conversationId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiClient _apiClient;

  NotificationRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = prefs!.getString('jwtToken');
    return jwtToken ?? "";
  }

  @override
  Future<void> postNewNotification(Map<String, dynamic> requestBody, bool isNewRegister) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.postReq(
        url: ApiConstants.postNewNotification,
        body: requestBody,
        jwtToken: isNewRegister ? jwtToken : null,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 201) {
          var responseJson = response.data;
          log(responseJson.toString());
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("postNewNotification Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<List<NotificationModel>> getAllNotifications() async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: ApiConstants.getAllNotification,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          final responseJson = response.data ?? [];
          log(responseJson.toString());
          return (responseJson as List).map((json) => NotificationModel.fromJson(json)).toList();
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("getAllNotifications Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> deleteAllNotifications() async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.deleteReq(
        url: ApiConstants.deleteAllNotification,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 201) {
          var responseJson = response.data;
          log(responseJson.toString());
          return true;
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("deleteAllNotifications Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> deleteMessageNotification(String? conversationId) async {
    var jwtToken = await getJwtToken();
    try {
      Response? response = await _apiClient.deleteReq(
        url: "${ApiConstants.deleteMessageNotification}/$conversationId",
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 201) {
          var responseJson = response.data;
          log(responseJson.toString());
          return true;
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("deleteMessageNotification Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> deleteNotification(String? notificationId) async {
    var jwtToken = await getJwtToken();
    try {
      Response? response = await _apiClient.deleteReq(
        url: "${ApiConstants.deleteNotification}/$notificationId",
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 201) {
          var responseJson = response.data;
          log(responseJson.toString());
          return true;
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("deleteNotification Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }
}
