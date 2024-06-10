import 'dart:io';

import 'package:briefsea/data/models/avatar_model.dart';
import 'package:briefsea/data/models/banner_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/user_profile_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/image_model.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/repositories/user_profile_repository.dart';

part 'user_profile_provider.g.dart';

@riverpod
UserProfileRemoteDataSource userProfileRemoteDataSource(UserProfileRemoteDataSourceRef ref) {
  final apiClient = getItInstance<ApiClient>();
  return UserProfileRemoteDataSourceImpl(apiClient);
}

@riverpod
UserProfileRepository userProfileRepository(UserProfileRepositoryRef ref) {
  final userProfileRemoteDataSource = ref.read(userProfileRemoteDataSourceProvider);
  return UserProfileRepository(userProfileRemoteDataSource);
}

@riverpod
Future<UserProfileModel> getUserProfile(GetUserProfileRef ref) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherUserProfilenOrError = await userProfileRepository.getUserProfile();
  return eitherUserProfilenOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (userProfile) => userProfile,
  );
}

@riverpod
Future<String> verifyProfile(VerifyProfileRef ref,
    {required userId,
    required uName,
    required countryCode,
    required contact,
    required jobTitle,
    required company,
    required industry,
    required expertise,
    required location,
    required avatarSrc,
    required bannerSrc,
    required jwtToken}) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherVerifyProfilenOrError = await userProfileRepository.verifyProfile(
      userId, uName, countryCode, contact, jobTitle, company, industry, expertise, location, avatarSrc, bannerSrc, jwtToken);
  return eitherVerifyProfilenOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (verifyProfile) => verifyProfile,
  );
}

@riverpod
Future<AvatarModel> uploadAvatar(UploadAvatarRef ref, {required fileName, required fileType, required userId, required userType}) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherAvatarModelnOrError = await userProfileRepository.uploadAvatar(fileName, fileType, userId, userType);
  return eitherAvatarModelnOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (avatarModel) => avatarModel,
  );
}

@riverpod
Future<BannerModel> uploadBanner(UploadBannerRef ref, {required fileName, required fileType, required userId, required userType}) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherBannerModelnOrError = await userProfileRepository.uploadBanner(fileName, fileType, userId, userType);
  return eitherBannerModelnOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (bannerModel) => bannerModel,
  );
}

@riverpod
Future<bool> uploadToAWS(UploadToAWSRef ref, {required url, required fileName, required File file, required MediaType fileType}) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherUploadednOrError = await userProfileRepository.uploadToAWS(url, fileName, file, fileType);
  return eitherUploadednOrError.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (uploaded) => uploaded,
  );
}

@riverpod
Future<ImageModel> getImage(GetImageRef ref, {required String src}) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherImageOrError = await userProfileRepository.getImage(src);
  return eitherImageOrError.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (image) => image,
  );
}
