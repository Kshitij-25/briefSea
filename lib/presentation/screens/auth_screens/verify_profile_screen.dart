import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../common/app_utility.dart';
import '../../../common/assets.dart';
import '../../../common/industry_data.dart';
import '../../../common/screen_size.dart';
import '../../../main.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../state_providers/verify_profile_industry_provider.dart';
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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF4C27FF),
        centerTitle: true,
        title: const Text(
          "Complete Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final uploadedAvatarKey = ref.watch(uploadedAvatarKeyProvider.notifier).state;
              var uploadedBannerKey = ref.watch(uploadedBannerKeyProvider.notifier).state;
              final selectedIndustry = ref.watch(selectedIndustriesProvider.notifier).state;
              final selectedExpertise = ref.watch(selectedExpertiseProvider.notifier).state;
              final selectedGender = ref.watch(selectedGenderProvider).selectedGender;
              // if (uploadedBannerKey == '' || uploadedBannerKey == null) {
              //   uploadedBannerKey = await sendDefaultBanner(ref: ref, userDetails: userDetails);
              // }
              if (phoneNumberCont.text.isNotEmpty &&
                  companyCont.text.isNotEmpty &&
                  jobTitleCont.text.isNotEmpty &&
                  locationCont.text.isNotEmpty &&
                  countryCodeCont.text.isNotEmpty) {
                var verifyMessage = await ref.read(verifyProfileProvider(
                  userId: userDetails['user_id']!,
                  uName: userDetails['user_name']!,
                  countryCode: int.tryParse(countryCodeCont.text),
                  contact: int.tryParse(phoneNumberCont.text),
                  company: companyCont.text,
                  jobTitle: jobTitleCont.text,
                  industry: selectedIndustry,
                  location: locationCont.text,
                  avatarSrc: uploadedAvatarKey ?? '',
                  bannerSrc: uploadedBannerKey ?? '',
                  jwtToken: userDetails['jwtToken'],
                  expertise: selectedExpertise,
                  postingAs: userDetails['type']!,
                  gender: selectedGender,
                ).future);
                if (verifyMessage == "Profile added successfully") {
                  AppUtility(context).message(verifyMessage);
                  context.go(HomeScreen.routeName);
                }
              } else {
                AppUtility(context).message("Please complete the profile first.");
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
    final verifyAvatar = ref.watch(verifyAvatarImageProvider);
    final verifyBanner = ref.watch(verifyBannerImageProvider);
    final selectedIndustries = ref.watch(selectedIndustriesProvider.notifier).state;
    final selectedExpertise = ref.watch(selectedExpertiseProvider.notifier).state;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              _BannerWidget(
                verifyBanner: verifyBanner,
                picker: _picker,
                userDetails: userDetails,
              ),
              _AvatarWidget(
                picker: _picker,
                verifyAvatar: verifyAvatar,
                userDetails: userDetails,
                gender: ref.watch(selectedGenderProvider).selectedGender,
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
              hintText: "${userDetails['user_name']?[0].toUpperCase()}${userDetails['user_name']!.substring(1)}",
              hintColor: Colors.black,
            ),
            CupertinoIcons.person,
            () {},
          ),
          customFields(
            context,
            'Posting as',
            CustomTextFormField(
              readOnly: true,
              hintText: "${userDetails['type']?[0].toUpperCase()}${userDetails['type']!.substring(1)}",
              hintColor: Colors.black,
            ),
            CupertinoIcons.person_2,
            () {},
          ),
          customFields(
            context,
            'Gender',
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: const Text('Choose your gender'),
                menuMaxHeight: 300,
                value: ref.watch(selectedGenderProvider).selectedGender,
                onChanged: (String? newValue) async {
                  print(prefs!.getString('userGener'));
                  log("NEW VALUE=====> $newValue");

                  ref.read(selectedGenderProvider).setGender(newValue!);

                  await prefs!.setString('userGener', newValue ?? "");
                },
                items: ref.watch(selectedGenderProvider).genders.map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),
            ),
            Icons.female,
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
                    hintText: "91",
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
            'Industry',
            MultiSelectDialogField(
              items: industries.map((item) => MultiSelectItem<String>(item['value']!, item['label']!)).toList(),
              initialValue: selectedIndustries,
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                ref.read(selectedIndustriesProvider.notifier).state = values;
              },
              title: const Text('Select Industries'),
            ),
            CupertinoIcons.square_list_fill,
            () {},
          ),
          customFields(
            context,
            'Designation',
            CustomTextFormField(
              hintText: "Enter your Designation",
              controller: jobTitleCont,
            ),
            Icons.work_outline_rounded,
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
            'Location',
            CustomTextFormField(
              hintText: "Enter your Location",
              controller: locationCont,
            ),
            CupertinoIcons.location_solid,
            () {},
          ),
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

  Future<String?> sendDefaultBanner({WidgetRef? ref, Map<String, String>? userDetails}) async {
    var uploadedBanner = await ref!.read(
      uploadBannerProvider(
        fileName: "Placeholder Image",
        fileType: lookupMimeType(BANNER),
        userId: userDetails!['user_id'],
        userType: userDetails['type'],
      ).future,
    );
    ref.read(uploadToAWSProvider(
      url: uploadedBanner.url,
      fileName: "Placeholder Image",
      file: File(BANNER),
      fileType: lookupMimeType(BANNER),
    ));
    // ref.read(uploadedBannerKeyProvider.notifier).state = uploadedBanner.key;
    return uploadedBanner.key;
  }
}

