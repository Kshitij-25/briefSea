import 'dart:developer';

import 'package:dio/dio.dart';

import '../../main.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
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

      var responseJson = response!.data;
      var responseMsg = responseJson['message'];
      if (responseMsg == "Notification saved") {
        log(responseJson.toString());
      } else {
        log(responseJson.toString());
      }
    } catch (e) {
      log("postNewNotification Error", error: e);
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

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        if (responseJson != null) {
          List<dynamic> jsonList = responseJson;
          List<NotificationModel> notificationModel = jsonList.map((json) => NotificationModel.fromJson(json)).toList();
          return notificationModel;
        }
      }
    } catch (e) {
      log("getAllNotifications Error", error: e);
      return [];
    }
    return [];
  }

  @override
  Future<bool> deleteAllNotifications() async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.deleteReq(
        url: ApiConstants.deleteAllNotification,
        jwtToken: jwtToken,
      );

      var responseJson = response!.data;
      var responseMsg = responseJson['message'];
      // if (responseMsg == "Notification saved") {
      log(responseJson.toString());
      return true;
      // } else {
      //   log(responseJson.toString());
      //   return false;
      // }
    } catch (e) {
      log("postNewNotification Error", error: e);
      return false;
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

      var responseJson = response!.data;
      var responseMsg = responseJson['message'];
      // if (responseMsg == "Notification saved") {
      log(responseJson.toString());
      return true;
      // } else {
      //   log(responseJson.toString());
      //   return false;
      // }
    } catch (e) {
      log("postNewNotification Error", error: e);
      return false;
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

      var responseJson = response!.data;
      var responseMsg = responseJson['message'];
      // if (responseMsg == "Notification saved") {
      log(responseJson.toString());
      return true;
      // } else {
      //   log(responseJson.toString());
      //   return false;
      // }
    } catch (e) {
      log("postNewNotification Error", error: e);
      return false;
    }
  }
}
