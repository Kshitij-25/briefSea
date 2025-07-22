import 'dart:io';

import 'package:briefsea/presentation/params/user_profile_params.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/image_model.dart';
import '../../data/models/user_profile_model.dart';
import 'user_profile_provider.dart';

part 'image_provider.g.dart';

@riverpod
Future<String> uploadImage(
  UploadImageRef ref, {
  required String? fileName,
  required String? fileType,
  required Map<String, String> userDetails,
  required UserProfileModel? userProfileData,
  required File file,
  bool isAvatar = false,
  bool isBanner = false,
}) async {
  String? avatarKey = userProfileData?.avatarSrc;

  String? bannerKey = userProfileData?.bannerSrc;

  if (isAvatar) {
    final uploadedAvatar = await ref.read(UserProfileProvider.uploadAvatarProvider(
      UploadAvatarParams(
        fileName: fileName,
        fileType: fileType,
        userId: userDetails['user_id'],
        userType: userDetails['type'],
      ),
    ).future);

    await ref.read(UserProfileProvider.uploadToAWSProvider(
      UploadToAWSParams(
        url: uploadedAvatar.url,
        fileName: fileName,
        file: file,
        fileType: fileType,
      ),
    ).future);

    avatarKey = uploadedAvatar.key;
  }

  if (isBanner) {
    final uploadedBanner = await ref.read(UserProfileProvider.uploadBannerProvider(
      UploadBannerParams(
        fileName: fileName,
        fileType: fileType,
        userId: userDetails['user_id'],
        userType: userDetails['type'],
      ),
    ).future);

    await ref.read(UserProfileProvider.uploadToAWSProvider(
      UploadToAWSParams(
        url: uploadedBanner.url,
        fileName: fileName,
        file: file,
        fileType: fileType,
      ),
    ).future);

    bannerKey = uploadedBanner.key;
  }

  if (isAvatar) {
    return avatarKey ?? "";
  } else if (isBanner) {
    return bannerKey ?? "";
  }

  throw Exception('No valid image type specified');
}

@riverpod
Future<ImageModel> getAvatarUrl(GetAvatarUrlRef ref) async {
  final userDetails = await ref.watch(UserProfileProvider.getUserProfileProvider.future);
  ImageModel avatarUrl = await ref.watch(UserProfileProvider.getImageProvider(userDetails.avatarSrc!).future);
  return avatarUrl;
}

@riverpod
Future<ImageModel> getBannerUrl(GetBannerUrlRef ref) async {
  final userDetails = await ref.watch(UserProfileProvider.getUserProfileProvider.future);
  ImageModel bannerUrl = await ref.watch(UserProfileProvider.getImageProvider(userDetails.bannerSrc!).future);
  return bannerUrl;
}
