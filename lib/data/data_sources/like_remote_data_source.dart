import 'dart:developer';

import 'package:dio/dio.dart';

import '../../common/app_utils/shared_prefs_helper.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/like_model.dart';

abstract class LikeRemoteDataSource {
  Future<String?>? postLike({String? userId, String? name, String? type, String? threadId, String? replyId});
  Future<LikeModel?>? getALike(String? threadId);
  Future<bool>? deleteLike(String? threadId, String? likeId);
}

class LikeRemoteDataSourceImpl implements LikeRemoteDataSource {
  final ApiClient _apiClient;

  LikeRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = await SharedPreferencesHelper.getString('jwtToken');
    return jwtToken ?? "";
  }

  @override
  Future<String?>? postLike({String? userId, String? name, String? type, String? threadId, String? replyId}) async {
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
      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 201) {
          var responseJson = response.data;
          log(responseJson.toString());
          return responseJson['like_id'];
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("postLike Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<LikeModel?>? getALike(String? threadId) async {
    var jwtToken = await getJwtToken();
    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getALike}/$threadId",
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
      log("getALike Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool>? deleteLike(String? threadId, String? likeId) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'thread_id': threadId,
      };

      Response? response = await _apiClient.patchReq(
        url: "${ApiConstants.removeLike}/$likeId",
        body: body,
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
      log("deleteLike Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }
}
