import 'dart:developer';

import 'package:dio/dio.dart';

import '../../common/app_utils/shared_prefs_helper.dart';
import '../../main.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<void> postNewNotification(Map<String, dynamic> requestBody, bool isNewRegister);
  Future<void> briefLikeNotification({
    String? receiverId,
    String? threadId,
    String? likeId,
    String? briefText,
  });
  Future<void> commentLikeNotification({
    String? receiverId,
    String? threadId,
    String? likeId,
    String? commentText,
    String? commentId,
  });
  Future<void> commentNotification({
    String? receiverId,
    String? threadId,
  });
  Future<void> replyNotification({
    String? receiverId,
    String? threadId,
    String? commentId,
  });
  Future<List<NotificationModel>> getAllNotifications();
  Future<bool> deleteNotification(String? notificationId);
  Future<bool> deleteAllNotifications();
  Future<bool> deleteMessageNotification(String? conversationId);
  Future<void> updateNotificationViewStatus(List<String> notificationIds);
  Future<void> updateNotificationTapStatus(String notificationId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiClient _apiClient;

  NotificationRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = await SharedPreferencesHelper.getString('jwtToken');
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
  Future<void> briefLikeNotification({
    String? receiverId,
    String? threadId,
    String? likeId,
    String? briefText,
  }) async {
    var jwtToken = await getJwtToken();

    var body = {
      "type": "brief liked",
      "sender_id": prefs!.getString('user_id'),
      "sender_name": prefs!.getString('user_name'),
      "receiver_id": receiverId,
      "notification": "${prefs!.getString('user_name')} liked your brief.",
      "thread_id": threadId,
      'briefText': briefText,
      "like_id": likeId,
    };

    try {
      Response? response = await _apiClient.postReq(
        url: ApiConstants.briefLikeNotification,
        body: body,
        jwtToken: jwtToken,
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
      log("briefLikeNotification Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<void> commentLikeNotification({
    String? receiverId,
    String? threadId,
    String? likeId,
    String? commentText,
    String? commentId,
  }) async {
    var jwtToken = await getJwtToken();

    var body = {
      "type": "comment liked",
      "sender_id": prefs!.getString('user_id'),
      "sender_name": prefs!.getString('user_name'),
      "receiver_id": receiverId,
      "notification": "${prefs!.getString('user_name')} liked your comment.",
      "notifText": commentText,
      "thread_id": threadId,
      "like_id": likeId,
      "reply_id": commentId,
    };

    try {
      Response? response = await _apiClient.postReq(
        url: ApiConstants.commentNotification,
        body: body,
        jwtToken: jwtToken,
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
      log("commentLikeNotification Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<void> commentNotification({
    String? receiverId,
    String? threadId,
  }) async {
    var jwtToken = await getJwtToken();

    var body = {
      "type": "brief comment",
      "sender_id": prefs!.getString('user_id'),
      "sender_name": prefs!.getString('user_name'),
      "receiver_id": receiverId,
      "notification": "${prefs!.getString('user_name')} commented on your brief.",
      "thread_id": threadId,
    };

    try {
      Response? response = await _apiClient.postReq(
        url: ApiConstants.commentNotification,
        body: body,
        jwtToken: jwtToken,
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
      log("commentNotification Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<void> replyNotification({
    String? receiverId,
    String? threadId,
    String? commentId,
  }) async {
    var jwtToken = await getJwtToken();

    var body = {
      "type": "comment reply",
      "sender_id": prefs!.getString('user_id'),
      "sender_name": prefs!.getString('user_name'),
      "receiver_id": receiverId,
      "notification": "${prefs!.getString('user_name')} replied on your comment.",
      "thread_id": threadId,
      "reply_id": commentId,
    };

    try {
      Response? response = await _apiClient.postReq(
        url: ApiConstants.replyNotification,
        body: body,
        jwtToken: jwtToken,
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
      log("replyNotification Error", error: e);
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
        if (response!.statusCode == 200) {
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
        if (response!.statusCode == 200) {
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

  @override
  Future<void> updateNotificationViewStatus(List<String> notificationIds) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'ids': notificationIds,
      };

      Response? response = await _apiClient.patchReq(
        url: ApiConstants.notificationViewStatus,
        body: body,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("updateNotificationViewStatus Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<void> updateNotificationTapStatus(String notificationId) async {
    var jwtToken = await getJwtToken();
    try {
      Response? response = await _apiClient.patchReq(
        url: "${ApiConstants.notificationTapStatus}/$notificationId",
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("updateNotificationTapStatus Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }
}
