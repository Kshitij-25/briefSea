import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../../common/app_utils/screen_size.dart';
import '../../../../common/others/assets.dart';
import '../../../params/user_profile_params.dart';
import '../../../providers/user_profile_provider.dart';
import '../../../state_providers/image_picker_provider.dart';

class BannerWidget extends ConsumerWidget {
  const BannerWidget({
    required this.userDetails,
    required this.verifyBanner,
    required ImagePicker picker,
  }) : _picker = picker;

  final File? verifyBanner;
  final ImagePicker _picker;
  final Map<String, String> userDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: ScreenSize.width(context),
      height: ScreenSize.height(context) * 0.15,
      color: Colors.white,
      child: verifyBanner != null
          ? Stack(
              children: [
                Image(
                  width: ScreenSize.width(context),
                  image: FileImage(verifyBanner!),
                  fit: BoxFit.fill,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    enableFeedback: true,
                    onPressed: () async {
                      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        var uploadedBanner = await ref.read(UserProfileProvider.uploadBannerProvider(
                          UploadBannerParams(
                            fileName: pickedFile.name,
                            fileType: lookupMimeType(pickedFile.path),
                            userId: userDetails['user_id'],
                            userType: userDetails['type'],
                          ),
                        ).future);
                        ref.read(UserProfileProvider.uploadToAWSProvider(
                          UploadToAWSParams(
                            url: uploadedBanner.url,
                            fileName: pickedFile.name,
                            file: File(pickedFile.path),
                            fileType: lookupMimeType(pickedFile.path),
                          ),
                        ));
                        // Update the avatar URL provider
                        ref.read(uploadedBannerKeyProvider.notifier).state = uploadedBanner.key;

                        ref.read(verifyBannerImageProvider.notifier).state = File(pickedFile.path);
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
                      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        var uploadedBanner = await ref.read(UserProfileProvider.uploadBannerProvider(
                          UploadBannerParams(
                            fileName: pickedFile.name,
                            fileType: lookupMimeType(pickedFile.path),
                            userId: userDetails['user_id'],
                            userType: userDetails['type'],
                          ),
                        ).future);
                        ref.read(UserProfileProvider.uploadToAWSProvider(
                          UploadToAWSParams(
                            url: uploadedBanner.url,
                            fileName: pickedFile.name,
                            file: File(pickedFile.path),
                            fileType: lookupMimeType(pickedFile.path),
                          ),
                        ));
                        ref.read(uploadedBannerKeyProvider.notifier).state = uploadedBanner.key;

                        ref.read(verifyBannerImageProvider.notifier).state = File(pickedFile.path);
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
