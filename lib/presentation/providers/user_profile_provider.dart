import 'dart:io';

import 'package:briefsea/data/models/login_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/app_utils/shared_prefs_helper.dart';
import '../../data/core/api_client.dart';
import '../../data/data_sources/user_profile_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/avatar_model.dart';
import '../../data/models/banner_model.dart';
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
Future<UserProfileModel> getOtherProfile(GetOtherProfileRef ref, {required String? otherUserId}) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherUserProfilenOrError = await userProfileRepository.getOtherProfile(otherUserId);
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
  required List<String>? industry,
  required List<String>? expertise,
  required String? location,
  required String? avatarSrc,
  required String? bannerSrc,
  required String? jwtToken,
  required String? postingAs,
  required String? gender,
  required String? username,
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
    postingAs: postingAs,
    gender: gender,
    username: username,
  );
  return eitherVerifyProfilenOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (verifyProfile) async {
      // ignore: unused_result
      LoginModel().copyWith(
        profile: true,
      );
      await SharedPreferencesHelper.saveBoolean('profile', true);
      return verifyProfile;
    },
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
  required List<String>? industry,
  required List<String>? expertise,
  required String? location,
  required String? avatarSrc,
  required String? bannerSrc,
  required String? jwtToken,
  required String? postingAs,
  required String? gender,
  required String? createdAt,
  required String? updatedAt,
  required String? userName,
  required bool? viewAccess,
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
    postingAs: postingAs,
    gender: gender,
    createdAt: createdAt,
    updatedAt: updatedAt,
    userName: userName,
    viewAccess: viewAccess,
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
  required String? fileType,
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
  required String? fileType,
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
Future<bool> uploadToAWS(UploadToAWSRef ref, {required String? url, required String? fileName, required File file, required String? fileType}) async {
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

@riverpod
Future<bool> deleteAccount(DeleteAccountRef ref, {required String userId}) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherAccountDeletedOrError = await userProfileRepository.deleteAccount(userId);
  return eitherAccountDeletedOrError.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (accountDeleted) => accountDeleted,
  );
}

@riverpod
Future<bool> checkUserName(CheckUserNameRef ref, {required String userName}) async {
  final userProfileRepository = ref.read(userProfileRepositoryProvider);
  final eitherUserNameExistsOrError = await userProfileRepository.checkUserName(userName);
  return eitherUserNameExistsOrError.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (userNameExists) => userNameExists,
  );
}