class _AvatarWidget extends ConsumerWidget {
  const _AvatarWidget({
    required this.userDetails,
    required ImagePicker picker,
    required this.verifyAvatar,
    this.gender,
  }) : _picker = picker;

  final ImagePicker _picker;
  final File? verifyAvatar;
  final Map<String, String> userDetails;
  final String? gender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () async {
            final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              var uploadedAvatar = await ref.read(uploadAvatarProvider(
                fileName: pickedFile.name,
                fileType: lookupMimeType(pickedFile.path),
                userId: userDetails['user_id'],
                userType: userDetails['type'],
              ).future);
              await ref.read(uploadToAWSProvider(
                url: uploadedAvatar.url,
                fileName: pickedFile.name,
                file: File(pickedFile.path),
                fileType: lookupMimeType(pickedFile.path),
              ).future);
              ref.read(uploadedAvatarKeyProvider.notifier).state = uploadedAvatar.key;

              ref.read(verifyAvatarImageProvider.notifier).state = File(pickedFile.path);
            }
          },
          child: Stack(
            children: [
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: const Color(0xFF1B0C6B),
                  image: DecorationImage(
                    fit: gender == null ? BoxFit.scaleDown : BoxFit.cover,
                    image: verifyAvatar != null ? FileImage(verifyAvatar!) : _getImageByGender(gender),
                    colorFilter: gender == null ? const ColorFilter.mode(Colors.white, BlendMode.srcIn) : null,
                  ),
                ),
              ),
              Positioned(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getImageByGender(String? gender) {
    if (gender == null) {
      return const AssetImage(PERSON);
    } else if (gender == "Male") {
      return const AssetImage(MALE);
    } else if (gender == "Female") {
      return const AssetImage(FEMALE);
    } else {
      return const AssetImage(OTHERS);
    }
  }
}

class _BannerWidget extends ConsumerWidget {
  const _BannerWidget({
    required this.userDetails,
    required this.verifyBanner,
    required ImagePicker picker,
  }) : _picker = picker;

  final File? verifyBanner;
  final ImagePicker _picker;
  final Map<String, String> userDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: ScreenSize.width(context),
      height: ScreenSize.height(context) * 0.15,
      color: Colors.white,
      child: verifyBanner != null
          ? Stack(
              children: [
                Image(
                  width: ScreenSize.width(context),
                  image: FileImage(verifyBanner!),
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
                          fileType: lookupMimeType(pickedFile.path),
                          userId: userDetails['user_id'],
                          userType: userDetails['type'],
                        ).future);
                        ref.read(uploadToAWSProvider(
                          url: uploadedBanner.url,
                          fileName: pickedFile.name,
                          file: File(pickedFile.path),
                          fileType: lookupMimeType(pickedFile.path),
                        ));
                        // Update the avatar URL provider
                        ref.read(uploadedBannerKeyProvider.notifier).state = uploadedBanner.key;

                        ref.read(verifyBannerImageProvider.notifier).state = File(pickedFile.path);
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
          : Stack(
              children: [
                Image.asset(
                  BANNER,
                  fit: BoxFit.cover,
                  width: ScreenSize.width(context),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () async {
                      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        var uploadedBanner = await ref.read(uploadBannerProvider(
                          fileName: pickedFile.name,
                          fileType: lookupMimeType(pickedFile.path),
                          userId: userDetails['user_id'],
                          userType: userDetails['type'],
                        ).future);
                        ref.read(uploadToAWSProvider(
                          url: uploadedBanner.url,
                          fileName: pickedFile.name,
                          file: File(pickedFile.path),
                          fileType: lookupMimeType(pickedFile.path),
                        ));
                        ref.read(uploadedBannerKeyProvider.notifier).state = uploadedBanner.key;

                        ref.read(verifyBannerImageProvider.notifier).state = File(pickedFile.path);
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.camera_fill,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
