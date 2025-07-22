import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

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

  static final getUserProfileProvider = FutureProvider.autoDispose<UserProfileModel>((ref) async {
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
      specificFields: params.specificFields,
      fullProfileData: params.fullProfileData,
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
      specificFields: params.specificFields,
      fullProfileData: params.fullProfileData,
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

  static final getUserAvatarProvider = FutureProvider<String>((ref) async {
    final userProfileRepository = ref.watch(userProfileRepositoryProvider);
    final eitherUserAvatarOrError = await userProfileRepository.getUserAvatar();
    return eitherUserAvatarOrError.fold(
      (error) => throw error,
      (userAvatar) => userAvatar,
    );
  });
}

class UserAvatarNotifier extends StateNotifier<String?> {
  UserAvatarNotifier(this._userProfileRepository) : super(null);

  final UserProfileRepository _userProfileRepository;
  final Dio _dio = Dio();

  Future<void> loadUserAvatar() async {
    try {
      // Fetch the avatar URL from the API
      final eitherUserAvatarOrError = await _userProfileRepository.getUserAvatar();
      final userAvatarUrl = eitherUserAvatarOrError.fold(
        (error) => throw error,
        (userAvatar) => userAvatar,
      );

      if (userAvatarUrl.isEmpty) {
        // Handle the case where the user has no avatar
        state = null;
        return;
      }

      final fileName = extractFileName(userAvatarUrl);
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      // Check if the image already exists locally
      if (File(filePath).existsSync()) {
        state = filePath;
      } else {
        // Download and save the image locally
        final response = await _dio.download(userAvatarUrl, filePath);

        if (response.statusCode == 200) {
          state = filePath; // Update the state with the local file path
        } else {
          throw Exception('Failed to download image: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error loading avatar: $e');
      state = null;
    }
  }

  String extractFileName(String imageUrl) {
    final uri = Uri.parse(imageUrl);
    final fileName = uri.pathSegments.last;
    return fileName;
  }
}

final userAvatarNotifierProvider = StateNotifierProvider<UserAvatarNotifier, String?>((ref) {
  final userProfileRepository = ref.watch(UserProfileProvider.userProfileRepositoryProvider);
  return UserAvatarNotifier(userProfileRepository);
});
