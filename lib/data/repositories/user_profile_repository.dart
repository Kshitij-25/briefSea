import 'dart:io';

import 'package:dartz/dartz.dart';

import '../core/app_error.dart';
import '../data_sources/user_profile_remote_data_source.dart';
import '../models/avatar_model.dart';
import '../models/banner_model.dart';
import '../models/image_model.dart';
import '../models/user_profile_model.dart';

class UserProfileRepository {
  final UserProfileRemoteDataSource _userProfileRemoteDataSource;

  UserProfileRepository(this._userProfileRemoteDataSource);

  Future<Either<AppError, UserProfileModel>>? getUserProfile() async {
    try {
      final userProfileModel = await _userProfileRemoteDataSource.getUserProfile();
      return Right(userProfileModel!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, String>>? verifyProfile({
    String? userId,
    String? name,
    int? countryCode,
    int? contact,
    String? jobTitle,
    String? company,
    String? industry,
    String? expertise,
    String? location,
    String? avatarSrc,
    String? bannerSrc,
    String? jwtToken,
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
        expertise: expertise,
        location: location,
        avatarSrc: avatarSrc,
        bannerSrc: bannerSrc,
        jwtToken: jwtToken,
      );
      return Right(verifyProfile!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, String>>? editProfile({
    String? userId,
    String? name,
    int? countryCode,
    int? contact,
    String? jobTitle,
    String? company,
    String? industry,
    String? expertise,
    String? location,
    String? avatarSrc,
    String? bannerSrc,
    String? jwtToken,
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
        expertise: expertise,
        location: location,
        avatarSrc: avatarSrc,
        bannerSrc: bannerSrc,
        jwtToken: jwtToken,
      );
      return Right(verifyProfile!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
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
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
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
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, bool>> uploadToAWS(String? url, String? fileName, File file, String? fileType) async {
    try {
      final isUploaded = await _userProfileRemoteDataSource.uploadToAWS(url, fileName, file, fileType);
      return Right(isUploaded);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, ImageModel>> getImage(String src) async {
    try {
      final imageUrl = await _userProfileRemoteDataSource.getImage(src);
      return Right(imageUrl);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
