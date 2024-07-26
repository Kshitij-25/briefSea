import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/app_utils/shared_prefs_helper.dart';
import '../../data/core/api_client.dart';
import '../../data/data_sources/user_profile_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/avatar_model.dart';
import '../../data/models/banner_model.dart';
import '../../data/models/edit_profile_model.dart';
import '../../data/models/image_model.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/repositories/user_profile_repository.dart';
import '../params/user_profile_params.dart';

class UserProfileProvider {
  static final userProfileRemoteDataSourceProvider = Provider<UserProfileRemoteDataSource>((ref) {
    final apiClient = getItInstance<ApiClient>();
    return UserProfileRemoteDataSourceImpl(apiClient);
  });

  static final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
    final userProfileRemoteDataSource = ref.watch(userProfileRemoteDataSourceProvider);
    return UserProfileRepository(userProfileRemoteDataSource);
  });

  static final getUserProfileProvider = FutureProvider<UserProfileModel>((ref) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherUserProfileOrError = await userProfileRepository.getUserProfile();
    return eitherUserProfileOrError!.fold(
      (error) => throw error,
      (userProfile) => userProfile,
    );
  });

  static final getOtherProfileProvider = FutureProvider.family<UserProfileModel, String?>((ref, otherUserId) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherUserProfileOrError = await userProfileRepository.getOtherProfile(otherUserId);
    return eitherUserProfileOrError!.fold(
      (error) => throw error,
      (userProfile) => userProfile,
    );
  });

  static final verifyProfileProvider = FutureProvider.family<String, VerifyProfileParams>((ref, params) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherVerifyProfileOrError = await userProfileRepository.verifyProfile(
      userId: params.userId,
      name: params.uName,
      countryCode: params.countryCode,
      contact: params.contact,
      jobTitle: params.jobTitle,
      company: params.company,
      industry: params.industry,
      devExpertise: params.devExpertise,
      markExpertise: params.markExpertise,
      location: params.location,
      avatarSrc: params.avatarSrc,
      bannerSrc: params.bannerSrc,
      jwtToken: params.jwtToken,
      postingAs: params.postingAs,
      gender: params.gender,
      username: params.username,
      aboutMe: params.aboutMe,
    );
    return eitherVerifyProfileOrError!.fold(
      (error) => throw error,
      (verifyProfile) async {
        await SharedPreferencesHelper.saveBoolean('profile', true);
        return verifyProfile;
      },
    );
  });

  static final editProfileProvider = FutureProvider.family<EditProfileModel, EditProfileParams>((ref, params) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherEditProfileOrError = await userProfileRepository.editProfile(
      userId: params.userId,
      name: params.uName,
      countryCode: params.countryCode,
      contact: params.contact,
      jobTitle: params.jobTitle,
      company: params.company,
      industry: params.industry,
      devExpertise: params.devExpertise,
      markExpertise: params.markExpertise,
      location: params.location,
      avatarSrc: params.avatarSrc,
      bannerSrc: params.bannerSrc,
      jwtToken: params.jwtToken,
      postingAs: params.postingAs,
      gender: params.gender,
      createdAt: params.createdAt,
      updatedAt: params.updatedAt,
      userName: params.userName,
      viewAccess: params.viewAccess,
      aboutMe: params.aboutMe,
    );
    return eitherEditProfileOrError!.fold(
      (error) => throw error,
      (editProfile) => editProfile,
    );
  });

  static final uploadAvatarProvider = FutureProvider.family<AvatarModel, UploadAvatarParams>((ref, params) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherAvatarModelOrError = await userProfileRepository.uploadAvatar(
      params.fileName,
      params.fileType,
      params.userId,
      params.userType,
    );
    return eitherAvatarModelOrError!.fold(
      (error) => throw error,
      (avatarModel) => avatarModel,
    );
  });

  static final uploadBannerProvider = FutureProvider.family<BannerModel, UploadBannerParams>((ref, params) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherBannerModelOrError = await userProfileRepository.uploadBanner(
      params.fileName,
      params.fileType,
      params.userId,
      params.userType,
    );
    return eitherBannerModelOrError!.fold(
      (error) => throw error,
      (bannerModel) => bannerModel,
    );
  });

  static final uploadToAWSProvider = FutureProvider.family<bool, UploadToAWSParams>((ref, params) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherUploadedOrError = await userProfileRepository.uploadToAWS(
      params.url,
      params.fileName,
      params.file,
      params.fileType,
    );
    return eitherUploadedOrError.fold(
      (error) => throw error,
      (uploaded) => uploaded,
    );
  });

  static final getImageProvider = FutureProvider.family<ImageModel, String>((ref, src) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherImageOrError = await userProfileRepository.getImage(src);
    return eitherImageOrError.fold(
      (error) => throw error,
      (image) => image,
    );
  });

  static final deleteAccountProvider = FutureProvider.family<bool, String>((ref, userId) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherAccountDeletedOrError = await userProfileRepository.deleteAccount(userId);
    return eitherAccountDeletedOrError.fold(
      (error) => throw error,
      (accountDeleted) => accountDeleted,
    );
  });

  static final checkUserNameProvider = FutureProvider.family<bool, String>((ref, userName) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherUserNameExistsOrError = await userProfileRepository.checkUserName(userName);
    return eitherUserNameExistsOrError.fold(
      (error) => throw error,
      (userNameExists) => userNameExists,
    );
  });
}
