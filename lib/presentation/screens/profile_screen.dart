import 'dart:developer';
import 'dart:io';

import 'package:briefsea/data/core/api_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../common/app_utility.dart';
import '../../common/assets.dart';
import '../../common/screen_size.dart';
import '../../data/models/image_model.dart';
import '../../data/models/user_profile_model.dart';
import '../../main.dart';
import '../providers/auth_provider.dart';
import '../providers/image_provider.dart';
import '../providers/user_profile_provider.dart';
import '../state_providers/bottom_nav_bar_state_provider.dart';
import '../state_providers/image_picker_provider.dart';
import 'auth_screens/welcome_screen.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({
    super.key,
    this.isOtherProfile = false,
    this.otherUserId,
  });

  static const routeName = "/profileScreen";
  bool isOtherProfile;
  String? otherUserId;

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = isOtherProfile == true ? ref.watch(getOtherProfileProvider(otherUserId: otherUserId)) : ref.watch(getUserProfileProvider);
    final userData = ref.watch(userDetailsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isOtherProfile == true
          ? AppBar(
              backgroundColor: const Color(0xFF4B26FD),
              title: const Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      body: SafeArea(
        child: Stack(
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
                                        isOtherProfile: isOtherProfile,
                                      ),
                                      _AvatarWidget(
                                        userDetails: userData,
                                        userProfileData: userDetails,
                                        isOtherProfile: isOtherProfile,
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
                                          userDetails.postingAs?.isNotEmpty == true
                                              ? "Using Briefsea as:${userDetails.postingAs?[0].toUpperCase()}${userDetails.postingAs?.substring(1)}"
                                              : "Using Briefsea as:",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          textScaler: const TextScaler.linear(1),
                                        ),
                                        Text(
                                          userDetails.industry?.isNotEmpty == true ? "Industry: ${userDetails.industry?.join(', ')}" : "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          textScaler: const TextScaler.linear(1),
                                        ),
                                        // Text(
                                        //   userDetails.expertise?.isNotEmpty == true ? "Expertise: ${userDetails.expertise?[0]}" : "",
                                        //   style: const TextStyle(
                                        //     fontWeight: FontWeight.bold,
                                        //     color: Colors.black,
                                        //   ),
                                        //   textScaler: const TextScaler.linear(1),
                                        // ),
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
                                  isOtherProfile != true
                                      ? Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: GestureDetector(
                                            onTap: () async {
                                              await handleLogout(context, prefs, ref, false);
                                            },
                                            child: const Text("Logout"),
                                          ),
                                        )
                                      : const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _socialMedia(
                                  context,
                                  INSTA_LOGO,
                                  () async {
                                    if (await launchUrlString(
                                      ApiConstants.instaUrl,
                                      mode: LaunchMode.externalApplication,
                                    )) {
                                      await launchUrlString(
                                        ApiConstants.instaUrl,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    } else {
                                      throw 'There was a problem to open the url: ${ApiConstants.instaUrl}';
                                    }
                                  },
                                ),
                                const SizedBox(width: 15),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: _socialMedia(
                                    context,
                                    PROFILE_LINKEDIN,
                                    () async {
                                      if (await launchUrlString(
                                        ApiConstants.linkedInUrl,
                                        mode: LaunchMode.externalApplication,
                                      )) {
                                        await launchUrlString(
                                          ApiConstants.linkedInUrl,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      } else {
                                        throw 'There was a problem to open the url: ${ApiConstants.linkedInUrl}';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Copyright © 2024 Briefsea. All rights reserved",
                              style: TextStyle(fontSize: 12),
                            ),
                            if (isOtherProfile != true)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () async {
                                    final deleteResponse = await showAdaptiveDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog.adaptive(
                                          content: const Text(
                                              'This action cannot be undone and you will lose all your data associated with this account.'),
                                          title: const Text('Are you sure you want to delete your account?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                context.pop(false);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                var isAccountDeleted = await ref.read(deleteAccountProvider(userId: userDetails.userId!).future);
                                                if (isAccountDeleted == true) {
                                                  context.pop(true);
                                                }
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    print(deleteResponse);
                                    if (deleteResponse == true) {
                                      await handleLogout(context, prefs, ref, true);
                                    }
                                  },
                                  child: const Text(
                                    "Delete Account",
                                    style: TextStyle(fontSize: 10),
                                  ),
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
        ),
      ),
    );
  }

  Widget _socialMedia(context, imagePath, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 25,
        width: 25,
        // decoration: BoxDecoration(
        //   color: Colors.grey[200],
        //   borderRadius: BorderRadius.circular(5),
        // ),
        child: SvgPicture.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Future<void> handleLogout(BuildContext context, SharedPreferences? prefs, WidgetRef ref, bool isDelete) async {
    try {
      // Ensure prefs is initialized
      if (prefs != null) {
        // Set isLogin to false
        await prefs.setBool('isLogin', false);
        // Clear all preferences if needed
        // await prefs.clear();
        // Navigate to WelcomeScreen
        context.go(WelcomeScreen.routeName);
        // Show logout successful message
        AppUtility(context).message(!isDelete ? 'Logout Successful' : 'Account Deleted');
        // Reset the current index provider
        ref.read(currentIndexProvider.notifier).state = 0;
      } else {
        // Handle the case where prefs is null
        AppUtility(context).message('Error: Shared preferences not initialized');
      }
    } catch (e) {
      // Handle any errors
      AppUtility(context).message('Error during logout: $e');
    }
  }
}

class _BannerWidget extends ConsumerWidget {
  _BannerWidget({
    this.userDetails,
    this.userProfileData,
    this.isOtherProfile = false,
  });

  final ImagePicker _picker = ImagePicker();
  final bool isOtherProfile;

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
      child: selectedBanner != null && userProfileData?.bannerSrc != ""
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
                        child: CircularProgressIndicator.adaptive(),
                      ),
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
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: isOtherProfile != true
                      ? IconButton(
                          onPressed: () async {
                            try {
                              final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                              final imageUrl = await ref.read(
                                uploadImageProvider(
                                  fileName: pickedFile!.name,
                                  fileType: lookupMimeType(pickedFile.path),
                                  userDetails: userDetails!,
                                  userProfileData: userProfileData,
                                  file: File(pickedFile.path),
                                  isBanner: true,
                                  isAvatar: false,
                                ).future,
                              );
                              ref.read(selectedBannerImageProvider.notifier).state = imageUrl;
                              log("PROFILE_SCREEN BANNERURL =====> $imageUrl");
                            } catch (e) {
                              log("Banner Not Uploaded", error: e);
                            }
                          },
                          icon: const Icon(
                            CupertinoIcons.camera_fill,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            )
          : Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: Image.asset(
                    BANNER,
                    fit: BoxFit.cover,
                    width: ScreenSize.width(context),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: isOtherProfile != true
                      ? IconButton(
                          onPressed: () async {
                            try {
                              final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                              final imageUrl = await ref.read(
                                uploadImageProvider(
                                  fileName: pickedFile!.name,
                                  fileType: lookupMimeType(pickedFile.path),
                                  userDetails: userDetails!,
                                  userProfileData: userProfileData,
                                  file: File(pickedFile.path),
                                  isBanner: true,
                                  isAvatar: false,
                                ).future,
                              );
                              ref.read(selectedBannerImageProvider.notifier).state = imageUrl;
                              log("PROFILE_SCREEN BANNERURL =====> $imageUrl");
                            } catch (e) {
                              log("Banner Not Uploaded", error: e);
                            }
                          },
                          icon: const Icon(
                            CupertinoIcons.camera_fill,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
    );
  }
}

class _AvatarWidget extends ConsumerWidget {
  _AvatarWidget({
    this.userDetails,
    this.userProfileData,
    this.isOtherProfile = false,
  });

  final ImagePicker _picker = ImagePicker();
  final bool isOtherProfile;

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
          onTap: isOtherProfile != true
              ? () async {
                  try {
                    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                    final imageUrl = await ref.read(
                      uploadImageProvider(
                        fileName: pickedFile!.name,
                        fileType: lookupMimeType(pickedFile.path),
                        userDetails: userDetails!,
                        userProfileData: userProfileData,
                        file: File(pickedFile.path),
                        isBanner: false,
                        isAvatar: true,
                      ).future,
                    );
                    ref.read(selectedAvatarImageProvider.notifier).state = imageUrl;
                    log("PROFILE_SCREEN AVATARURL=====> $imageUrl");
                  } catch (e) {
                    log("Avatar Not Uploaded", error: e);
                  }
                }
              : null,
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: userProfileData?.gender == "Male" ? Colors.transparent : const Color(0xFF1B0C6B),
                radius: 70,
                backgroundImage: selectedAvatar != "" && selectedAvatar != null && userProfileData?.avatarSrc != ""
                    ? CachedNetworkImageProvider(selectedAvatar)
                    : userProfileData?.gender == "Male"
                        ? const AssetImage(MALE)
                        : userProfileData?.gender == "Female"
                            ? const AssetImage(FEMALE)
                            : userProfileData?.gender == "Others"
                                ? const AssetImage(OTHERS)
                                : null,
                child: selectedAvatar == null && userProfileData?.gender == null
                    ? Text(
                        userProfileData?.name?[0].toUpperCase() ?? "",
                        style: const TextStyle(color: Colors.white),
                        textScaler: const TextScaler.linear(3),
                      )
                    : const SizedBox.shrink(),
              ),
              isOtherProfile != true
                  ? Positioned(
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
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
