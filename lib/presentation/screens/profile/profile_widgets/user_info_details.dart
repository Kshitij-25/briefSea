import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/app_utils/app_utility.dart';
import '../../../../common/app_utils/screen_size.dart';
import '../../../../common/others/assets.dart';
import '../../../../data/models/user_profile_model.dart';

class UserInfoDetails extends StatelessWidget {
  const UserInfoDetails({
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                const SizedBox(
                  width: 15,
                ),
                // if (userProfileData?.linkedinLink != null && userProfileData?.linkedinLink != '')
                //   GestureDetector(
                //     onTap: () async {
                //       String? linkedInUrl = userProfileData?.linkedinLink?.trim() ?? '';
                //       if (await canLaunchUrl(Uri.parse(linkedInUrl))) {
                //         await launchUrl(Uri.parse(linkedInUrl));
                //       } else {
                //         print('Could not launch ${linkedInUrl}');
                //         AppUtility(context).error('Could not launch the URL.');
                //       }
                //     },
                //     child: SvgPicture.asset(
                //       Assets.LINKEDIN_LOGO,
                //       height: 20 * ScaleSize.textScaleFactor(context),
                //       width: 20 * ScaleSize.textScaleFactor(context),
                //     ),
                //   ),
              ],
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
            const SizedBox(
              height: 5,
            ),
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
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                if (userProfileData?.linkedinLink != null && userProfileData?.linkedinLink != '')
                  GestureDetector(
                    onTap: () async {
                      String? linkedInUrl = userProfileData?.linkedinLink?.trim() ?? '';
                      if (await canLaunchUrl(Uri.parse(linkedInUrl))) {
                        await launchUrl(Uri.parse(linkedInUrl));
                      } else {
                        print('Could not launch ${linkedInUrl}');
                        AppUtility(context).error('Could not launch the URL.');
                      }
                    },
                    child: SvgPicture.asset(
                      Assets.LINKEDIN_LOGO,
                      height: 20 * ScaleSize.textScaleFactor(context),
                      width: 20 * ScaleSize.textScaleFactor(context),
                    ),
                  ),
                const SizedBox(
                  width: 15,
                ),
                if (userProfileData?.portfolioLink != null && userProfileData?.portfolioLink != '')
                  GestureDetector(
                    onTap: () async {
                      String? portfolioUrl = userProfileData?.portfolioLink?.trim() ?? '';
                      if (await canLaunchUrl(Uri.parse(portfolioUrl))) {
                        await launchUrl(Uri.parse(portfolioUrl));
                      } else {
                        print('Could not launch ${portfolioUrl}');
                        AppUtility(context).error('Could not launch the URL.');
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'Portfolio',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        Icon(
                          Icons.open_in_new,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 15 * ScaleSize.textScaleFactor(context),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
