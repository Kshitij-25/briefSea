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
Future<String> verifyProfile(
  VerifyProfileRef ref, {
  required String? userId,
  required String? uName,
  required int? countryCode,
  required int? contact,
  required String? jobTitle,
  required String? company,
  required String? industry,
  required String? expertise,
  required String? location,
  required String? avatarSrc,
  required String? bannerSrc,
  required String? jwtToken,
}) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherVerifyProfilenOrError = await userProfileRepository.verifyProfile(
    userId: userId,
    name: uName,
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
  return eitherVerifyProfilenOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (verifyProfile) => verifyProfile,
  );
}

@riverpod
Future<String> editProfile(
  EditProfileRef ref, {
  required String? userId,
  required String? uName,
  required int? countryCode,
  required int? contact,
  required String? jobTitle,
  required String? company,
  required String? industry,
  required String? expertise,
  required String? location,
  required String? avatarSrc,
  required String? bannerSrc,
  required String? jwtToken,
}) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherEditProfileOrError = await userProfileRepository.editProfile(
    userId: userId,
    name: uName,
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
  return eitherEditProfileOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (editProfile) => editProfile,
  );
}

@riverpod
Future<AvatarModel> uploadAvatar(
  UploadAvatarRef ref, {
  required String? fileName,
  required MediaType fileType,
  required String? userId,
  required String? userType,
}) async {
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
Future<BannerModel> uploadBanner(
  UploadBannerRef ref, {
  required String? fileName,
  required MediaType fileType,
  required String? userId,
  required String? userType,
}) async {
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
Future<bool> uploadToAWS(UploadToAWSRef ref,
    {required String? url, required String? fileName, required File file, required MediaType fileType}) async {
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
