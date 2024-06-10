import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../presentation/providers/user_profile_provider.dart';
import '../presentation/state_providers/image_picker_provider.dart';

class AppUtility {
  final BuildContext context;

  AppUtility(this.context);

  ThemeData get _theme => Theme.of(context);

  TextTheme get _styles => _theme.textTheme;

  ColorScheme get _scheme => _theme.colorScheme;

  MediaType getMediaType(String filePath) {
    // Determine the file extension
    String fileExtension = filePath.split('.').last.toLowerCase();

    // Map file extensions to content types
    Map<String, String> contentTypeMap = {
      "3gp": "video/3gpp",
      "3gp2": "video/3gpp2",
      "aac": "audio/aac",
      "aiff": "audio/aiff",
      "asf": "video/x-ms-asf",
      "bmp": "image/bmp",
      "doc": "application/msword",
      "docx": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "dot": "application/msword",
      "flv": "video/x-flv",
      "jpeg": "image/jpeg",
      "jpg": "image/jpeg",
      "m4a": "audio/m4a",
      "m4b": "audio/m4b",
      "m4r": "audio/x-m4r",
      "m4v": "video/x-m4v",
      "mp3": "audio/mpeg",
      "mp4": "video/mp4",
      "pdf": "application/pdf",
      "png": "image/png",
      "ppt": "application/vnd.ms-powerpoint",
      "pptx": "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      "rtf": "application/rtf",
      "tif": "image/tiff",
      "tiff": "image/tiff",
      "ts": "video/vnd.dlna.mpeg-tts",
      "txt": "text/plain",
      "wmv": "video/x-ms-wmv",
      "wma": "audio/x-ms-wma",
      "wav": "audio/wav",
      "xls": "application/vnd.ms-excel",
      "xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "zip": "application/x-zip-compressed",
    };

    // Default to 'application/octet-stream' if no mapping is found
    String contentType = contentTypeMap[fileExtension] ?? 'application/octet-stream';

    return MediaType.parse(contentType);
  }

  // Function to upload image and update the provider
  // Function to upload image and update the provider
  Future<void> uploadImage({
    required WidgetRef ref,
    required String userId,
    required String userType,
    required ImagePicker picker,
    required bool isBanner,
  }) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isBanner) {
        final uploadedBannerResponse = await ref.read(uploadBannerProvider(
          fileName: pickedFile.name,
          fileType: getMediaType(pickedFile.path),
          userId: userId,
          userType: userType,
        ).future);
        // Assuming uploadedBannerResponse is of type BannerModel
        await ref.read(uploadToAWSProvider(
          url: uploadedBannerResponse.url,
          fileName: pickedFile.name,
          file: File(pickedFile.path),
          fileType: getMediaType(pickedFile.path),
        ).future);
        ref.read(selectedBannerImageProvider.notifier).state = File(pickedFile.path);
        ref.read(uploadedBannerUrlProvider.notifier).state = uploadedBannerResponse.url;
      } else {
        final uploadedAvatarResponse = await ref.read(uploadAvatarProvider(
          fileName: pickedFile.name,
          fileType: getMediaType(pickedFile.path),
          userId: userId,
          userType: userType,
        ).future);
        // Assuming uploadedAvatarResponse is of type AvatarModel
        await ref.read(uploadToAWSProvider(
          url: uploadedAvatarResponse.url,
          fileName: pickedFile.name,
          file: File(pickedFile.path),
          fileType: getMediaType(pickedFile.path),
        ).future);
        ref.read(selectedProfileImageProvider.notifier).state = File(pickedFile.path);
        ref.read(uploadedAvatarUrlProvider.notifier).state = uploadedAvatarResponse.url;
      }
    }
  }

  void error(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$e",
          style: _styles.bodyLarge!.copyWith(
            color: _scheme.onErrorContainer,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _scheme.errorContainer,
      ),
    );
  }

  void message(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$e",
          style: _styles.bodyLarge!.copyWith(
            color: _scheme.onTertiaryContainer,
          ),
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _scheme.onPrimary,
      ),
    );
  }
}
