import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/app_utils/screen_size.dart';
import '../../../../common/others/assets.dart';
import '../../../../data/models/image_model.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../providers/user_profile_provider.dart';
import '../../../state_providers/image_picker_provider.dart';

class ProfileBannerWidget extends ConsumerWidget {
  ProfileBannerWidget({
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
      var bannerUrl = userDetails.bannerSrc != null && userDetails.bannerSrc != '' && !userDetails.avatarSrc!.contains('https')
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
                            fadeInDuration: Duration(milliseconds: 500), // Optional: Adds a fade-in animation
                            fadeOutDuration: Duration(milliseconds: 500), // Optional: Adds a fade-out animation
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
