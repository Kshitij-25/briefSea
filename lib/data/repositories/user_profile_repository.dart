import 'dart:io';

import 'package:dartz/dartz.dart';

import '../core/app_error.dart';
import '../data_sources/user_profile_remote_data_source.dart';
import '../models/avatar_model.dart';
import '../models/banner_model.dart';
import '../models/edit_profile_model.dart';
import '../models/image_model.dart';
import '../models/user_profile_model.dart';

class UserProfileRepository {
  final UserProfileRemoteDataSource _userProfileRemoteDataSource;

  UserProfileRepository(this._userProfileRemoteDataSource);

  Future<Either<AppError, UserProfileModel>>? getUserProfile() async {
    try {
      final userProfileModel = await _userProfileRemoteDataSource.getUserProfile();
      return Right(userProfileModel!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, UserProfileModel>>? getOtherProfile(String? otherUserId) async {
    try {
      final userProfileModel = await _userProfileRemoteDataSource.getOtherProfile(otherUserId);
      return Right(userProfileModel!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, String>>? verifyProfile({
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
    try {
      final verifyProfile = await _userProfileRemoteDataSource.verifyProfile(
        userId: userId,
        name: name,
        countryCode: countryCode,
        contact: contact,
        jobTitle: jobTitle,
        company: company,
        industry: industry,
        devExpertise: devExpertise,
        markExpertise: markExpertise,
        location: location,
        avatarSrc: avatarSrc,
        bannerSrc: bannerSrc,
        jwtToken: jwtToken,
        postingAs: postingAs,
        gender: gender,
        username: username,
        aboutMe: aboutMe,
      );
      return Right(verifyProfile!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, EditProfileModel>>? editProfile({
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
    try {
      final verifyProfile = await _userProfileRemoteDataSource.editProfile(
        userId: userId,
        name: name,
        countryCode: countryCode,
        contact: contact,
        jobTitle: jobTitle,
        company: company,
        industry: industry,
        devExpertise: devExpertise,
        markExpertise: markExpertise,
        location: location,
        avatarSrc: avatarSrc,
        bannerSrc: bannerSrc,
        jwtToken: jwtToken,
        postingAs: postingAs,
        gender: gender,
        createdAt: createdAt,
        updatedAt: updatedAt,
        userName: userName,
        viewAccess: viewAccess,
        aboutMe: aboutMe,
      );
      return Right(verifyProfile!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, AvatarModel>>? uploadAvatar(
    String? fileName,
    String? fileType,
    String? userId,
    String? userType,
  ) async {
    try {
      final avatarModel = await _userProfileRemoteDataSource.uploadAvatar(fileName, fileType, userId, userType);
      return Right(avatarModel!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, BannerModel>>? uploadBanner(
    String? fileName,
    String? fileType,
    String? userId,
    String? userType,
  ) async {
    try {
      final bannerModel = await _userProfileRemoteDataSource.uploadBanner(fileName, fileType, userId, userType);
      return Right(bannerModel!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>> uploadToAWS(String? url, String? fileName, File file, String? fileType) async {
    try {
      final isUploaded = await _userProfileRemoteDataSource.uploadToAWS(url, fileName, file, fileType);
      return Right(isUploaded);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, ImageModel>> getImage(String src) async {
    try {
      final imageUrl = await _userProfileRemoteDataSource.getImage(src);
      return Right(imageUrl);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>> deleteAccount(String userId) async {
    try {
      final isAccountDeleted = await _userProfileRemoteDataSource.deleteAccount(userId);
      return Right(isAccountDeleted);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>> checkUserName(String userName) async {
    try {
      final userNameExists = await _userProfileRemoteDataSource.checkUserName(userName);
      return Right(userNameExists);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }
}
