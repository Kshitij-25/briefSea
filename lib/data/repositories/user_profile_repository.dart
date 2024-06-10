import 'dart:io';

import 'package:briefsea/data/models/avatar_model.dart';
import 'package:briefsea/data/models/banner_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';

import '../core/app_error.dart';
import '../data_sources/user_profile_remote_data_source.dart';
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

  Future<Either<AppError, String>>? verifyProfile(
      userId, name, countryCode, contact, jobTitle, company, industry, expertise, location, avatarSrc, bannerSrc, jwtToken) async {
    try {
      final verifyProfile = await _userProfileRemoteDataSource.verifyProfile(
          userId, name, countryCode, contact, jobTitle, company, industry, expertise, location, avatarSrc, bannerSrc, jwtToken);
      return Right(verifyProfile!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, AvatarModel>>? uploadAvatar(fileName, fileType, userId, userType) async {
    try {
      final avatarModel = await _userProfileRemoteDataSource.uploadAvatar(fileName, fileType, userId, userType);
      return Right(avatarModel!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, BannerModel>>? uploadBanner(fileName, fileType, userId, userType) async {
    try {
      final bannerModel = await _userProfileRemoteDataSource.uploadBanner(fileName, fileType, userId, userType);
      return Right(bannerModel!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, bool>> uploadToAWS(url, fileName, File file, MediaType fileType) async {
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
