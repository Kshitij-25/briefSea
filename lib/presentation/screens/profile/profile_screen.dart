import 'dart:developer';

import 'package:briefsea/common/app_utils/app_utility.dart';
import 'package:briefsea/common/app_utils/screen_size.dart';
import 'package:briefsea/common/others/assets.dart';
import 'package:briefsea/common/others/strings.dart';
import 'package:briefsea/data/core/api_constants.dart';
import 'package:briefsea/data/models/clients_model.dart';
import 'package:briefsea/data/models/experience_model.dart';
import 'package:briefsea/main.dart';
import 'package:briefsea/presentation/providers/auth_provider.dart';
import 'package:briefsea/presentation/providers/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../data/core/app_error.dart';
import '../../../data/models/testimonials_model.dart';
import '../../params/user_profile_params.dart';
import '../../state_providers/verify_profile_industry_provider.dart';
import 'profile_widgets/about_card.dart';
import 'profile_widgets/client_work_card.dart';
import 'profile_widgets/company_card.dart';
import 'profile_widgets/expertise_card.dart';
import 'profile_widgets/profile_avatar_widget.dart';
import 'profile_widgets/profile_banner_widget.dart';
import 'profile_widgets/service_card.dart';
import 'profile_widgets/testimonial_card.dart';
import 'profile_widgets/user_info_details.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({
    super.key,
    this.isOtherProfile = false,
    this.otherUserId,
  });

  static const routeName = '/profileScreen';
  final bool isOtherProfile;
  final String? otherUserId;

  final TextEditingController testimonialName = TextEditingController();
  final TextEditingController testimonailProfileUrl = TextEditingController();
  final TextEditingController testimonailText = TextEditingController();

  final TextEditingController companyName = TextEditingController();
  final TextEditingController companyStartDate = TextEditingController();
  final TextEditingController companyEndDate = TextEditingController();

  final TextEditingController clientName = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController clientPortfolio = TextEditingController();

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
                height: userDetails.isLoading || userDetails.hasError || userDetails.isRefreshing ? ScreenSize.height(context) * 0.8 : null,
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
                                ProfileBannerWidget(
                                  userDetails: userData,
                                  userProfileData: userDetails,
                                  isOtherProfile: isOtherProfile,
                                ),
                                ProfileAvatarWidget(
                                  userDetails: userData,
                                  userProfileData: userDetails,
                                  isOtherProfile: isOtherProfile,
                                ),
                              ],
                            ),
                            UserInfoDetails(userProfileData: userDetails),
                          ],
                        ),
                        SizedBox(height: 5),
                        if (userDetails.aboutMe?.isNotEmpty == true) AboutCard(userProfileData: userDetails),
                        SizedBox(height: 5),
                        if ((userDetails.testimonials?.isEmpty == true && isOtherProfile != true) || (userDetails.testimonials?.isNotEmpty == true))
                          TestimonialCards(
                            isOtherProfile: isOtherProfile,
                            userProfileData: userDetails,
                            testimonialName: testimonialName,
                            testimonailProfileUrl: testimonailProfileUrl,
                            testimonailText: testimonailText,
                            testimonialOnPressed: () async {
                              if (testimonialName.text.isEmpty || testimonailProfileUrl.text.isEmpty || testimonailText.text.isEmpty) {
                                AppUtility(context).error('Enter the Details first.');
                                return;
                              }
                              final newTestimonial = TestimonialsModel(
                                name: testimonialName.text,
                                linkedinLink: testimonailProfileUrl.text,
                                testimonial: testimonailText.text,
                              );
                              // Create a copy of the existing clients list and add the new client
                              final updatedTestimonial = List<TestimonialsModel>.from(userDetails.testimonials!)..add(newTestimonial);
                              final specificFields = {
                                'testimonials': updatedTestimonial.map((testimodials) => testimodials.toJson()).toList(),
                              };
                              var profileEdited = await ref.read(
                                UserProfileProvider.editProfileProvider(
                                  EditProfileParams(
                                    userId: userData['user_id']!,
                                    specificFields: specificFields,
                                  ),
                                ).future,
                              );
                              if (profileEdited.acknowledged == true) {
                                ref.invalidate(UserProfileProvider.getUserProfileProvider);
                                AppUtility(context).message('Testimonial Added');
                                GoRouter.of(context).pop();
                              }
                            },
                          ),
                        SizedBox(height: 5),
                        if ((userDetails.testimonials?.isEmpty == true && isOtherProfile != true) || (userDetails.testimonials?.isNotEmpty == true))
                          CompanyCard(
                            isOtherProfile: isOtherProfile,
                            userProfileData: userDetails,
                            companyName: companyName,
                            companyStartDate: companyStartDate,
                            companyEndDate: companyEndDate,
                            companyOnPressed: () async {
                              final selectedPost = ref.watch(selectedPostProvider);
                              final teamSize = ref.watch(selectedTeamSizeProvider);

                              if (companyName.text.isEmpty || companyStartDate.text.isEmpty || selectedPost == null || teamSize == null) {
                                AppUtility(context).error('Enter the Details first.');
                                return;
                              }
                              final newCompany = ExperienceModel(
                                post: selectedPost,
                                startDate: companyStartDate.text,
                                endDate: companyEndDate.text,
                                worksAt: companyName.text,
                                teamSize: teamSize,
                              );
                              // Create a copy of the existing clients list and add the new client
                              final updatedCompaines = List<ExperienceModel>.from(userDetails.experience!)..add(newCompany);
                              final specificFields = {
                                'experience': updatedCompaines.map((clients) => clients.toJson()).toList(),
                              };
                              var profileEdited = await ref.read(
                                UserProfileProvider.editProfileProvider(
                                  EditProfileParams(
                                    userId: userData['user_id']!,
                                    specificFields: specificFields,
                                  ),
                                ).future,
                              );
                              if (profileEdited.acknowledged == true) {
                                ref.invalidate(UserProfileProvider.getUserProfileProvider);
                                AppUtility(context).message('Client Added');
                                GoRouter.of(context).pop();
                              }
                            },
                          ),
                        SizedBox(height: 5),
                        if ((userDetails.testimonials?.isEmpty == true && isOtherProfile != true) || (userDetails.testimonials?.isNotEmpty == true))
                          ClientWorkCard(
                            isOtherProfile: isOtherProfile,
                            userProfileData: userDetails,
                            clientName: clientName,
                            startDate: startDate,
                            endDate: endDate,
                            clientPortfolio: clientPortfolio,
                            clientOnPressed: () async {
                              if (clientName.text.isEmpty || startDate.text.isEmpty || clientPortfolio.text.isEmpty) {
                                AppUtility(context).error('Enter the Details first.');
                                return;
                              }
                              final newClient = ClientsModel(
                                company: clientName.text,
                                startDate: startDate.text,
                                endDate: endDate.text ?? '',
                                link: clientPortfolio.text,
                              );
                              // Create a copy of the existing clients list and add the new client
                              final updatedClient = List<ClientsModel>.from(userDetails.clients!)..add(newClient);
                              final specificFields = {
                                'clients': updatedClient.map((clients) => clients.toJson()).toList(),
                              };
                              var profileEdited = await ref.read(
                                UserProfileProvider.editProfileProvider(
                                  EditProfileParams(
                                    userId: userData['user_id']!,
                                    specificFields: specificFields,
                                  ),
                                ).future,
                              );
                              if (profileEdited.acknowledged == true) {
                                ref.invalidate(UserProfileProvider.getUserProfileProvider);
                                AppUtility(context).message('Client Added');
                                GoRouter.of(context).pop();
                              }
                            },
                          ),
                        ExpertiseCard(userProfileData: userDetails),
                        ServicesCard(userProfileData: userDetails),
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
