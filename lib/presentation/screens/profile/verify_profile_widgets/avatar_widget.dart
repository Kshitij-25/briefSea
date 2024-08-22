import 'dart:developer';
import 'dart:io';
import 'dart:math' hide log;

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
import '../../../../main.dart';
import '../../../params/user_profile_params.dart';
import '../../../providers/user_profile_provider.dart';
import '../../../state_providers/image_picker_provider.dart';

class AvatarWidget extends ConsumerWidget {
  const AvatarWidget({
    required this.userDetails,
    required ImagePicker picker,
    required this.verifyAvatar,
    this.gender,
  }) : _picker = picker;

  final ImagePicker _picker;
  final File? verifyAvatar;
  final Map<String, String> userDetails;
  final String? gender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var googleAvatar;
    if (verifyAvatar == null) {
      final avatarUrl = prefs!.getString('avatarUrl') ?? '';
      googleAvatar = avatarUrl;
    }
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () async {
            try {
              final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                final croppedFile = await ImageCropper().cropImage(
                  sourcePath: pickedFile.path,
                  uiSettings: [
                    AndroidUiSettings(
                      toolbarTitle: 'Cropper',
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
                      title: 'Cropper',
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
                  var uploadedAvatar = await ref.read(UserProfileProvider.uploadAvatarProvider(
                    UploadAvatarParams(
                      fileName: pickedFile.name,
                      fileType: lookupMimeType(croppedFile.path),
                      userId: userDetails['user_id'],
                      userType: userDetails['type'],
                    ),
                  ).future);
                  await ref.read(UserProfileProvider.uploadToAWSProvider(
                    UploadToAWSParams(
                      url: uploadedAvatar.url,
                      fileName: pickedFile.name,
                      file: File(croppedFile.path),
                      fileType: lookupMimeType(croppedFile.path),
                    ),
                  ).future);
                  ref.read(uploadedAvatarKeyProvider.notifier).state = uploadedAvatar.key;

                  ref.read(verifyAvatarImageProvider.notifier).state = File(croppedFile.path);
                }
              }
            } catch (e) {
              log("Avatar Not Uploaded", error: e);
              AppUtility(context).error("Failed to upload Avatar");
            }
          },
          child: Stack(
            children: [
              Container(
                height: 140 * ScaleSize.textScaleFactor(context),
                width: 140 * ScaleSize.textScaleFactor(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: const Color(0xFF1B0C6B),
                  image: DecorationImage(
                    fit: gender == null ? BoxFit.scaleDown : BoxFit.cover,
                    image: verifyAvatar != null
                        ? FileImage(verifyAvatar!)
                        : googleAvatar != null
                            ? CachedNetworkImageProvider(googleAvatar)
                            : _getImageByGender(gender),
                    colorFilter: (gender == null && googleAvatar == null && verifyAvatar == null)
                        ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                        : null,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 35,
                  height: 35,
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
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider _getImageByGender(String? gender) {
    Random random = Random();
    if (gender == null) {
      return const AssetImage(Assets.PERSON);
    } else if (gender == "Male") {
      return AssetImage(_getRandomAsset(Assets.MALE_ASSETS, random));
    } else if (gender == "Female") {
      return AssetImage(_getRandomAsset(Assets.FEMALE_ASSETS, random));
    } else {
      return const AssetImage(Assets.OTHERS);
    }
  }

  String _getRandomAsset(List<String> assets, Random random) {
    int index = random.nextInt(assets.length);
    return assets[index];
  }
}
