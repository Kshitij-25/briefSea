import 'dart:developer';

import 'package:dio/dio.dart';

import '../../main.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/like_model.dart';

abstract class LikeRemoteDataSource {
  Future<bool>? postLike({String? userId, String? name, String? type, String? threadId, String? replyId});
  Future<LikeModel?>? getALike(String? threadId);
  Future<bool>? deleteLike(String? threadId, String? likeId);
}

class LikeRemoteDataSourceImpl implements LikeRemoteDataSource {
  final ApiClient _apiClient;

  LikeRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = prefs!.getString('jwtToken');
    return jwtToken ?? "";
  }

  @override
  Future<bool>? postLike({String? userId, String? name, String? type, String? threadId, String? replyId}) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'user_id': userId,
        'name': name,
        'type': type,
        if (threadId != null) 'thread_id': threadId,
        if (replyId != null) 'reply_id': replyId,
      };

      Response? response = await _apiClient.postReq(
        url: ApiConstants.likeUrl,
        body: body,
        jwtToken: jwtToken,
      );

      // if (response!.statusCode == 200) {
      var responseJson = response!.data;
      log(responseJson.toString());
      if (responseJson != null) {
        return true;
      }
      // }
    } catch (e) {
      log("postLike Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
    throw AppError();
  }

  @override
  Future<LikeModel?>? getALike(String? threadId) async {
    var jwtToken = await getJwtToken();
    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getALike}/$threadId",
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
      log("getALike Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
    throw AppError();
  }

  @override
  Future<bool>? deleteLike(String? threadId, String? likeId) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'thread_id': threadId,
      };

      Response? response = await _apiClient.patchReq(
        url: "${ApiConstants.removelike}/$likeId",
        body: body,
        jwtToken: jwtToken,
      );

      // if (response!.statusCode == 200) {
      var responseJson = response!.data;
      if (responseJson != null) {
        return true;
      }
      // }
    } catch (e) {
      log("deleteLike Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
    throw AppError();
  }
}
