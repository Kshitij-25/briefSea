import 'dart:developer';
import 'dart:math' as math;

import 'package:briefsea/common/app_utils/app_utility.dart';
import 'package:briefsea/common/app_utils/screen_size.dart';
import 'package:briefsea/common/others/assets.dart';
import 'package:briefsea/common/others/strings.dart';
import 'package:briefsea/data/core/api_constants.dart';
import 'package:briefsea/data/models/user_profile_model.dart';
import 'package:briefsea/main.dart';
import 'package:briefsea/presentation/providers/auth_provider.dart';
import 'package:briefsea/presentation/providers/user_profile_provider.dart';
import 'package:briefsea/presentation/state_providers/image_picker_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../data/core/app_error.dart';
import '../../../data/models/image_model.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    super.key,
    this.isOtherProfile = false,
    this.otherUserId,
  });

  static const routeName = '/profileScreen';
  final bool isOtherProfile;
  final String? otherUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = isOtherProfile == true
        ? ref.watch(UserProfileProvider.getOtherProfileProvider(otherUserId))
        : ref.watch(UserProfileProvider.getUserProfileProvider);
    final userData = ref.watch(userDetailsProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: isOtherProfile == true
          ? AppBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              title: Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
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
              height: 370,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SingleChildScrollView(
              child: Container(
                height: ScreenSize.height(context),
                width: ScreenSize.width(context),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child: userDetails.when(
                  data: (userDetails) {
                    return Column(
                      children: [
                        Column(
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
                            _UserInfoDetails(
                              userProfileData: userDetails,
                            ),
                          ],
                        ),
                        if (userDetails.aboutMe?.isNotEmpty == true) _AboutCard(userProfileData: userDetails),
                        if (userDetails.postingAs != 'freelancer') _CompanyCard(userDetails),
                        _ExpertiseCard(userProfileData: userDetails),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialMedia(
                              context,
                              Assets.INSTA_LOGO,
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
                              padding: const EdgeInsets.only(bottom: 5),
                              child: _socialMedia(
                                context,
                                Assets.PROFILE_LINKEDIN,
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
                        Text(
                          Strings.copyrightText,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
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
                                        Strings.deleteContent,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      title: const Text(
                                        Strings.deleteWarning,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            enableFeedback: true,
                                          ),
                                          onPressed: () {
                                            context.pop(false);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            enableFeedback: true,
                                          ),
                                          onPressed: () async {
                                            final isAccountDeleted =
                                                await ref.read(UserProfileProvider.deleteAccountProvider(userDetails.userId!).future);
                                            if (isAccountDeleted == true) {
                                              context.pop(true);
                                            }
                                          },
                                          child: Text(
                                            'Delete',
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  color: Colors.black,
                                                ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                log(deleteResponse.toString());
                                if (deleteResponse == true) {
                                  await AppUtility(context).handleLogout(context, prefs, ref, true);
                                }
                              },
                              child: Text(
                                'Delete Account',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    if (error is AppError) {
                      return Center(
                        child: Text(
                          error.errorMessage.toString(),
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                        ),
                      );
                    }
                    return Center(
                      child: Text('ERROR : ${error.toString()}'),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialMedia(context, String imagePath, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 25 * ScaleSize.textScaleFactor(context),
        width: 25 * ScaleSize.textScaleFactor(context),
        child: SvgPicture.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class _ExpertiseCard extends StatelessWidget {
  const _ExpertiseCard({this.userProfileData});

  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Industries & Expertise',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: userProfileData?.industry?.length,
            itemBuilder: (context, index) {
              final industry = userProfileData!.industry![index];
              final expertiseList = industry == 'Development & Product' ? userProfileData!.devExpertise ?? [] : userProfileData!.markExpertise ?? [];

              return ExpansionTile(
                shape: RoundedRectangleBorder(side: BorderSide.none),
                title: Text(
                  industry,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
                enableFeedback: true,
                children: [
                  Wrap(
                    spacing: 5,
                    alignment: WrapAlignment.start,
                    children: expertiseList
                        .map(
                          (expertise) => Chip(
                            visualDensity: VisualDensity.compact,
                            label: Text(
                              expertise,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          ),
                        )
                        .toList(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CompanyCard extends StatelessWidget {
  const _CompanyCard(this.userProfileData);

  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context) {
    final random = math.Random(userProfileData?.worksAt.hashCode);
    final userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Company',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: userColor,
                radius: 25 * ScaleSize.textScaleFactor(context),
                child: Text(
                  userProfileData!.worksAt![0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProfileData?.post ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  ),
                  Text(
                    userProfileData?.worksAt ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({this.userProfileData});

  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'About',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          ),
          Text(
            // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            userProfileData?.aboutMe ?? '',
            maxLines: 1000,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          ),
        ],
      ),
    );
  }
}

class _UserInfoDetails extends StatelessWidget {
  const _UserInfoDetails({
    this.userProfileData,
  });

  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width(context),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userProfileData?.name?.isNotEmpty == true ? userProfileData!.name![0].toUpperCase() + userProfileData!.name!.substring(1) : '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
            ),
            Row(
              children: [
                Text(
                  'Using Briefsea as:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  userProfileData?.postingAs?.isNotEmpty == true
                      ? "${userProfileData?.postingAs?[0].toUpperCase()}${userProfileData?.postingAs?.substring(1)}"
                      : '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     const Text(
            //       'Industry:',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 13,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     Text(
            //       userProfileData?.industry?.isNotEmpty == true ? "${userProfileData?.industry?.join(', ')}" : '',
            //       style: const TextStyle(
            //         color: Colors.black,
            //         fontSize: 13,
            //       ),
            //     ),
            //   ],
            // ),
            Text(
              userProfileData?.location?.isNotEmpty == true
                  ? "${userProfileData?.location?[0].toUpperCase()}${userProfileData?.location?.substring(1)}"
                  : '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
            ),
          ],
        ),
      ),
    );
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

  final Map<String, String>? userDetails;
  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> _initializeImageProviders(WidgetRef ref, UserProfileModel userDetails) async {
      var bannerUrl = userDetails.bannerSrc != null && userDetails.bannerSrc != ''
          ? await ref.watch(UserProfileProvider.getImageProvider(userDetails.bannerSrc!).future)
          : ImageModel();

      if (bannerUrl.url != null && bannerUrl.url != '') {
        ref.read(selectedBannerImageProvider.notifier).state = bannerUrl.url;
      }
    }

    final selectedBanner = ref.watch(selectedBannerImageProvider);

    return FutureBuilder(
        future: _initializeImageProviders(ref, userProfileData!),
        builder: (context, snapshot) {
          return Container(
            width: ScreenSize.width(context),
            height: ScreenSize.height(context) * 0.15,
            decoration: BoxDecoration(
              color: Colors.pink[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: selectedBanner != null && userProfileData?.bannerSrc != ''
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
                          Assets.BANNER,
                          fit: BoxFit.cover,
                          width: ScreenSize.width(context),
                        ),
                      ),
                    ],
                  ),
          );
        });
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

    final selectedAvatar = ref.watch(selectedAvatarImageProvider);

    return FutureBuilder(
      future: _initializeImageProviders(ref, userProfileData!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 65 * ScaleSize.textScaleFactor(context), left: 20),
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
                                    radius: 150, // Adjust size for preview
                                    backgroundImage: selectedAvatar != '' && selectedAvatar != null && userProfileData?.avatarSrc != ''
                                        ? CachedNetworkImageProvider(selectedAvatar)
                                        : userProfileData?.gender == 'Male'
                                            ? const AssetImage(Assets.MALE)
                                            : userProfileData?.gender == 'Female'
                                                ? const AssetImage(Assets.FEMALE)
                                                : userProfileData?.gender == 'Others'
                                                    ? const AssetImage(Assets.OTHERS)
                                                    : null,
                                    child: selectedAvatar != null && selectedAvatar.isEmpty && userProfileData?.gender == null
                                        ? Text(
                                            userProfileData?.name?[0].toUpperCase() ?? '',
                                            style: const TextStyle(color: Colors.white, fontSize: 50),
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
                        backgroundImage: selectedAvatar != '' && selectedAvatar != null && userProfileData?.avatarSrc != ''
                            ? CachedNetworkImageProvider(selectedAvatar)
                            : userProfileData?.gender == 'Male'
                                ? const AssetImage(Assets.MALE)
                                : userProfileData?.gender == 'Female'
                                    ? const AssetImage(Assets.FEMALE)
                                    : userProfileData?.gender == 'Others'
                                        ? const AssetImage(Assets.OTHERS)
                                        : null,
                        child: selectedAvatar == null && userProfileData?.gender == null
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
                          ElevatedButton.icon(
                            onPressed: () {
                              GoRouter.of(context).push(
                                EditProfileScreen.routeName,
                                extra: userProfileData,
                              );
                            },
                            icon: Icon(
                              Icons.mode_edit,
                            ),
                            label: Text(
                              'Edit Profile',
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                            ),
                            style: ElevatedButton.styleFrom(
                              enableFeedback: true,
                              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                              foregroundColor: Theme.of(context).colorScheme.secondary,
                              elevation: 0,
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
    return Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
  }
}
