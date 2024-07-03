import 'dart:developer';
import 'dart:io';

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
  String? avatarUrl;
  String? avatarKey = userProfileData?.avatarSrc;
  String? bannerUrl;
  String? bannerKey = userProfileData?.bannerSrc;

  if (isAvatar) {
    final uploadedAvatar = await ref.read(uploadAvatarProvider(
      fileName: fileName,
      fileType: fileType,
      userId: userDetails['user_id'],
      userType: userDetails['type'],
    ).future);

    await ref.read(uploadToAWSProvider(
      url: uploadedAvatar.url,
      fileName: fileName,
      file: file,
      fileType: fileType,
    ).future);

    avatarUrl = uploadedAvatar.url;
    avatarKey = uploadedAvatar.key;
  }

  if (isBanner) {
    final uploadedBanner = await ref.read(uploadBannerProvider(
      fileName: fileName,
      fileType: fileType,
      userId: userDetails['user_id'],
      userType: userDetails['type'],
    ).future);

    await ref.read(uploadToAWSProvider(
      url: uploadedBanner.url,
      fileName: fileName,
      file: file,
      fileType: fileType,
    ).future);

    bannerUrl = uploadedBanner.url;
    bannerKey = uploadedBanner.key;
  }

  var verifyMessage = await ref.read(
    editProfileProvider(
      userId: userDetails['user_id'],
      uName: userDetails['user_name']!,
      countryCode: userProfileData!.countryCode,
      contact: userProfileData.contact,
      company: userProfileData.worksAt,
      jobTitle: userProfileData.post,
      industry: userProfileData.industry!,
      location: userProfileData.location,
      avatarSrc: avatarKey ?? '',
      bannerSrc: bannerKey ?? '',
      jwtToken: userDetails['jwtToken'],
      expertise: userProfileData.expertise!,
      postingAs: userDetails['type'],
      gender: userProfileData.gender,
      createdAt: userProfileData.createdAt,
      updatedAt: userProfileData.updatedAt,
      userName: userProfileData.userName,
      viewAccess: userProfileData.viewAccess,
    ).future,
  );
  log("IMAGE_PROVIDER ===> $verifyMessage");

  ref.invalidate(getUserProfileProvider);

  final updatedUserProfile = await ref.watch(getUserProfileProvider.future);

  if (isAvatar) {
    ImageModel avatarModel = await ref.watch(getImageProvider(src: updatedUserProfile.avatarSrc!).future);
    return avatarModel.url ?? "";
  } else if (isBanner) {
    ImageModel bannerModel = await ref.watch(getImageProvider(src: updatedUserProfile.bannerSrc!).future);
    return bannerModel.url ?? "";
  }

  throw Exception('No valid image type specified');
}

@riverpod
Future<ImageModel> getAvatarUrl(GetAvatarUrlRef ref) async {
  final userDetails = await ref.watch(getUserProfileProvider.future);
  ImageModel avatarUrl = await ref.watch(getImageProvider(src: userDetails.avatarSrc!).future);
  return avatarUrl;
}

@riverpod
Future<ImageModel> getBannerUrl(GetBannerUrlRef ref) async {
  final userDetails = await ref.watch(getUserProfileProvider.future);
  ImageModel bannerUrl = await ref.watch(getImageProvider(src: userDetails.bannerSrc!).future);
  return bannerUrl;
}
