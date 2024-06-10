import 'dart:developer';

import 'package:briefsea/data/models/comment_model.dart';
import 'package:dio/dio.dart';

import '../../main.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../models/like_model.dart';

abstract class ReplyRemoteDataSource {
  Future<bool> postReply(userId, threadId, commentText);
  Future<List<CommentModel>> getAllComments(threadId);
  Future<LikeModel?>? getCommentLike(threadId);
}

class ReplyRemoteDataSourceImpl implements ReplyRemoteDataSource {
  final ApiClient _apiClient;

  ReplyRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = prefs!.getString('jwtToken');
    return jwtToken!;
  }

  @override
  Future<bool> postReply(userId, threadId, commentText) async {
    var jwtToken = await getJwtToken();
    print(jwtToken);
    try {
      var body = {
        'user_id': userId,
        'thread_id': threadId,
        'comment': commentText,
      };
      Response? response = await _apiClient.postReq(
        url: ApiConstants.postReply,
        body: body,
        jwtToken: jwtToken,
      );

      var responseJson = response!.data;
      if (responseJson != null) {
        return true;
      }
    } catch (e) {
      log("postReply Error", error: e);
    }
    return false;
  }

  @override
  Future<List<CommentModel>> getAllComments(threadId) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getAllComments}/$threadId",
        jwtToken: jwtToken,
      );

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        if (responseJson != null) {
          List<dynamic> jsonList = responseJson;
          List<CommentModel> commentModel = jsonList.map((json) => CommentModel.fromJson(json)).toList();
          return commentModel;
        }
      }
    } catch (e) {
      log("getAllComments Error", error: e);
      return [];
    }
    return [];
  }

  @override
  Future<LikeModel?>? getCommentLike(replyId) async {
    var jwtToken = await getJwtToken();
    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getCommentsLike}/$replyId",
        jwtToken: jwtToken,
      );

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        if (responseJson != "") {
          return LikeModel.fromJson(responseJson);
        } else {
          return LikeModel();
        }
      }
    } catch (e) {
      log("getCommentLike Error", error: e);
      return null;
    }
    return null;
  }
}
