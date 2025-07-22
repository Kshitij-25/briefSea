import 'dart:developer';

import 'package:dio/dio.dart';

import '../../common/app_utils/shared_prefs_helper.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/chat_message_model.dart';
import '../models/chat_user_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatUserModel>> getChatUsersList(String? userId);
  Future<bool> createNewChat(String? senderId, String? receiverId);
  Future<List<ChatMessageModel>> getChatMessages(String? conversationId);
  Future<bool> sendChatMessage({String? senderId, String? receiverId, String? conversationId, String? messageText, String? typedAt});
  Future<ChatUserModel> getDMUser(String? senderId, String? receiverId);
  Future<bool> editMessage({String? conversationId, String? messageText});
  Future<bool> deleteMessage({String? messageId});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiClient _apiClient;

  ChatRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = await SharedPreferencesHelper.getString('jwtToken');
    return jwtToken ?? "";
  }

  @override
  Future<List<ChatUserModel>> getChatUsersList(String? userId) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getChatUsersList}/$userId",
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          final responseJson = response.data ?? [];
          log(responseJson.toString());
          return (responseJson as List).map((json) => ChatUserModel.fromJson(json)).toList();
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("getChatUsersList Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> createNewChat(String? senderId, String? receiverId) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.postReq(
        url: ApiConstants.createNewChat,
        body: {
          "sender_id": senderId,
          "receiver_id": receiverId,
        },
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 201) {
          var responseJson = response.data;
          log(responseJson.toString());
          var responseMsg = responseJson['message'];
          if (responseMsg == "Conversation created successfully") {
            return true;
          } else {
            return false;
          }
        } else if (response.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
          var responseMsg = responseJson['message'];
          if (responseMsg == "Conversation already exists") {
            return true;
          } else {
            return false;
          }
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("createNewChat Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<List<ChatMessageModel>> getChatMessages(String? conversationId) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getChatMessages}/$conversationId",
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          final responseJson = response.data ?? [];
          log(responseJson.toString());
          return (responseJson as List).map((json) => ChatMessageModel.fromJson(json)).toList();
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("getChatMessages Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> sendChatMessage({
    String? senderId,
    String? receiverId,
    String? conversationId,
    String? messageText,
    String? typedAt,
  }) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.postReq(
        url: ApiConstants.sendChatMessage,
        body: {
          "conversation_id": conversationId,
          "sender_id": senderId,
          "receiver_id": receiverId,
          "message": messageText,
          "typedAt": typedAt,
        },
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 201) {
          var responseJson = response.data;
          log(responseJson.toString());
          var responseMsg = responseJson['message'];
          if (responseMsg == "Message sent successfully") {
            return true;
          } else {
            return false;
          }
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("sendChatMessage Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<ChatUserModel> getDMUser(String? senderId, String? receiverId) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getDMUser}/$receiverId",
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
          // Check if responseJson is an array and not empty
          if (responseJson is List && responseJson.isNotEmpty) {
            return ChatUserModel.fromJson(responseJson[0]);
          } else {
            throw AppError(errorMessage: "Invalid response format or empty array");
          }
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("createNewChat Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> deleteMessage({String? messageId}) async {
    var jwtToken = await getJwtToken();
    try {
      Response? response = await _apiClient.deleteReq(
        url: "${ApiConstants.deleteMessage}/$messageId",
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
      log("deleteMessage Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> editMessage({String? conversationId, String? messageText}) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'message': messageText,
        'isEdited': true,
      };

      Response? response = await _apiClient.patchReq(
        url: "${ApiConstants.editMessage}/$conversationId",
        body: body,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
          var responseMsg = responseJson['message'];
          if (responseMsg == "Message updated") {
            return true;
          } else {
            return false;
          }
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("editMessage Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }
}
