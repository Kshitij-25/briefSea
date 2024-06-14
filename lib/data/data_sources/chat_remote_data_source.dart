import 'dart:developer';

import 'package:dio/dio.dart';

import '../../main.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../models/chat_message_model.dart';
import '../models/chat_user_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatUserModel>> getChatUsersList(String? userId);
  Future<bool> createNewChat(String? senderId, String? receiverId);
  Future<List<ChatMessageModel>> getChatMessages(String? conversationId);
  Future<bool> sendChatMessage({String? senderId, String? receiverId, String? conversationId, String? messageText, String? typedAt});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiClient _apiClient;

  ChatRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = prefs!.getString('jwtToken');
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

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        if (responseJson != null) {
          List<dynamic> jsonList = responseJson;
          List<ChatUserModel> chatUserLists = jsonList.map((json) => ChatUserModel.fromJson(json)).toList();
          return chatUserLists;
        } else {
          throw Exception(response.statusMessage);
        }
      }
    } catch (e) {
      log("getChatUsersList Error", error: e);
      return [];
    }
    return [];
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

      var responseJson = response!.data;
      if (responseJson != null) {
        var responseMsg = responseJson['message'];
        if (responseMsg == "Conversation created successfully") {
          return true;
        } else if (responseMsg == "Conversation already exists") {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      log("getChatUsersList Error", error: e);
      return false;
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

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        if (responseJson != null) {
          var responseJson = response.data;
          if (responseJson != null) {
            List<dynamic> jsonList = responseJson;
            List<ChatMessageModel> chatMessages = jsonList.map((json) => ChatMessageModel.fromJson(json)).toList();
            return chatMessages;
          } else {
            throw Exception(response.statusMessage);
          }
        } else {
          throw Exception(response.statusMessage);
        }
      }
    } catch (e) {
      log("getChatUsersList Error", error: e);
      return [];
    }
    return [];
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

      var responseJson = response!.data;
      if (responseJson != null) {
        var responseMsg = responseJson['message'];
        if (responseMsg == "Message sent successfully") {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      log("getChatUsersList Error", error: e);
      return false;
    }
  }
}
