import 'dart:developer';
import 'dart:io';

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
import '../../../providers/image_provider.dart';
import '../../../state_providers/image_picker_provider.dart';

class BannerWidget extends ConsumerWidget {
  BannerWidget({
    this.userDetails,
    this.userProfileData,
  });

  final ImagePicker _picker = ImagePicker();

  final Map<String, String>? userDetails;
  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBanner = ref.watch(selectedBannerImageProvider);
    final newBannerUploaded = ref.watch(newBannerUploadedProvider);
    final newBanner = ref.watch(verifyBannerImageProvider);

    return Container(
      width: ScreenSize.width(context),
      height: ScreenSize.height(context) * 0.15,
      color: Colors.pink[100]!,
      child: newBannerUploaded == true || (selectedBanner != null && userProfileData?.bannerSrc != "")
          ? Stack(
              children: [
                SizedBox(
                  width: ScreenSize.width(context),
                  child: newBannerUploaded == true
                      ? Image.file(
                          newBanner!,
                          fit: BoxFit.fitWidth,
                        )
                      : CachedNetworkImage(
                          imageUrl: selectedBanner!,
                          fit: BoxFit.cover,
                          useOldImageOnUrlChange: true,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          fadeInDuration: Duration(milliseconds: 500),
                          fadeOutDuration: Duration(milliseconds: 500),
                          cacheKey: selectedBanner,
                          errorWidget: (context, url, error) => const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.error),
                              Icon(Icons.error),
                            ],
                          ),
                        ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    enableFeedback: true,
                    onPressed: () async {
                      try {
                        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          final croppedFile = await ImageCropper().cropImage(
                            sourcePath: pickedFile.path,
                            uiSettings: [
                              AndroidUiSettings(
                                toolbarColor: Theme.of(context).colorScheme.secondary,
                                toolbarWidgetColor: Colors.white,
                                aspectRatioPresets: [
                                  CropAspectRatioPreset.original,
                                  CropAspectRatioPresetCustom(),
                                  // CropAspectRatioPreset.ratio16x9,
                                  // CropAspectRatioPreset.ratio3x2,
                                  // CropAspectRatioPreset.ratio4x3,
                                  // CropAspectRatioPreset.ratio5x3,
                                  // CropAspectRatioPreset.ratio5x4,
                                  // CropAspectRatioPreset.ratio7x5,
                                  // CropAspectRatioPreset.square,
                                ],
                              ),
                              IOSUiSettings(
                                aspectRatioPresets: [
                                  CropAspectRatioPreset.original,
                                  CropAspectRatioPresetCustom(),
                                  // CropAspectRatioPreset.ratio16x9,
                                  // CropAspectRatioPreset.ratio3x2,
                                  // CropAspectRatioPreset.ratio4x3,
                                  // CropAspectRatioPreset.ratio5x3,
                                  // CropAspectRatioPreset.ratio5x4,
                                  // CropAspectRatioPreset.ratio7x5,
                                  // CropAspectRatioPreset.square,
                                ],
                              ),
                            ],
                            compressQuality: 80,
                          );

                          if (croppedFile != null) {
                            final bannerKey = await ref.read(
                              uploadImageProvider(
                                fileName: pickedFile.name,
                                fileType: lookupMimeType(croppedFile.path),
                                userDetails: userDetails!,
                                userProfileData: userProfileData,
                                file: File(croppedFile.path),
                                isBanner: true,
                                isAvatar: false,
                              ).future,
                            );
                            ref.read(uploadedBannerKeyProvider.notifier).state = bannerKey;
                            ref.read(newBannerUploadedProvider.notifier).state = true;
                            ref.read(verifyBannerImageProvider.notifier).state = File(croppedFile.path);
                            log("PROFILE_SCREEN BANNERURL =====> $bannerKey");
                          }
                        }
                      } catch (e) {
                        log("Banner Not Uploaded", error: e);
                        AppUtility(context).error("Failed to upload Banner");
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.camera_fill,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                Image.asset(
                  Assets.BANNER,
                  fit: BoxFit.cover,
                  width: ScreenSize.width(context),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    enableFeedback: true,
                    onPressed: () async {
                      try {
                        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          final croppedFile = await ImageCropper().cropImage(
                            sourcePath: pickedFile.path,
                            aspectRatio: const CropAspectRatio(ratioX: 46, ratioY: 15),
                            uiSettings: [
                              AndroidUiSettings(
                                toolbarColor: Theme.of(context).colorScheme.secondary,
                                toolbarWidgetColor: Colors.white,
                                // aspectRatioPresets: [
                                //   CropAspectRatioPreset.original,
                                //   CropAspectRatioPresetCustom(),
                                //   // CropAspectRatioPreset.ratio16x9,
                                //   // CropAspectRatioPreset.ratio3x2,
                                //   // CropAspectRatioPreset.ratio4x3,
                                //   // CropAspectRatioPreset.ratio5x3,
                                //   // CropAspectRatioPreset.ratio5x4,
                                //   // CropAspectRatioPreset.ratio7x5,
                                //   // CropAspectRatioPreset.square,
                                // ],
                              ),
                              IOSUiSettings(
                                aspectRatioPresets: [
                                  CropAspectRatioPreset.original,
                                  CropAspectRatioPresetCustom(),
                                  // CropAspectRatioPreset.ratio16x9,
                                  // CropAspectRatioPreset.ratio3x2,
                                  // CropAspectRatioPreset.ratio4x3,
                                  // CropAspectRatioPreset.ratio5x3,
                                  // CropAspectRatioPreset.ratio5x4,
                                  // CropAspectRatioPreset.ratio7x5,
                                  // CropAspectRatioPreset.square,
                                ],
                              ),
                            ],
                            compressQuality: 80,
                          );

                          if (croppedFile != null) {
                            final bannerKey = await ref.read(
                              uploadImageProvider(
                                fileName: pickedFile.name,
                                fileType: lookupMimeType(croppedFile.path),
                                userDetails: userDetails!,
                                userProfileData: userProfileData,
                                file: File(croppedFile.path),
                                isBanner: true,
                                isAvatar: false,
                              ).future,
                            );
                            ref.read(uploadedBannerKeyProvider.notifier).state = bannerKey;
                            ref.read(newBannerUploadedProvider.notifier).state = true;
                            ref.read(verifyBannerImageProvider.notifier).state = File(croppedFile.path);
                            log("PROFILE_SCREEN BANNERURL =====> $bannerKey");
                          }
                        }
                      } catch (e) {
                        log("Banner Not Uploaded", error: e);
                        AppUtility(context).error("Failed to upload Banner");
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.camera_fill,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (46, 15);

  @override
  String get name => '46x15';
}
