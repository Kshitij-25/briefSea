import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../common/app_utils/shared_prefs_helper.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/avatar_model.dart';
import '../models/banner_model.dart';
import '../models/edit_profile_model.dart';
import '../models/image_model.dart';
import '../models/user_profile_model.dart';

abstract class UserProfileRemoteDataSource {
  Future<UserProfileModel?>? getUserProfile();
  Future<UserProfileModel?>? getOtherProfile(String? otherUserId);
  Future<String?>? verifyProfile({
    String? userId,
    String? name,
    int? countryCode,
    int? contact,
    String? jobTitle,
    String? company,
    List<String>? industry,
    List<String>? devExpertise,
    List<String>? markExpertise,
    String? location,
    String? avatarSrc,
    String? bannerSrc,
    String? jwtToken,
    String? postingAs,
    String? gender,
    String? username,
    String? aboutMe,
  });
  Future<EditProfileModel?>? editProfile({
    String? userId,
    String? name,
    int? countryCode,
    int? contact,
    String? jobTitle,
    String? company,
    List<String>? industry,
    List<String>? devExpertise,
    List<String>? markExpertise,
    String? location,
    String? avatarSrc,
    String? bannerSrc,
    String? jwtToken,
    String? postingAs,
    String? gender,
    String? createdAt,
    String? updatedAt,
    String? userName,
    bool? viewAccess,
    String? aboutMe,
  });
  Future<AvatarModel?>? uploadAvatar(String? fileName, String? fileType, String? userId, String? userType);
  Future<BannerModel?>? uploadBanner(String? fileName, String? fileType, String? userId, String? userType);
  Future<bool> uploadToAWS(String? url, String? fileName, File file, String? fileType);
  Future<ImageModel> getImage(String? src);
  Future<bool> deleteAccount(String? userId);
  Future<bool> checkUserName(String? userName);
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final ApiClient _apiClient;

  UserProfileRemoteDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = await SharedPreferencesHelper.getString('jwtToken');
    return jwtToken ?? "";
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

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
          return UserProfileModel.fromJson(responseJson);
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("GetUserProfile Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<UserProfileModel?>? getOtherProfile(String? otherUserId) async {
    var jwtToken = await getJwtToken();
    print(jwtToken);
    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.getOtherProfile}/$otherUserId",
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
          return UserProfileModel.fromJson(responseJson);
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("getOtherProfile Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<String?>? verifyProfile({
    String? userId,
    String? name,
    int? countryCode,
    int? contact,
    String? jobTitle,
    String? company,
    List<String>? industry,
    List<String>? devExpertise,
    List<String>? markExpertise,
    String? location,
    String? avatarSrc,
    String? bannerSrc,
    String? jwtToken,
    String? postingAs,
    String? gender,
    String? username,
    String? aboutMe,
  }) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'isVerified': false,
        'user_id': userId,
        'name': name,
        'countryCode': countryCode,
        'contact': contact,
        'post': jobTitle,
        'worksAt': company,
        'industry': industry,
        'devExpertise': devExpertise,
        'markExpertise': markExpertise,
        'location': location,
        'avatarSrc': avatarSrc,
        'bannerSrc': bannerSrc,
        "postingAs": postingAs,
        'gender': gender,
        "userName": username,
        'about': aboutMe,
      };

      Response? response = await _apiClient.postReq(
        url: ApiConstants.verifyProfile,
        body: body,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 201) {
          var responseJson = response.data;
          log(responseJson.toString());
          var responseMsg = responseJson['message'];
          if (responseMsg == "Profile added successfully") {
            return responseMsg;
          }
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("GetUserProfile Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
    throw AppError();
  }

  @override
  Future<EditProfileModel?>? editProfile({
    String? userId,
    String? name,
    int? countryCode,
    int? contact,
    String? jobTitle,
    String? company,
    List<String>? industry,
    List<String>? devExpertise,
    List<String>? markExpertise,
    String? location,
    String? avatarSrc,
    String? bannerSrc,
    String? jwtToken,
    String? postingAs,
    String? gender,
    String? createdAt,
    String? updatedAt,
    String? userName,
    bool? viewAccess,
    String? aboutMe,
  }) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'isVerified': false,
        'user_id': userId,
        'name': name,
        'countryCode': countryCode,
        'contact': contact,
        'post': jobTitle,
        'worksAt': company,
        'industry': industry,
        'devExpertise': devExpertise,
        'markExpertise': markExpertise,
        'location': location,
        'avatarSrc': avatarSrc,
        'bannerSrc': bannerSrc,
        "postingAs": postingAs,
        'gender': gender,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'userName': userName,
        'viewAccess': viewAccess,
        'about': aboutMe,
      };

      Response? response = await _apiClient.patchReq(
        url: "${ApiConstants.editProfile}/$userId",
        body: body,
        jwtToken: jwtToken,
      );

      var responseJson = response?.data;
      log(responseJson.toString());
      return EditProfileModel.fromJson(responseJson);
    } catch (e) {
      log("EditProfile Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<AvatarModel?>? uploadAvatar(String? fileName, String? fileType, String? userId, String? userType) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'name': fileName,
        'type': fileType,
        'id': userId,
        'utype': userType,
      };

      Response? response = await _apiClient.putReq(
        url: ApiConstants.uploadAvatar,
        body: body,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
          return AvatarModel.fromJson(responseJson);
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("uploadAvatar Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<BannerModel?>? uploadBanner(String? fileName, String? fileType, String? userId, String? userType) async {
    var jwtToken = await getJwtToken();
    try {
      var body = {
        'name': fileName,
        'type': fileType,
        'id': userId,
        'utype': userType,
      };

      Response? response = await _apiClient.putReq(
        url: ApiConstants.uploadBanner,
        body: body,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
          return BannerModel.fromJson(responseJson);
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("uploadBanner Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> uploadToAWS(String? url, String? fileName, File file, String? fileType) async {
    try {
      Uint8List image = File(file.path).readAsBytesSync();

      Response? response = await _apiClient.putReq(
        url: url,
        body: image,
        contentType: image.length,
        mimeType: fileType,
        jwtToken: null,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log("${responseJson}Successfully uploaded");
          return true;
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("uploadToAWS Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<ImageModel> getImage(String? src) async {
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

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          var responseJson = response.data;
          log(responseJson.toString());
          return ImageModel.fromJson(responseJson);
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        throw AppError();
      }
    } catch (e) {
      log("getImage Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> deleteAccount(String? userId) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.deleteReq(
        url: "${ApiConstants.deleteAccount}/$userId",
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
      log("deleteAccount Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> checkUserName(String? userName) async {
    var jwtToken = await getJwtToken();

    try {
      Response? response = await _apiClient.getReq(
        url: "${ApiConstants.checkUsername}$userName",
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
      log("checkUserName Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }
}
