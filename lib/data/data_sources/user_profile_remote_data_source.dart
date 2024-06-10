import 'dart:developer';
import 'dart:io';

import 'package:briefsea/data/core/api_constants.dart';
import 'package:briefsea/data/models/avatar_model.dart';
import 'package:briefsea/data/models/banner_model.dart';
import 'package:briefsea/data/models/image_model.dart';
import 'package:briefsea/main.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../core/api_client.dart';
import '../models/user_profile_model.dart';

abstract class UserProfileRemoteDataSource {
  Future<UserProfileModel?>? getUserProfile();
  Future<String?>? verifyProfile(
      userId, name, countryCode, contact, jobTitle, company, industry, expertise, location, avatarSrc, bannerSrc, jwtToken);
  Future<AvatarModel?>? uploadAvatar(fileName, MediaType fileType, userId, userType);
  Future<BannerModel?>? uploadBanner(fileName, MediaType fileType, userId, userType);
  Future<bool> uploadToAWS(url, fileName, File file, MediaType fileType);
  Future<ImageModel> getImage(src);
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final ApiClient _apiClient;

  UserProfileRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = prefs!.getString('jwtToken');
    return jwtToken!;
  }

  @override
  Future<UserProfileModel?>? getUserProfile() async {
    var jwtToken = await getJwtToken();
    print(jwtToken);
    try {
      Response? response = await _apiClient.getReq(
        url: ApiConstants.getUserProfile,
        jwtToken: jwtToken,
      );

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        if (responseJson != null) {
          return UserProfileModel.fromJson(responseJson);
        }
      }
    } catch (e) {
      log("GetUserProfile Error", error: e);
    }
    return null;
  }

  @override
  Future<String?>? verifyProfile(
      userId, name, countryCode, contact, jobTitle, company, industry, expertise, location, avatarSrc, bannerSrc, jwtToken) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'isVerified': false,
        'user_id': userId,
        'name': name,
        'countryCode': int.tryParse(countryCode),
        'contact': int.tryParse(contact),
        'post': jobTitle,
        'worksAt': company,
        'industry': industry,
        'expertise': expertise,
        'location': location,
        'avatarSrc': avatarSrc,
        'bannerSrc': bannerSrc,
      };

      Response? response = await _apiClient.postReq(
        url: ApiConstants.verifyProfile,
        body: body,
        jwtToken: jwtToken,
      );

      var responseJson = response!.data;
      var responseMsg = responseJson['message'];
      if (responseMsg == "Profile added cuccessfully") {
        return responseMsg;
      }
    } catch (e) {
      log("GetUserProfile Error", error: e);
      return "Failed to add Profile";
    }
    return "Failed to add Profile";
  }

  @override
  Future<AvatarModel?>? uploadAvatar(fileName, MediaType fileType, userId, userType) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'name': fileName,
        'type': fileType.subtype,
        'id': userId,
        'utype': userType,
      };

      Response? response = await _apiClient.putReq(
        url: ApiConstants.uploadAvatar,
        body: body,
        jwtToken: jwtToken,
      );

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        log(responseJson.toString());
        if (responseJson != null) {
          return AvatarModel.fromJson(responseJson);
        }
      }
    } catch (e) {
      log("uploadAvatar Error", error: e);
    }
    return null;
  }

  @override
  Future<BannerModel?>? uploadBanner(fileName, MediaType fileType, userId, userType) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'name': fileName,
        'type': fileType.subtype,
        'id': userId,
        'utype': userType,
      };

      Response? response = await _apiClient.putReq(
        url: ApiConstants.uploadBanner,
        body: body,
        jwtToken: jwtToken,
      );

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        log(responseJson.toString());
        if (responseJson != null) {
          return BannerModel.fromJson(responseJson);
        }
      }
    } catch (e) {
      log("uploadBanner Error", error: e);
    }
    return null;
  }

  @override
  Future<bool> uploadToAWS(url, fileName, File file, MediaType fileType) async {
    var jwtToken = await getJwtToken();
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: fileType,
        ),
      });

      Response? response = await _apiClient.putReq(
        url: url,
        body: formData,
        jwtToken: null,
      );

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        log("${responseJson}Successfully uploaded");
        if (responseJson != null) {
          return true;
        }
      }
    } catch (e) {
      log("uploadToAWS Error", error: e);
      return false;
    }
    return false;
  }

  @override
  Future<ImageModel> getImage(src) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'key': src,
      };

      Response? response = await _apiClient.postReq(
        url: ApiConstants.getImage,
        body: body,
        jwtToken: jwtToken,
      );

      if (response!.statusCode == 200) {
        var responseJson = response.data;
        log(responseJson.toString());
        if (responseJson != null) {
          return ImageModel.fromJson(responseJson);
        }
      }
    } catch (e) {
      log("uploadBanner Error", error: e);
      return ImageModel(url: "");
    }
    return ImageModel(url: "");
  }
}
