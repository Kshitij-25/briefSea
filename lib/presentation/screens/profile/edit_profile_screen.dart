import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../common/app_utils/debouncer.dart';
import '../../../common/app_utils/screen_size.dart';
import '../../../common/app_utils/shared_prefs_helper.dart';
import '../../../common/app_utils/validation_utils.dart';
import '../../../common/others/assets.dart';
import '../../../common/static_data/industry_data.dart';
import '../../../data/models/user_profile_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../state_providers/verify_profile_industry_provider.dart';
import '../../widgets/custom_text_form_field.dart';

class EditProfileScreen extends ConsumerWidget {
  EditProfileScreen({super.key, required this.userProfileModel});

  static const routeName = '/editProfileScreen';

  final UserProfileModel userProfileModel;

  final ImagePicker _picker = ImagePicker();

  final TextEditingController editUserNameCont = TextEditingController();
  final TextEditingController editCountryCodeCont = TextEditingController();
  final TextEditingController editPhoneNumberCont = TextEditingController();
  final TextEditingController editCompanyCont = TextEditingController();
  final TextEditingController editJobTitleCont = TextEditingController();
  final TextEditingController editDevExpertise = TextEditingController();
  final TextEditingController editMarkExpertise = TextEditingController();
  final TextEditingController editLocationCont = TextEditingController();
  final TextEditingController editAboutCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    editUserNameCont.text = userProfileModel.userName ?? '';
    editCompanyCont.text = userProfileModel.worksAt ?? '';
    editCountryCodeCont.text = userProfileModel.countryCode.toString();
    editJobTitleCont.text = userProfileModel.post ?? '';
    editPhoneNumberCont.text = userProfileModel.contact.toString();
    editLocationCont.text = userProfileModel.location ?? '';
    editAboutCont.text = userProfileModel.aboutMe ?? '';

    editUserNameCont.addListener(() {
      _debouncer.run(() async {
        if (_formKey.currentState!.validate()) {
          if (editUserNameCont.text.isNotEmpty) {
            var doesUsernameExist = await ref.read(checkUserNameProvider(userName: editUserNameCont.text).future);

            if (!doesUsernameExist) {
              AppUtility(context).message("Username already exists.");
            }
          }
        }
      });
    });

    // final verifyAvatar = ref.watch(verifyAvatarImageProvider);
    // final verifyBanner = ref.watch(verifyBannerImageProvider);

