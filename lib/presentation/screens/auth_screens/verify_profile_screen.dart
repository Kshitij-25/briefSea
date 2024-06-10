import 'dart:io';

import 'package:briefsea/common/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/app_utility.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../widgets/custom_text_form_field.dart';
import '../home_screen.dart';

class VerifyProfileScreen extends ConsumerWidget {
  VerifyProfileScreen({super.key});

  static const routeName = "/verifyProfileScreen";

  final ImagePicker _picker = ImagePicker();

  final TextEditingController countryCodeCont = TextEditingController();
  final TextEditingController phoneNumberCont = TextEditingController();
  final TextEditingController companyCont = TextEditingController();
  final TextEditingController jobTitleCont = TextEditingController();
  final TextEditingController industryCont = TextEditingController();
  final TextEditingController locationCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);
    return Scaffold(
      backgroundColor: Colors.grey[200]!,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4C27FF),
        centerTitle: true,
        title: const Text(
          "Verify Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final uploadedAvatarKey = ref.read(uploadedAvatarKeyProvider.notifier).state;
              final uploadedBannerKey = ref.read(uploadedBannerKeyProvider.notifier).state;
              if (companyCont.text.isNotEmpty &&
                  phoneNumberCont.text.isNotEmpty &&
                  companyCont.text.isNotEmpty &&
                  jobTitleCont.text.isNotEmpty &&
                  industryCont.text.isNotEmpty &&
                  locationCont.text.isNotEmpty) {
                var verifyMessage = await ref.read(verifyProfileProvider(
                        userId: userDetails['user_id']!,
                        uName: userDetails['user_name']!,
                        countryCode: countryCodeCont.text,
                        contact: phoneNumberCont.text,
                        company: companyCont.text,
                        jobTitle: jobTitleCont.text,
                        industry: industryCont.text,
                        location: locationCont.text,
                        avatarSrc: uploadedAvatarKey ?? '',
                        bannerSrc: uploadedBannerKey ?? '',
                        jwtToken: userDetails['jwtToken'],
                        expertise: "")
                    .future);
                if (verifyMessage == "Profile added cuccessfully") {
                  AppUtility(context).message(verifyMessage);
                  context.go(HomeScreen.routeName);
                }
              }
            },
            child: const Text(
              "Done",
              style: TextStyle(color: Colors.white),
              textScaler: TextScaler.linear(1.3),
            ),
          ),
        ],
      ),
      body: bodyWidget(context, ref, userDetails),
    );
  }

  bodyWidget(context, WidgetRef ref, Map<String, String> userDetails) {
    final selectedProfile = ref.watch(selectedProfileImageProvider);
    final selectedBanner = ref.watch(selectedBannerImageProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: ScreenSize.width(context),
                height: ScreenSize.height(context) * 0.15,
                color: Colors.white,
                child: selectedBanner != null
                    ? Stack(
                        children: [
                          Image(
                            width: ScreenSize.width(context),
                            image: FileImage(selectedBanner),
                            fit: BoxFit.fill,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () async {
                                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  var uploadedBanner = await ref.read(uploadBannerProvider(
                                    fileName: pickedFile.name,
                                    fileType: AppUtility(context).getMediaType(pickedFile.path),
                                    userId: userDetails['user_id'],
                                    userType: userDetails['type'],
                                  ).future);
                                  ref.read(uploadToAWSProvider(
                                    url: uploadedBanner.url,
                                    fileName: pickedFile.name,
                                    file: File(pickedFile.path),
                                    fileType: AppUtility(context).getMediaType(pickedFile.path),
                                  ));
                                  // Update the avatar URL provider
                                  ref.read(uploadedBannerKeyProvider.notifier).state = uploadedBanner.key;

                                  ref.read(selectedBannerImageProvider.notifier).state = File(pickedFile.path);
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
                    : Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () async {
                            final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                            if (pickedFile != null) {
                              var uploadedBanner = await ref.read(uploadBannerProvider(
                                fileName: pickedFile.name,
                                fileType: AppUtility(context).getMediaType(pickedFile.path),
                                userId: userDetails['user_id'],
                                userType: userDetails['type'],
                              ).future);
                              ref.read(uploadToAWSProvider(
                                url: uploadedBanner.url,
                                fileName: pickedFile.name,
                                file: File(pickedFile.path),
                                fileType: AppUtility(context).getMediaType(pickedFile.path),
                              ));
                              ref.read(uploadedBannerKeyProvider.notifier).state = uploadedBanner.key;

                              ref.read(selectedBannerImageProvider.notifier).state = File(pickedFile.path);
                            }
                          },
                          icon: const Icon(CupertinoIcons.camera_fill),
                        ),
                      ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () async {
                      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        var uploadedAvatar = await ref.read(uploadAvatarProvider(
                          fileName: pickedFile.name,
                          fileType: AppUtility(context).getMediaType(pickedFile.path),
                          userId: userDetails['user_id'],
                          userType: userDetails['type'],
                        ).future);
                        ref.read(uploadToAWSProvider(
                          url: uploadedAvatar.url,
                          fileName: pickedFile.name,
                          file: File(pickedFile.path),
                          fileType: AppUtility(context).getMediaType(pickedFile.path),
                        ));
                        ref.read(uploadedAvatarKeyProvider.notifier).state = uploadedAvatar.key;

                        ref.read(selectedProfileImageProvider.notifier).state = File(pickedFile.path);
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF1B0C6B),
                      radius: 70,
                      backgroundImage: selectedProfile != null ? FileImage(selectedProfile) : null,
                      child: selectedProfile == null
                          ? const Center(
                              child: Icon(
                                CupertinoIcons.camera_fill,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Tap a field to edit.",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          customFields(
            context,
            'Name',
            CustomTextFormField(
              readOnly: true,
              hintText: "${userDetails['user_name']![0].toUpperCase()}${userDetails['user_name']!.substring(1)}",
              hintColor: Colors.black,
            ),
            CupertinoIcons.person,
            () {},
          ),
          customFields(
            context,
            'Contact',
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomTextFormField(
                    border: const OutlineInputBorder(),
                    controller: countryCodeCont,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: CustomTextFormField(
                    hintText: "Phone Number",
                    controller: phoneNumberCont,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            CupertinoIcons.phone_fill,
            () {},
          ),
          customFields(
            context,
            'Company',
            CustomTextFormField(
              hintText: "Enter Company Name",
              controller: companyCont,
            ),
            CupertinoIcons.building_2_fill,
            () {},
          ),
          customFields(
            context,
            'Job Title',
            CustomTextFormField(
              hintText: "Enter Job Title",
              controller: jobTitleCont,
            ),
            Icons.work_outline_rounded,
            () {},
          ),
          customFields(
            context,
            'Industry',
            CustomTextFormField(
              hintText: "Select Industry",
              controller: industryCont,
            ),
            CupertinoIcons.square_list_fill,
            () {},
          ),
          customFields(
            context,
            'Posting as',
            CustomTextFormField(
              readOnly: true,
              hintText: "${userDetails['type']![0].toUpperCase()}${userDetails['type']!.substring(1)}",
              hintColor: Colors.black,
            ),
            CupertinoIcons.person_2,
            () {},
          ),
          customFields(
            context,
            'Location',
            CustomTextFormField(
              hintText: "Enter your Location",
              controller: locationCont,
            ),
            CupertinoIcons.location_solid,
            () {},
          ),
          // customFields(
          //   context,
          //   'About me',
          //   "",
          //   CupertinoIcons.info,
          //   () {},
          // ),
        ],
      ),
    );
  }

  customFields(context, title, subtitle, icon, void Function()? onTap) {
    return ListTile(
      dense: true,
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle,
      onTap: onTap!,
    );
  }
}
