import 'dart:developer';
import 'dart:io';

import 'package:briefsea/presentation/providers/image_provider.dart';
import 'package:briefsea/presentation/providers/user_profile_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/app_utility.dart';
import '../../common/screen_size.dart';
import '../../data/models/image_model.dart';
import '../../data/models/user_profile_model.dart';
import '../providers/auth_provider.dart';
import '../state_providers/image_picker_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: bodyWidget(context, ref),
    );
  }

  Future<void> _initializeImageProviders(WidgetRef ref, UserProfileModel userDetails) async {
    ImageModel avatarUrl = userDetails.avatarSrc != null && userDetails.avatarSrc! != ""
        ? await ref.watch(getImageProvider(src: userDetails.avatarSrc!).future)
        : ImageModel();
    ImageModel bannerUrl = userDetails.bannerSrc != null && userDetails.bannerSrc != ""
        ? await ref.watch(getImageProvider(src: userDetails.bannerSrc!).future)
        : ImageModel();

    if (avatarUrl.url != null && avatarUrl.url != "") {
      ref.read(selectedAvatarImageProvider.notifier).state = avatarUrl.url;
    }
    if (bannerUrl.url != null && bannerUrl.url != "") {
      ref.read(selectedBannerImageProvider.notifier).state = bannerUrl.url;
    }
  }

  bodyWidget(context, WidgetRef ref) {
    final userDetails = ref.watch(getUserProfileProvider);
    final userData = ref.watch(userDetailsProvider);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 70,
          color: const Color(0xFF4B26FD),
        ),
        Container(
          height: ScreenSize.height(context),
          width: ScreenSize.width(context),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.white,
          ),
          child: userDetails.when(
            data: (userDetails) {
              return FutureBuilder(
                future: _initializeImageProviders(ref, userDetails),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Column(
                      children: [
                        Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  _BannerWidget(
                                    userDetails: userData,
                                    userProfileData: userDetails,
                                  ),
                                  _AvatarWidget(
                                    userDetails: userData,
                                    userProfileData: userDetails,
                                  ),
                                ],
                              ),
                              Container(
                                width: ScreenSize.width(context),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        userDetails.name?.isNotEmpty == true
                                            ? userDetails.name![0].toUpperCase() + userDetails.name!.substring(1)
                                            : '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textScaler:
                                            const TextScaler.linear(1.7), // Note: textScaler is not a valid property, replaced with textScaleFactor
                                      ),
                                      Text(
                                        userData['type']?.isNotEmpty == true
                                            ? "Posting as a ${userData['type']![0].toUpperCase()}${userData['type']!.substring(1)}"
                                            : "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textScaler: const TextScaler.linear(1),
                                      ),
                                      Text(
                                        userDetails.industry?[0] ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textScaler: const TextScaler.linear(1),
                                      ),
                                      Text(
                                        userDetails.expertise?[0] ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textScaler: const TextScaler.linear(1),
                                      ),
                                      Text(
                                        userDetails.post ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textScaler: const TextScaler.linear(1),
                                      ),
                                      Text(
                                        userDetails.worksAt ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textScaler: const TextScaler.linear(1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            },
            error: (error, stackTrace) {
              return Center(child: Text('Error: $error'));
            },
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ],
    );
  }
}

class _BannerWidget extends ConsumerWidget {
  _BannerWidget({this.userDetails, this.userProfileData});

  final ImagePicker _picker = ImagePicker();

  Map<String, String>? userDetails;
  UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBanner = ref.watch(selectedBannerImageProvider);
    return Container(
      width: ScreenSize.width(context),
      height: ScreenSize.height(context) * 0.15,
      decoration: BoxDecoration(
        color: Colors.pink[100]!,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: selectedBanner != null
          ? Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: SizedBox(
                    width: ScreenSize.width(context),
                    child: CachedNetworkImage(
                      imageUrl: selectedBanner,
                      fit: BoxFit.cover,
                      useOldImageOnUrlChange: true,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () async {
                      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                      final imageUrl = await ref.read(
                        uploadImageProvider(
                          fileName: pickedFile!.name,
                          fileType: AppUtility(context).getMediaType(pickedFile.path),
                          userDetails: userDetails!,
                          userProfileData: userProfileData,
                          file: File(pickedFile.path),
                          isBanner: true,
                          isAvatar: false,
                        ).future,
                      );
                      ref.read(selectedBannerImageProvider.notifier).state = imageUrl;
                      log("PROFILE_SCREEN BANNERURL =====> $imageUrl");
                    },
                    icon: const Icon(
                      CupertinoIcons.camera_fill,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          : Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () async {
                  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                  final imageUrl = await ref.read(
                    uploadImageProvider(
                      fileName: pickedFile!.name,
                      fileType: AppUtility(context).getMediaType(pickedFile.path),
                      userDetails: userDetails!,
                      userProfileData: userProfileData,
                      file: File(pickedFile.path),
                      isBanner: true,
                      isAvatar: false,
                    ).future,
                  );
                  ref.read(selectedBannerImageProvider.notifier).state = imageUrl;
                  log("PROFILE_SCREEN BANNERURL =====> $imageUrl");
                },
                icon: const Icon(
                  CupertinoIcons.camera_fill,
                  color: Colors.black,
                ),
              ),
            ),
    );
  }
}

class _AvatarWidget extends ConsumerWidget {
  _AvatarWidget({this.userDetails, this.userProfileData});

  final ImagePicker _picker = ImagePicker();

  Map<String, String>? userDetails;
  UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAvatar = ref.watch(selectedAvatarImageProvider);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () async {
            final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
            final imageUrl = await ref.read(
              uploadImageProvider(
                fileName: pickedFile!.name,
                fileType: AppUtility(context).getMediaType(pickedFile.path),
                userDetails: userDetails!,
                userProfileData: userProfileData,
                file: File(pickedFile.path),
                isBanner: false,
                isAvatar: true,
              ).future,
            );
            ref.read(selectedAvatarImageProvider.notifier).state = imageUrl;
            log("PROFILE_SCREEN AVATARURL=====> $imageUrl");
          },
          child: CircleAvatar(
              backgroundColor: const Color(0xFF1B0C6B),
              radius: 70,
              backgroundImage: selectedAvatar != "" && selectedAvatar != null ? CachedNetworkImageProvider(selectedAvatar) : null,
              child: selectedAvatar == "" && selectedAvatar == null
                  // ? ClipRRect(
                  //     borderRadius: BorderRadius.circular(70),
                  //     child: CachedNetworkImage(
                  //       imageUrl: selectedAvatar,
                  //       placeholder: (context, url) => const CircularProgressIndicator(),
                  //       errorWidget: (context, url, error) => const Icon(
                  //         Icons.error,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   )
                  // :
                  ? const Icon(
                      CupertinoIcons.camera_fill,
                      color: Colors.white,
                    )
                  : const SizedBox.shrink()),
        ),
      ),
    );
  }
}
