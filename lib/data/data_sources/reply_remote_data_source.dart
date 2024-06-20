import 'dart:developer';

import 'package:dio/dio.dart';

import '../../main.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/comment_model.dart';
import '../models/like_model.dart';

abstract class ReplyRemoteDataSource {
  Future<bool> postReply(String? userId, String? threadId, String? commentText, String? replyId);
  Future<List<CommentModel>> getAllComments(String? threadId);
  Future<LikeModel?>? getCommentLike(String? threadId);
  Future<List<CommentModel>> getAllReplyOnComment(String? commentId);
}

class ReplyRemoteDataSourceImpl implements ReplyRemoteDataSource {
  final ApiClient _apiClient;

  ReplyRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = prefs!.getString('jwtToken');
    return jwtToken ?? "";
  }

  @override
  Future<bool> postReply(String? userId, String? threadId, String? commentText, String? replyId) async {
    var jwtToken = await getJwtToken();
    print(jwtToken);
    try {
      var body = {
        'user_id': userId,
        if (threadId != null) 'thread_id': threadId,
        'comment': commentText,
        if (replyId != null) 'reply_id': replyId,
      };
      Response? response = await _apiClient.postReq(
        url: ApiConstants.postReply,
        body: body,
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
      log("postReply Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<List<CommentModel>> getAllComments(String? threadId) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getAllComments}/$threadId",
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          final responseJson = response.data ?? [];
          log(responseJson.toString());
          return (responseJson as List).map((json) => CommentModel.fromJson(json)).toList();
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("getAllComments Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<LikeModel?>? getCommentLike(String? replyId) async {
    var jwtToken = await getJwtToken();
    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getCommentsLike}/$replyId",
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response?.data != "") {
          if (response!.statusCode == 200) {
            var responseJson = response.data;
            log(responseJson.toString());
            return LikeModel.fromJson(responseJson);
          } else {
            throw AppError(statusCode: response.statusCode);
          }
        } else {
          return LikeModel();
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("getCommentLike Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<List<CommentModel>> getAllReplyOnComment(String? commentId) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getAllReplyOnComment}/$commentId",
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          final responseJson = response.data ?? [];
          log(responseJson.toString());
          return (responseJson as List).map((json) => CommentModel.fromJson(json)).toList();
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("getAllReplyOnComment Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }
}
