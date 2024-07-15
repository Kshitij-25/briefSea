import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../common/app_utils/debouncer.dart';
import '../../../common/app_utils/screen_size.dart';
import '../../../common/app_utils/shared_prefs_helper.dart';
import '../../../common/app_utils/validation_utils.dart';
import '../../../common/others/assets.dart';
import '../../../common/static_data/industry_data.dart';
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

  final TextEditingController userNameCont = TextEditingController();
  final TextEditingController countryCodeCont = TextEditingController();
  final TextEditingController phoneNumberCont = TextEditingController();
  final TextEditingController companyCont = TextEditingController();
  final TextEditingController jobTitleCont = TextEditingController();
  final TextEditingController industryCont = TextEditingController();
  final TextEditingController locationCont = TextEditingController();
  final TextEditingController aboutCont = TextEditingController();
  final TextEditingController editDevExpertise = TextEditingController();
  final TextEditingController editMarkExpertise = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    userNameCont.addListener(() {
      _debouncer.run(() async {
        if (_formKey.currentState!.validate()) {
          if (userNameCont.text.isNotEmpty) {
            var doesUsernameExist = await ref.read(checkUserNameProvider(userName: userNameCont.text).future);

            if (!doesUsernameExist) {
              AppUtility(context).message("Username already exists.");
            }
          }
        }
      });
    });

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
              var uploadedAvatarKey = ref.watch(uploadedAvatarKeyProvider.notifier).state;
              var uploadedBannerKey = ref.watch(uploadedBannerKeyProvider.notifier).state;
              final selectedIndustry = ref.watch(selectedIndustriesProvider.notifier).state;
              final selectedDevExpertise = ref.watch(selectedDevExpertiseProvider.notifier).state;
              final selectedMarkExpertise = ref.watch(selectedMarkExpertiseProvider.notifier).state;
              final selectedGender = ref.watch(selectedGenderProvider).selectedGender;
              if (uploadedBannerKey == '' || uploadedBannerKey == null) {
                uploadedBannerKey = await sendDefaultBanner(ref: ref, userDetails: userDetails);
              }
              if (uploadedAvatarKey == '' || uploadedAvatarKey == null) {
                uploadedAvatarKey = await sendDefaultAvatar(ref: ref, userDetails: userDetails);
              }
              if (phoneNumberCont.text.isNotEmpty && locationCont.text.isNotEmpty && countryCodeCont.text.isNotEmpty) {
                var verifyMessage = await ref.read(
                  verifyProfileProvider(
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
                    devExpertise: selectedDevExpertise,
                    markExpertise: selectedMarkExpertise,
                    postingAs: userDetails['type']!,
                    gender: selectedGender,
                    username: userNameCont.text,
                    aboutMe: aboutCont.text,
                  ).future,
                );
                if (verifyMessage == "Profile added successfully") {
                  AppUtility(context).message(verifyMessage);
                  context.pushReplacementNamed(HomeScreen.routeName);
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
    final selectedDevExpertise = ref.watch(selectedDevExpertiseProvider.notifier).state;
    final selectedMarkExpertise = ref.watch(selectedMarkExpertiseProvider.notifier).state;
    final devExpertiseItems = ref.watch(devExpertiseItemsProvider.notifier).state;
    final markExpertiseItems = ref.watch(markExpertiseItemsProvider.notifier).state;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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
                hintText: "${userDetails['user_name']?[0].toUpperCase()}${userDetails['user_name']?.substring(1)}",
                hintColor: Colors.black,
              ),
            ),
            customFields(
              context,
              'Posting as',
              CustomTextFormField(
                readOnly: true,
                hintText: "${userDetails['type']?[0].toUpperCase()}${userDetails['type']?.substring(1)}",
                hintColor: Colors.black,
              ),
            ),
            customFields(
              context,
              'Username',
              CustomTextFormField(
                controller: userNameCont,
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
                  hint: const Text('Choose your gender'),
                  menuMaxHeight: 300,
                  value: ref.watch(selectedGenderProvider).selectedGender,
                  onChanged: (String? newValue) async {
                    log("NEW VALUE=====> $newValue");

                    ref.read(selectedGenderProvider).setGender(newValue!);

                    await SharedPreferencesHelper.saveString('userGener', newValue ?? "");
                  },
                  items: ref.watch(selectedGenderProvider).genders.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      // validator: (value) {
                      //   if (ValidationUtils.isNotEmpty(value!)) {
                      //     return 'Country code is required';
                      //   }
                      //   if (ValidationUtils.isValidCountryCode(value)) {
                      //     return 'Enter a valid country code (1 to 3 digits)';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: CustomTextFormField(
                      hintText: "Phone Number",
                      controller: phoneNumberCont,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      border: const OutlineInputBorder(),
                      // validator: (value) {
                      //   if (!ValidationUtils.isNotEmpty(value!)) {
                      //     return 'Phone number is required';
                      //   }
                      //   if (!ValidationUtils.isValidPhoneNumber(value)) {
                      //     return 'Enter a valid phone number';
                      //   }
                      //   return null;
                      // },
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
                initialValue: selectedIndustries,
                onTap: (List<String?> values) {
                  ref.read(selectedIndustriesProvider.notifier).state = values.whereType<String>().toList();
                  // ref.invalidate(selectedIndustriesProvider);
                  ref.invalidate(selectedDevExpertiseProvider);
                  ref.invalidate(selectedMarkExpertiseProvider);
                },
                showHeader: false,
                decoration: BoxDecoration(),
                // selectedChipColor: const Color(0xFF4C27FF),
                // selectedTextStyle: TextStyle(color: Colors.white),
              ),
            ),
            if (selectedIndustries.contains('Development & Product'))
              customFields(
                context,
                'Developement\nExpertise',
                Column(
                  children: [
                    MultiSelectChipField<String?>(
                      items: devExpertiseItems,
                      initialValue: selectedDevExpertise,
                      onTap: (List<String?> values) {
                        ref.read(selectedDevExpertiseProvider.notifier).state = values.whereType<String>().toList();
                      },
                      showHeader: false,
                      decoration: BoxDecoration(),
                      // selectedChipColor: const Color(0xFF4C27FF),
                      // selectedTextStyle: TextStyle(color: Colors.white),
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
            if (selectedIndustries.contains('Advertising & Marketing'))
              customFields(
                context,
                'Marketing\nExpertise',
                Column(
                  children: [
                    MultiSelectChipField<String?>(
                      items: markExpertiseItems,
                      initialValue: selectedMarkExpertise,
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
            if (userDetails['type'] != 'freelancer')
              customFields(
                context,
                'Designation',
                CustomTextFormField(
                  hintText: "Enter your Designation",
                  controller: jobTitleCont,
                  textInputAction: TextInputAction.next,
                ),
              ),
            if (userDetails['type'] != 'freelancer')
              customFields(
                context,
                'Company',
                CustomTextFormField(
                  hintText: "Enter Company Name",
                  controller: companyCont,
                  textInputAction: TextInputAction.next,
                ),
              ),
            customFields(
              context,
              'Location',
              CustomTextFormField(
                hintText: "Enter your Location",
                controller: locationCont,
                textInputAction: TextInputAction.done,
              ),
            ),
            customFields(
              context,
              'About',
              CustomTextFormField(
                hintText: "Tell us something about yourself...",
                controller: aboutCont,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  customFields(context, title, subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(title),
          SizedBox(width: 10),
          Expanded(child: subtitle),
        ],
      ),
    );
  }

  Future<String?> sendDefaultBanner({WidgetRef? ref, Map<String, String>? userDetails}) async {
    final byteData = await rootBundle.load(Assets.BANNER);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/placeholderBanner.jpg');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    // Get the file path
    final filePath = file.path;

    var uploadedBanner = await ref!.read(
      uploadBannerProvider(
        fileName: "placeholderBanner.jpg",
        fileType: lookupMimeType(filePath),
        userId: userDetails!['user_id'],
        userType: userDetails['type'],
      ).future,
    );
    ref.read(uploadToAWSProvider(
      url: uploadedBanner.url,
      fileName: "placeholderBanner.jpg",
      file: file,
      fileType: lookupMimeType(filePath),
    ));
    // ref.read(uploadedBannerKeyProvider.notifier).state = uploadedBanner.key;
    return uploadedBanner.key;
  }

  Future<String?> sendDefaultAvatar({WidgetRef? ref, Map<String, String>? userDetails}) async {
    final gender = ref!.watch(selectedGenderProvider).selectedGender;
    String assetPath;

    if (gender == null) {
      assetPath = Assets.PERSON;
    } else if (gender == "Male") {
      assetPath = Assets.MALE;
    } else if (gender == "Female") {
      assetPath = Assets.FEMALE;
    } else {
      assetPath = Assets.OTHERS;
    }

    final byteData = await rootBundle.load(assetPath);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/placeholderAvatar.png');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    // Get the file path
    final filePath = file.path;

    var uploadedAvatar = await ref.read(
      uploadAvatarProvider(
        fileName: "placeholderAvatar.png",
        fileType: lookupMimeType(filePath),
        userId: userDetails!['user_id'],
        userType: userDetails['type'],
      ).future,
    );
    ref.read(uploadToAWSProvider(
      url: uploadedAvatar.url,
      fileName: "placeholderAvatar.png",
      file: file,
      fileType: lookupMimeType(filePath),
    ));
    return uploadedAvatar.key;
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
      return const AssetImage(Assets.PERSON);
    } else if (gender == "Male") {
      return const AssetImage(Assets.MALE);
    } else if (gender == "Female") {
      return const AssetImage(Assets.FEMALE);
    } else {
      return const AssetImage(Assets.OTHERS);
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
                  Assets.BANNER,
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
