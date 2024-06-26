import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../main.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/briefs_model.dart';
import '../models/thread_image_model.dart';

abstract class BriefsRemoteDataSource {
  Future<List<BriefsModel?>?> getAllBriefs();
  Future<List<BriefsModel?>?> getUserBriefs();
  Future<bool> postBrief({String? userId, String? name, String? type, String? category, String? postText, String? imgSrc});
  Future<ThreadImageModel?>? uploadThreadImage(String? fileName, MediaType fileType, String? userId, String? userType);
  Future<bool> deleteBrief({String? briefId});
  Future<bool> editBrief({String? briefId, bool? isVisible});
}

class BriefsRemoteDataSourceImpl implements BriefsRemoteDataSource {
  final ApiClient _apiClient;

  BriefsRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = prefs!.getString('jwtToken');
    return jwtToken ?? "";
  }

  @override
  Future<List<BriefsModel?>?> getAllBriefs() async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: ApiConstants.getAllBriefs,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          final responseJson = response.data ?? [];
          log(responseJson.toString());
          return (responseJson as List).map((json) => BriefsModel.fromJson(json)).toList();
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("getAllBriefs Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<List<BriefsModel?>?> getUserBriefs() async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: ApiConstants.getUserBriefs,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          final responseJson = response.data ?? [];
          log(responseJson.toString());
          return (responseJson as List).map((json) => BriefsModel.fromJson(json)).toList();
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("getUserBriefs Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> postBrief({
    String? userId,
    String? name,
    String? type,
    String? category,
    String? postText,
    String? imgSrc,
  }) async {
    var jwtToken = await getJwtToken();

    try {
      var body = {
        "user_id": userId,
        "name": name,
        "type": type,
        "category": category,
        "postText": postText,
        "imgSrc": imgSrc ?? "",
      };
      Response? response = await _apiClient.postReq(
        url: ApiConstants.postBrief,
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
      log("postBrief Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<ThreadImageModel?>? uploadThreadImage(
    String? fileName,
    MediaType fileType,
    String? userId,
    String? userType,
  ) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'name': fileName,
        'type': fileType.subtype,
        'id': userId,
        'utype': userType,
      };

      Response? response = await _apiClient.putReq(
        url: ApiConstants.uploadThreadImage,
        body: body,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
          return ThreadImageModel.fromJson(responseJson);
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("uploadThreadImage Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> deleteBrief({String? briefId}) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.deleteReq(
        url: "${ApiConstants.deleteBrief}/$briefId",
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
      log("deleteBrief Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> editBrief({String? briefId, bool? isVisible}) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'isVisible': isVisible,
      };

      Response? response = await _apiClient.patchReq(
        url: "${ApiConstants.editBrief}/$briefId",
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
      log("editBrief Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }
}