    final selectedIndustries = ref.watch(selectedIndustriesProvider.notifier).state;
    final selectedDevExpertise = ref.watch(selectedDevExpertiseProvider.notifier).state;
    final selectedMarkExpertise = ref.watch(selectedMarkExpertiseProvider.notifier).state;
    final devExpertiseItems = ref.watch(devExpertiseItemsProvider.notifier).state;
    final markExpertiseItems = ref.watch(markExpertiseItemsProvider.notifier).state;
    final userData = ref.watch(userDetailsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200]!,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              enableFeedback: true,
            ),
            onPressed: () async {
              var uploadedAvatarKey = ref.watch(uploadedAvatarKeyProvider.notifier).state;
              var uploadedBannerKey = ref.watch(uploadedBannerKeyProvider.notifier).state;
              var selectedIndustry = ref.watch(selectedIndustriesProvider.notifier).state;
              var selectedDevExpertise = ref.watch(selectedDevExpertiseProvider.notifier).state;
              var selectedMarkExpertise = ref.watch(selectedMarkExpertiseProvider.notifier).state;
              final selectedGender = ref.watch(selectedGenderProvider).selectedGender;
              if (uploadedBannerKey == '' || uploadedBannerKey == null) {
                uploadedBannerKey = userProfileModel.bannerSrc;
              }
              if (uploadedAvatarKey == '' || uploadedAvatarKey == null) {
                uploadedAvatarKey = userProfileModel.avatarSrc;
              }
              if (selectedIndustry.isEmpty) {
                selectedIndustry = userProfileModel.industry!.toList();
              }
              if (selectedDevExpertise.isEmpty) {
                selectedDevExpertise = userProfileModel.devExpertise?.toList() ?? [];
              }
              if (selectedMarkExpertise.isEmpty) {
                selectedMarkExpertise = userProfileModel.markExpertise?.toList() ?? [];
              }
              if (editPhoneNumberCont.text.isNotEmpty && editLocationCont.text.isNotEmpty && editCountryCodeCont.text.isNotEmpty) {
                var profileEdited = await ref.read(
                  editProfileProvider(
                    userId: userData['user_id'],
                    uName: userData['user_name']!,
                    countryCode: int.tryParse(editCountryCodeCont.text),
                    contact: int.tryParse(editPhoneNumberCont.text),
                    company: editCompanyCont.text,
                    jobTitle: editJobTitleCont.text,
                    industry: selectedIndustry,
                    location: editLocationCont.text,
                    avatarSrc: uploadedAvatarKey ?? '',
                    bannerSrc: uploadedBannerKey ?? '',
                    jwtToken: userData['jwtToken'],
                    devExpertise: selectedDevExpertise,
                    markExpertise: selectedMarkExpertise,
                    postingAs: userData['type'],
                    gender: selectedGender,
                    createdAt: userProfileModel.createdAt,
                    updatedAt: userProfileModel.updatedAt,
                    userName: userProfileModel.userName,
                    viewAccess: userProfileModel.viewAccess,
                    aboutMe: editAboutCont.text,
                  ).future,
                );
                if (profileEdited.acknowledged == true) {
                  ref.invalidate(getUserProfileProvider);
                  AppUtility(context).message('Profile updated successfully');
                  GoRouter.of(context).pop();
                }
              } else {
                // AppUtility(context).message("Please complete the profile first.");
              }
            },
            child: Text(
              "Save",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    _BannerWidget(
                      userDetails: userData,
                      userProfileData: userProfileModel,
                    ),
                    _AvatarWidget(
                      userDetails: userData,
                      userProfileData: userProfileModel,
                    ),
                  ],
                ),
                Text(
                  "Tap a field to edit.",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
                customFields(
                  context,
                  'Name',
                  CustomTextFormField(
                    readOnly: true,
                    hintText: userProfileModel.name,
                    hintColor: Colors.black,
                  ),
                ),
                customFields(
                  context,
                  'Posting as',
                  CustomTextFormField(
                    readOnly: true,
                    hintText: userProfileModel.postingAs![0].toUpperCase() + userProfileModel.postingAs!.substring(1),
                    hintColor: Colors.black,
                  ),
                ),
                customFields(
                  context,
                  'Username',
                  CustomTextFormField(
                    controller: editUserNameCont,
                    // readOnly: true,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter your username",
                    validator: (value) {
                      if (!ValidationUtils.isNotEmpty(value!)) {
                        return 'Username is required';
                      }
                      if (!ValidationUtils.isValidUsername(value)) {
                        return 'Username can only contain lowercase letters, numbers, and dots';
                      }
                      return null;
                    },
                  ),
                ),
                customFields(
                  context,
                  'Gender',
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      enableFeedback: true,
                      hint: const Text('Choose your gender'),
                      menuMaxHeight: 300,
                      value: ref.watch(selectedGenderProvider).selectedGender = userProfileModel.gender,
                      onChanged: (String? newValue) async {
                        log("NEW VALUE=====> $newValue");

                        ref.read(selectedGenderProvider).setGender(newValue!);

                        await SharedPreferencesHelper.saveString('userGener', newValue ?? "");
                      },
                      items: ref.watch(selectedGenderProvider).genders.map<DropdownMenuItem<String>>((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(color: Colors.black),
                            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
                          controller: editCountryCodeCont,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (!ValidationUtils.isNotEmpty(value!)) {
                              return 'Country code is required';
                            }
                            if (!ValidationUtils.isValidCountryCode(value)) {
                              return 'Enter a valid country code (1 to 3 digits)';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: CustomTextFormField(
                          hintText: "Phone Number",
                          controller: editPhoneNumberCont,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          border: const OutlineInputBorder(),
                          validator: (value) {
                            if (!ValidationUtils.isNotEmpty(value!)) {
                              return 'Phone number is required';
                            }
                            if (!ValidationUtils.isValidPhoneNumber(value)) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                customFields(
                  context,
                  'Industry',
                  MultiSelectChipField<String?>(
                    items: industries.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList(),
                    initialValue: userProfileModel.industry?.whereType<String>().toList() ?? [],
                    onTap: (List<String?> values) {
                      ref.read(selectedIndustriesProvider.notifier).state = values.whereType<String>().toList();

                      ref.invalidate(selectedDevExpertiseProvider);
                      ref.invalidate(selectedMarkExpertiseProvider);
                    },
                    showHeader: false,
                    decoration: BoxDecoration(),
                    // selectedChipColor: const Color(0xFF4C27FF),
                    // selectedTextStyle: TextStyle(color: Colors.white),
                    textStyle: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
                  ),
                ),
                if (userProfileModel.industry!.contains('Development & Product'))
                  customFields(
                    context,
                    'Developer\nExpertise',
                    Column(
                      children: [
                        MultiSelectChipField<String?>(
                          items: devExpertiseItems,
                          initialValue: userProfileModel.devExpertise?.whereType<String>().toList() ?? [],
                          onTap: (List<String?> values) {
                            ref.read(selectedDevExpertiseProvider.notifier).state = values.whereType<String>().toList();
                          },
                          showHeader: false,
                          decoration: BoxDecoration(),
                          // selectedChipColor: const Color(0xFF4C27FF),
                          // selectedTextStyle: TextStyle(color: Colors.white),
                          textStyle: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
                        ),
                        CustomTextFormField(
                          controller: editDevExpertise,
                          hintText: 'Add more expertise',
                          border: OutlineInputBorder(),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            final newItem = editDevExpertise.text;
                            if (newItem.isNotEmpty) {
                              ref.read(devExpertiseItemsProvider.notifier).state = [
                                ...devExpertiseItems,
                                MultiSelectItem<String?>(newItem, newItem),
                              ];
                              ref.read(selectedDevExpertiseProvider.notifier).state.add(newItem);
                              final updatedSelectedDevExpertise = List<String>.from(selectedDevExpertise)..add(newItem);
                              ref.watch(selectedDevExpertiseProvider.notifier).state = updatedSelectedDevExpertise;
                              ref.invalidate(selectedDevExpertiseProvider);
                              editDevExpertise.clear();
                            }
                            // ref.read(selectedDevExpertiseProvider.notifier).state.add(editDevExpertise.text);
                            // editDevExpertise.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                if (userProfileModel.industry!.contains('Advertising & Marketing'))
                  customFields(
                    context,
                    'Marketing\nExpertise  ',
                    Column(
                      children: [
                        MultiSelectChipField<String?>(
                          textStyle: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
                          items: markExpertiseItems,
                          initialValue: userProfileModel.markExpertise?.whereType<String>().toList() ?? [],
                          onTap: (List<String?> values) {
                            ref.read(selectedMarkExpertiseProvider.notifier).state = values.whereType<String>().toList();
                          },
                          showHeader: false,
                          decoration: BoxDecoration(),
                          // selectedChipColor: const Color(0xFF4C27FF),
                          // selectedTextStyle: TextStyle(color: Colors.white),
                        ),
                        CustomTextFormField(
                          controller: editMarkExpertise,
                          hintText: 'Add more expertise',
                          border: OutlineInputBorder(),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            final newItem = editMarkExpertise.text;
                            if (newItem.isNotEmpty) {
                              ref.read(markExpertiseItemsProvider.notifier).state = [
                                ...markExpertiseItems,
                                MultiSelectItem<String?>(newItem, newItem),
                              ];
                              ref.read(selectedMarkExpertiseProvider.notifier).state.add(newItem);
                              final updatedSelectedMarkExpertise = List<String>.from(selectedMarkExpertise)..add(newItem);
                              ref.watch(selectedMarkExpertiseProvider.notifier).state = updatedSelectedMarkExpertise;
                              ref.invalidate(selectedDevExpertiseProvider);
                              editMarkExpertise.clear();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                if (userProfileModel.postingAs != 'freelancer')
                  customFields(
                    context,
                    'Designation',
                    CustomTextFormField(
                      hintText: "Enter your Designation",
                      controller: editJobTitleCont,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                if (userProfileModel.postingAs != 'freelancer')
                  customFields(
                    context,
                    'Company',
                    CustomTextFormField(
                      hintText: "Enter Company Name",
                      controller: editCompanyCont,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                customFields(
                  context,
                  'Location',
                  CustomTextFormField(
                    hintText: "Enter your Location",
                    controller: editLocationCont,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                customFields(
                  context,
                  'About',
                  CustomTextFormField(
                    hintText: "Tell us something about yourself...",
                    controller: editAboutCont,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.length < 100) {
                        return 'About me must not be more than 100 characters long';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  customFields(context, title, subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          ),
          SizedBox(width: 10),
          Expanded(child: subtitle),
        ],
      ),
    );
  }
}

class _AvatarWidget extends ConsumerWidget {
  _AvatarWidget({
    this.userDetails,
    this.userProfileData,
  });

  final ImagePicker _picker = ImagePicker();

  final Map<String, String>? userDetails;
  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAvatar = ref.watch(selectedAvatarImageProvider);

    math.Random random = math.Random(userProfileData?.userId.hashCode);
    Color userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: userColor,
              radius: 70 * ScaleSize.textScaleFactor(context),
              backgroundImage: selectedAvatar != "" && selectedAvatar != null && userProfileData?.avatarSrc != ""
                  ? CachedNetworkImageProvider(selectedAvatar)
                  : userProfileData?.gender == "Male"
                      ? const AssetImage(Assets.MALE)
                      : userProfileData?.gender == "Female"
                          ? const AssetImage(Assets.FEMALE)
                          : userProfileData?.gender == "Others"
                              ? const AssetImage(Assets.OTHERS)
                              : null,
              child: selectedAvatar == null && userProfileData?.gender == null
                  ? Text(
                      userProfileData?.name?[0].toUpperCase() ?? "",
                      style: const TextStyle(color: Colors.white),
                      textScaler: TextScaler.linear(3 * ScaleSize.textScaleFactor(context)),
                    )
                  : const SizedBox.shrink(),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () async {
                  try {
                    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                    final avatarKey = await ref.read(
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
                    ref.read(uploadedAvatarKeyProvider.notifier).state = avatarKey;

                    ref.read(verifyAvatarImageProvider.notifier).state = File(pickedFile.path);
                    log("PROFILE_SCREEN AVATARURL=====> $avatarKey");
                  } catch (e) {
                    log("Avatar Not Uploaded", error: e);
                  }
                },
                child: Container(
                  width: 35 * ScaleSize.textScaleFactor(context),
                  height: 35 * ScaleSize.textScaleFactor(context),
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
            )
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
  });

  final ImagePicker _picker = ImagePicker();

  final Map<String, String>? userDetails;
  final UserProfileModel? userProfileData;

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
                SizedBox(
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
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    enableFeedback: true,
                    onPressed: () async {
                      try {
                        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                        final bannerKey = await ref.read(
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
                        ref.read(uploadedBannerKeyProvider.notifier).state = bannerKey;

                        ref.read(verifyBannerImageProvider.notifier).state = File(pickedFile.path);
                        log("PROFILE_SCREEN BANNERURL =====> $bannerKey");
                      } catch (e) {
                        log("Banner Not Uploaded", error: e);
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
                  Assets.BANNER,
                  fit: BoxFit.cover,
                  width: ScreenSize.width(context),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    enableFeedback: true,
                    onPressed: () async {
                      try {
                        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                        final bannerKey = await ref.read(
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
                        ref.read(uploadedBannerKeyProvider.notifier).state = bannerKey;

                        ref.read(verifyBannerImageProvider.notifier).state = File(pickedFile.path);
                        // final bannerUrl = await ref.read(getBannerUrlProvider.future);
                        // ref.read(selectedBannerImageProvider.notifier).state = bannerUrl.url;
                        log("PROFILE_SCREEN BANNERURL =====> $bannerKey");
                      } catch (e) {
                        log("Banner Not Uploaded", error: e);
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
