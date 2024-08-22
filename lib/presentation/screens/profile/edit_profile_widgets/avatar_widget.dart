import 'dart:developer';
import 'dart:io';
import 'dart:math' as math hide log;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../../common/app_utils/app_utility.dart';
import '../../../../common/app_utils/screen_size.dart';
import '../../../../common/others/assets.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../../main.dart';
import '../../../providers/image_provider.dart';
import '../../../state_providers/image_picker_provider.dart';

class AvatarWidget extends ConsumerWidget {
  AvatarWidget({
    this.userDetails,
    this.userProfileData,
  });

  final ImagePicker _picker = ImagePicker();

  final Map<String, String>? userDetails;
  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedAvatar = ref.watch(selectedAvatarImageProvider);
    final newAvatarUploaded = ref.watch(newAvatarUploadedProvider);
    final newAvatar = ref.watch(verifyAvatarImageProvider);

    math.Random random = math.Random(userProfileData?.userId.hashCode);
    Color userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7);

    if (selectedAvatar == null) {
      final avatarUrl = prefs!.getString('avatarUrl') ?? '';
      selectedAvatar = avatarUrl;
    }

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: userColor,
              radius: 70 * ScaleSize.textScaleFactor(context),
              backgroundImage: (newAvatarUploaded != true && selectedAvatar != "" && userProfileData?.avatarSrc != "") ||
                      (newAvatarUploaded != true && selectedAvatar != "")
                  ? CachedNetworkImageProvider(
                      selectedAvatar,
                      cacheKey: selectedAvatar,
                    )
                  : newAvatarUploaded == true
                      ? FileImage(newAvatar!)
                      : userProfileData?.gender == "Male"
                          ? const AssetImage(Assets.MALE)
                          : userProfileData?.gender == "Female"
                              ? const AssetImage(Assets.FEMALE)
                              : userProfileData?.gender == "Others"
                                  ? const AssetImage(Assets.OTHERS)
                                  : null,
              child: selectedAvatar == null && userProfileData?.gender == null
                  ? Text(
                      userProfileData?.name?[0].toUpperCase() ?? "",
                      style: const TextStyle(color: Colors.white),
                      textScaler: TextScaler.linear(3 * ScaleSize.textScaleFactor(context)),
                    )
                  : const SizedBox.shrink(),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () async {
                  try {
                    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      final croppedFile = await ImageCropper().cropImage(
                        sourcePath: pickedFile.path,
                        uiSettings: [
                          AndroidUiSettings(
                            toolbarColor: Colors.deepOrange,
                            toolbarWidgetColor: Colors.white,
                            aspectRatioPresets: [
                              CropAspectRatioPreset.original,
                              // CropAspectRatioPreset.ratio16x9,
                              // CropAspectRatioPreset.ratio3x2,
                              // CropAspectRatioPreset.ratio4x3,
                              // CropAspectRatioPreset.ratio5x3,
                              // CropAspectRatioPreset.ratio5x4,
                              // CropAspectRatioPreset.ratio7x5,
                              CropAspectRatioPreset.square,
                            ],
                          ),
                          IOSUiSettings(
                            aspectRatioPresets: [
                              CropAspectRatioPreset.original,
                              // CropAspectRatioPreset.ratio16x9,
                              // CropAspectRatioPreset.ratio3x2,
                              // CropAspectRatioPreset.ratio4x3,
                              // CropAspectRatioPreset.ratio5x3,
                              // CropAspectRatioPreset.ratio5x4,
                              // CropAspectRatioPreset.ratio7x5,
                              CropAspectRatioPreset.square,
                            ],
                          ),
                        ],
                        compressQuality: 80,
                      );

                      if (croppedFile != null) {
                        final avatarKey = await ref.read(
                          uploadImageProvider(
                            fileName: pickedFile.name,
                            fileType: lookupMimeType(croppedFile.path),
                            userDetails: userDetails!,
                            userProfileData: userProfileData,
                            file: File(croppedFile.path),
                            isBanner: false,
                            isAvatar: true,
                          ).future,
                        );
                        ref.read(uploadedAvatarKeyProvider.notifier).state = avatarKey;
                        ref.read(newAvatarUploadedProvider.notifier).state = true;
                        ref.read(verifyAvatarImageProvider.notifier).state = File(croppedFile.path);
                        log("PROFILE_SCREEN AVATARURL=====> $avatarKey");
                      }
                    }
                  } catch (e) {
                    log("Avatar Not Uploaded", error: e);
                    AppUtility(context).error("Failed to upload Avatar");
                  }
                },
                child: Container(
                  width: 35 * ScaleSize.textScaleFactor(context),
                  height: 35 * ScaleSize.textScaleFactor(context),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.camera_fill,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
