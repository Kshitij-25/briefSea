import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common/app_utils/screen_size.dart';
import '../../../../common/others/assets.dart';
import '../../../../data/models/image_model.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../../main.dart';
import '../../../providers/user_profile_provider.dart';
import '../../../state_providers/image_picker_provider.dart';
import '../edit_profile_screen.dart';
import '../verify_profile_screen.dart';

class ProfileAvatarWidget extends ConsumerWidget {
  ProfileAvatarWidget({
    this.userDetails,
    this.userProfileData,
    this.isOtherProfile = false,
  });

  final bool isOtherProfile;

  final Map<String, String>? userDetails;
  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userColor = _generateUserColor(userProfileData);

    Future<void> _initializeImageProviders(WidgetRef ref, UserProfileModel userDetails) async {
      var avatarUrl = userDetails.avatarSrc != null && userDetails.avatarSrc! != ''
          ? await ref.watch(UserProfileProvider.getImageProvider(userDetails.avatarSrc!).future)
          : ImageModel();

      if (avatarUrl.url != null && avatarUrl.url != '') {
        ref.read(selectedAvatarImageProvider.notifier).state = avatarUrl.url;
      }
    }

    var selectedAvatar = ref.watch(selectedAvatarImageProvider);

    if (selectedAvatar == null) {
      final avatarUrl = prefs!.getString('avatarUrl') ?? '';
      selectedAvatar = avatarUrl;
    }
    final profile = prefs!.getBool('profile');

    return FutureBuilder(
      future: _initializeImageProviders(ref, userProfileData!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 65 * ScaleSize.textScaleFactor(context), left: 15),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(120),
                ),
                child: CircleAvatar(
                  backgroundColor: userColor,
                  radius: 65 * ScaleSize.textScaleFactor(context),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 65 * ScaleSize.textScaleFactor(context), left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: userColor,
                                    radius: 165 * ScaleSize.textScaleFactor(context),
                                    backgroundImage: (selectedAvatar != null && selectedAvatar != '' && userProfileData?.avatarSrc != '') ||
                                            (selectedAvatar != null && selectedAvatar != '')
                                        ? CachedNetworkImageProvider(
                                            selectedAvatar,
                                            cacheKey: selectedAvatar,
                                          )
                                        : userProfileData?.gender == 'Male'
                                            ? const AssetImage(Assets.MALE)
                                            : userProfileData?.gender == 'Female'
                                                ? const AssetImage(Assets.FEMALE)
                                                : userProfileData?.gender == 'Others'
                                                    ? const AssetImage(Assets.OTHERS)
                                                    : null,
                                    child: (selectedAvatar == null || selectedAvatar == '') && userProfileData?.gender == null
                                        ? Text(
                                            userProfileData?.name?[0].toUpperCase() ?? '',
                                            style: TextStyle(color: Colors.white, fontSize: 100 * ScaleSize.textScaleFactor(context)),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(120),
                      ),
                      child: CircleAvatar(
                        backgroundColor: userColor,
                        radius: 65 * ScaleSize.textScaleFactor(context),
                        backgroundImage: (selectedAvatar != null && selectedAvatar != '' && userProfileData?.avatarSrc != '') ||
                                (selectedAvatar != null && selectedAvatar != '')
                            ? CachedNetworkImageProvider(
                                selectedAvatar,
                                cacheKey: selectedAvatar,
                              )
                            : userProfileData?.gender == 'Male'
                                ? const AssetImage(Assets.MALE)
                                : userProfileData?.gender == 'Female'
                                    ? const AssetImage(Assets.FEMALE)
                                    : userProfileData?.gender == 'Others'
                                        ? const AssetImage(Assets.OTHERS)
                                        : null,
                        child: (selectedAvatar == null || selectedAvatar == '') && userProfileData?.gender == null
                            ? Text(
                                userProfileData?.name?[0].toUpperCase() ?? '',
                                style: const TextStyle(color: Colors.white),
                                textScaler: TextScaler.linear(
                                  3 * ScaleSize.textScaleFactor(context),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  if (isOtherProfile != true)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 90 * ScaleSize.textScaleFactor(context),
                          ),
                          !profile!
                              ? TextButton.icon(
                                  onPressed: () {
                                    GoRouter.of(context).push(
                                      VerifyProfileScreen.routeName,
                                    );
                                  },
                                  label: Text('Complete Profile'),
                                  icon: Icon(
                                    Icons.mode_edit,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    GoRouter.of(context).push(
                                      EditProfileScreen.routeName,
                                      extra: userProfileData,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.mode_edit,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Color _generateUserColor(UserProfileModel? userProfileData) {
    final random = math.Random(userProfileData?.userId.hashCode);
    return Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7);
  }
}
