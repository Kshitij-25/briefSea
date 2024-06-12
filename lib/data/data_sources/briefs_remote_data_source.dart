import 'dart:developer';

import 'package:briefsea/main.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../models/briefs_model.dart';
import '../models/thread_image_model.dart';

abstract class BriefsRemoteDataSource {
  Future<List<BriefsModel?>?> getAllBriefs();
  Future<List<BriefsModel?>?> getUserBriefs();
  Future<bool> postBrief({String? userId, String? name, String? type, String? category, String? postText, String? imgSrc});
  Future<ThreadImageModel?>? uploadThreadImage(String? fileName, MediaType fileType, String? userId, String? userType);
}

class BriefsRemoteDataSourceImpl implements BriefsRemoteDataSource {
  final ApiClient _apiClient;

  BriefsRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = prefs!.getString('jwtToken');
    return jwtToken!;
  }

  @override
  Future<List<BriefsModel?>?> getAllBriefs() async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: ApiConstants.getAllBriefs,
        jwtToken: jwtToken,
      );

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        if (responseJson != null) {
          List<dynamic> jsonList = responseJson;
          List<BriefsModel> briefsModel = jsonList.map((json) => BriefsModel.fromJson(json)).toList();
          return briefsModel;
        } else {
          throw Exception(response.statusMessage);
        }
      }
    } catch (e) {
      log("getAllBriefs Error", error: e);
    }
    return null;
  }

  @override
  Future<List<BriefsModel?>?> getUserBriefs() async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: ApiConstants.getUserBriefs,
        jwtToken: jwtToken,
      );

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        if (responseJson != null) {
          List<dynamic> jsonList = responseJson;
          List<BriefsModel> briefsModel = jsonList.map((json) => BriefsModel.fromJson(json)).toList();
          return briefsModel;
        } else {
          throw Exception(response.statusMessage);
        }
      }
    } catch (e) {
      log("getUserBriefs Error", error: e);
    }
    return null;
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

      // if (response!.statusCode == 200) {
      var responseJson = response!.data;
      if (responseJson != null) {
        return true;
      } else {
        throw Exception(response.statusMessage);
      }
      // }
    } catch (e) {
      log("postBrief Error", error: e);
    }
    return false;
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

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        log(responseJson.toString());
        if (responseJson != null) {
          return ThreadImageModel.fromJson(responseJson);
        }
      }
    } catch (e) {
      log("uploadThreadImage Error", error: e);
    }
    return null;
  }
}
