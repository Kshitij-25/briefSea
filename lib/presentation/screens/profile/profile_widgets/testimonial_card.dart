import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/app_utils/app_utility.dart';
import '../../../../common/app_utils/screen_size.dart';
import '../../../../common/others/assets.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/linkable_text.dart';

class TestimonialCards extends StatelessWidget {
  TestimonialCards({
    this.userProfileData,
    this.isOtherProfile,
    this.testimonialOnPressed,
    required this.testimonialName,
    required this.testimonailProfileUrl,
    required this.testimonailText,
  });

  final UserProfileModel? userProfileData;
  final bool? isOtherProfile;

  final TextEditingController testimonialName;
  final TextEditingController testimonailProfileUrl;
  final TextEditingController testimonailText;

  final void Function()? testimonialOnPressed;

  @override
  Widget build(BuildContext context) {
    if (userProfileData?.testimonials?.isEmpty == true)
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Testimonials',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
                Spacer(),
                if (isOtherProfile != true)
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        useSafeArea: true,
                        isScrollControlled: true,
                        constraints: BoxConstraints.fromViewConstraints(ViewConstraints(minWidth: ScreenSize.width(context))),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 15, right: 15, top: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Add Testimonial',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                ),
                                CustomTextFormField(
                                  hintText: 'Name of the Person',
                                  controller: testimonialName,
                                ),
                                SizedBox(height: 5),
                                CustomTextFormField(
                                  hintText: 'Their LinkedIn Profile',
                                  controller: testimonailProfileUrl,
                                ),
                                SizedBox(height: 5),
                                CustomTextFormField(
                                  hintText: 'Write about what they say!',
                                  maxLines: 6,
                                  controller: testimonailText,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                      ),
                                      onPressed: testimonialOnPressed,
                                      child: Text('Add'),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(context).colorScheme.secondary,
                                      ),
                                      onPressed: () {
                                        GoRouter.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25)
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.add_circled_solid,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 5),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(-0.73, 0.68),
                    end: Alignment(0.73, -0.68),
                    colors: [Color(0xFF4A26FE), Color(0xFF222CFF)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'No testimonials available for now!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.42,
                    ),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    else
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Testimonials',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
                Spacer(),
                if (isOtherProfile != true)
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        useSafeArea: true,
                        constraints: BoxConstraints.fromViewConstraints(ViewConstraints(minWidth: ScreenSize.width(context))),
                        isScrollControlled: true,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 15, right: 15, top: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Add Testimonial',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                ),
                                CustomTextFormField(
                                  hintText: 'Name of the Person',
                                  controller: testimonialName,
                                ),
                                SizedBox(height: 5),
                                CustomTextFormField(
                                  hintText: 'Their LinkedIn Profile',
                                  controller: testimonailProfileUrl,
                                ),
                                SizedBox(height: 5),
                                CustomTextFormField(
                                  hintText: 'Write about what they say!',
                                  maxLines: 6,
                                  controller: testimonailText,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                      ),
                                      onPressed: testimonialOnPressed,
                                      child: Text('Add'),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(context).colorScheme.secondary,
                                      ),
                                      onPressed: () {
                                        GoRouter.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    )
                                  ],
                                ),
                                SizedBox(height: 25),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.add_circled_solid,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 120,
              width: ScreenSize.width(context),
              child: ListView.builder(
                itemCount: userProfileData?.testimonials?.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final userColor = _generateUserColor(userProfileData, index);
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.tertiary,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12 * ScaleSize.textScaleFactor(context),
                                        backgroundColor: userColor,
                                        child: Text(
                                          userProfileData?.testimonials?[index].name?[0].toUpperCase() ?? '',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12 * ScaleSize.textScaleFactor(context),
                                              ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          userProfileData?.testimonials?[index].name ?? '',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Colors.white,
                                                fontSize: 14 * ScaleSize.textScaleFactor(context),
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () async {
                                          String? linkedInUrl = userProfileData?.testimonials?[index].linkedinLink?.trim() ?? '';
                                          if (await canLaunchUrl(Uri.parse(linkedInUrl))) {
                                            await launchUrl(Uri.parse(linkedInUrl));
                                          } else {
                                            print('Could not launch ${linkedInUrl}');
                                            AppUtility(context).error('Could not launch the URL.');
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          Assets.LINKEDIN_LOGO,
                                          height: 14 * ScaleSize.textScaleFactor(context),
                                          width: 14 * ScaleSize.textScaleFactor(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    userProfileData?.testimonials?[index].testimonial ?? '',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: Colors.white,
                                          fontSize: 14 * ScaleSize.textScaleFactor(context),
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: ScreenSize.width(context) * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12 * ScaleSize.textScaleFactor(context),
                                  backgroundColor: userColor,
                                  child: Text(
                                    userProfileData?.testimonials?[index].name?[0].toUpperCase() ?? '',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12 * ScaleSize.textScaleFactor(context),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  userProfileData?.testimonials?[index].name ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.white,
                                        fontSize: 14 * ScaleSize.textScaleFactor(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    String? linkedInUrl = userProfileData?.testimonials?[index].linkedinLink?.trim() ?? '';
                                    if (await canLaunchUrl(Uri.parse(linkedInUrl))) {
                                      await launchUrl(Uri.parse(linkedInUrl));
                                    } else {
                                      print('Could not launch ${linkedInUrl}');
                                      AppUtility(context).error('Could not launch the URL.');
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    Assets.LINKEDIN_LOGO,
                                    height: 14 * ScaleSize.textScaleFactor(context),
                                    width: 14 * ScaleSize.textScaleFactor(context),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            LinkableText(
                              maxLines: 3,
                              text: userProfileData?.testimonials?[index].testimonial,
                              style1: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontSize: 14 * ScaleSize.textScaleFactor(context),
                                    fontStyle: FontStyle.italic,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              style2: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontSize: 14 * ScaleSize.textScaleFactor(context),
                                    fontStyle: FontStyle.italic,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
  }

  Color _generateUserColor(UserProfileModel? userProfileData, int? index) {
    final random = math.Random(userProfileData!.testimonials![index!].name.hashCode);
    return Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7);
  }
}
