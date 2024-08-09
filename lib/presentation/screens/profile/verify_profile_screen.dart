import 'dart:developer';
import 'dart:io';
import 'dart:math' hide log;

import 'package:briefsea/presentation/params/user_profile_params.dart';
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
import '../../../common/app_utils/validation_utils.dart';
import '../../../common/others/assets.dart';
import '../../../common/static_data/industry_data.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../state_providers/verify_profile_industry_provider.dart';
import '../../widgets/custom_text_form_field.dart';
import '../home_screen.dart';
import 'verify_profile_widgets/avatar_widget.dart';
import 'verify_profile_widgets/banner_widget.dart';

class VerifyProfileScreen extends ConsumerWidget {
  VerifyProfileScreen({super.key});

  static const routeName = "/verifyProfileScreen";

  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameCont = TextEditingController();
  final TextEditingController postingAsCont = TextEditingController();
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
  final TextEditingController linkedInCont = TextEditingController();
  final TextEditingController portfolioCont = TextEditingController();
  final TextEditingController experienceCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    userNameCont.addListener(() {
      _debouncer.run(() async {
        if (_formKey.currentState!.validate()) {
          if (userNameCont.text.isNotEmpty) {
            var doesUsernameExist = await ref.read(UserProfileProvider.checkUserNameProvider(userNameCont.text).future);

            if (!doesUsernameExist) {
              AppUtility(context).error("Username already exists.");
            }
          }
        }
      });
    });

    final userDetails = ref.watch(userDetailsProvider);

    final verifyAvatar = ref.watch(verifyAvatarImageProvider);
    final verifyBanner = ref.watch(verifyBannerImageProvider);
    final selectedIndustries = ref.watch(selectedIndustriesProvider.notifier).state;
    final selectedDevExpertise = ref.watch(selectedDevExpertiseProvider.notifier).state;
    final selectedMarkExpertise = ref.watch(selectedMarkExpertiseProvider.notifier).state;
    final selectedServices = ref.watch(selectedServicesProvider.notifier).state;
    final devExpertiseItems = ref.watch(devExpertiseItemsProvider.notifier).state;
    final markExpertiseItems = ref.watch(markExpertiseItemsProvider.notifier).state;
    final servicesItems = ref.watch(servicesItemsProvider.notifier).state;

    nameCont.text = "${userDetails['user_name']?[0].toUpperCase()}${userDetails['user_name']?.substring(1)}";
    postingAsCont.text = "${userDetails['type']?[0].toUpperCase()}${userDetails['type']?.substring(1)}";

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        title: Text(
          "Complete Profile",
          style: Theme.of(context).textTheme.headlineSmall,
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              enableFeedback: true,
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                var uploadedAvatarKey = ref.watch(uploadedAvatarKeyProvider.notifier).state;
                var uploadedBannerKey = ref.watch(uploadedBannerKeyProvider.notifier).state;
                final selectedIndustry = ref.watch(selectedIndustriesProvider.notifier).state;
                final selectedDevExpertise = ref.watch(selectedDevExpertiseProvider.notifier).state;
                final selectedMarkExpertise = ref.watch(selectedMarkExpertiseProvider.notifier).state;
                final selectedServices = ref.watch(selectedServicesProvider.notifier).state;
                final selectedGender = ref.watch(selectedGenderProvider).selectedGender;
                if (selectedIndustry.isEmpty) {
                  AppUtility(context).error("Please select an industry.");
                  return;
                } else if (selectedDevExpertise.isEmpty && selectedMarkExpertise.length < 3) {
                  AppUtility(context).error("Please select a developer expertise.");
                  return;
                } else if (selectedDevExpertise.length < 3) {
                  AppUtility(context).error("Please select a marketing expertise.");
                  return;
                } else if (selectedServices.isEmpty) {
                  AppUtility(context).error("Please select a service.");
                  return;
                }
                if (uploadedBannerKey == '' || uploadedBannerKey == null) {
                  uploadedBannerKey = await sendDefaultBanner(ref: ref, userDetails: userDetails);
                }
                if (uploadedAvatarKey == '' || uploadedAvatarKey == null) {
                  uploadedAvatarKey = await sendDefaultAvatar(ref: ref, userDetails: userDetails);
                }
                if (selectedGender != null && selectedGender != '') {
                  var fullProfileData = {
                    'user_id': userDetails['user_id']!,
                    'name': userDetails['user_name']!,
                    'postingAs': userDetails['type']!,
                    'industry': selectedIndustry,
                    'devExpertise': selectedDevExpertise,
                    'markExpertise': selectedMarkExpertise,
                    'clients': [],
                    'services': selectedServices,
                    'testimonials': [],
                    'userName': userNameCont.text.trim(),
                    'countryCode': int.tryParse(countryCodeCont.text.trim()),
                    'contact': int.tryParse(phoneNumberCont.text.trim()),
                    'gender': selectedGender,
                    'post': jobTitleCont.text.trim(),
                    'worksAt': companyCont.text.trim(),
                    'location': locationCont.text.trim(),
                    'aboutMe': aboutCont.text.trim(),
                    'avatarSrc': uploadedAvatarKey ?? '',
                    'bannerSrc': uploadedBannerKey ?? '',
                    'experience': [],
                    'linkedinLink': linkedInCont.text.trim(),
                    'portfolioLink': portfolioCont.text.trim(),
                    'expDuration': experienceCont.text.trim(),
                  };

                  var verifyMessage = await ref.read(
                    UserProfileProvider.verifyProfileProvider(
                      VerifyProfileParams(
                        userId: userDetails['user_id']!,
                        fullProfileData: fullProfileData,
                      ),
                    ).future,
                  );
                  if (verifyMessage == "Profile added successfully") {
                    AppUtility(context).message(verifyMessage);
                    context.go(HomeScreen.routeName);
                  }
                } else {
                  AppUtility(context).error("Please complete the profile first.");
                }
              }
            },
            child: Text(
              "Done",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      BannerWidget(
                        verifyBanner: verifyBanner,
                        picker: _picker,
                        userDetails: userDetails,
                      ),
                      AvatarWidget(
                        picker: _picker,
                        verifyAvatar: verifyAvatar,
                        userDetails: userDetails,
                        gender: ref.watch(selectedGenderProvider).selectedGender,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Text(
                          "Tap a field to edit.",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          readOnly: true,
                          controller: nameCont,
                          hintColor: Colors.black,
                          labelText: 'Name',
                          border: const OutlineInputBorder(),
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          readOnly: true,
                          controller: postingAsCont,
                          hintColor: Colors.black,
                          labelText: 'Name',
                          border: const OutlineInputBorder(),
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: userNameCont,
                          textInputAction: TextInputAction.next,
                          hintText: "Enter your username",
                          labelText: 'Username',
                          border: const OutlineInputBorder(),
                          suffixIcon: Icon(Icons.edit),
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
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: linkedInCont,
                          textInputAction: TextInputAction.next,
                          hintText: "Enter your LinkedIn Profile Url (Optional)",
                          labelText: 'LinkedIn Url (Optional)',
                          border: const OutlineInputBorder(),
                          suffixIcon: Icon(Icons.edit),
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: portfolioCont,
                          textInputAction: TextInputAction.next,
                          hintText: "Enter your Portfolio Url (Optional)",
                          labelText: 'Portfolio Url (Optional)',
                          border: const OutlineInputBorder(),
                          suffixIcon: Icon(Icons.edit),
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: experienceCont,
                          textInputAction: TextInputAction.next,
                          hintText: "For example: 5 months or 3 years",
                          labelText: 'Experience',
                          border: const OutlineInputBorder(),
                          suffixIcon: Icon(Icons.edit),
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Choose your gender',
                            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black),
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                          value: ref.watch(selectedGenderProvider).selectedGender,
                          onChanged: (String? newValue) async {
                            log("NEW VALUE=====> $newValue");
                            ref.read(selectedGenderProvider).setGender(newValue!);
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
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomTextFormField(
                                hintText: "91",
                                labelText: 'Country',
                                border: const OutlineInputBorder(),
                                controller: countryCodeCont,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                suffixIcon: Icon(Icons.edit),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Country code is required';
                                  }
                                  final int? countryCode = int.tryParse(value);
                                  if (countryCode == null || countryCode < 1 || countryCode > 999) {
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
                                controller: phoneNumberCont,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                border: const OutlineInputBorder(),
                                labelText: 'Phone Number',
                                suffixIcon: Icon(Icons.edit),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone number is required';
                                  }
                                  final RegExp phoneRegex = RegExp(r'^[+0-9\s\-()]*$');
                                  if (!phoneRegex.hasMatch(value)) {
                                    return 'Enter a valid phone number';
                                  }
                                  final cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');
                                  if (cleanedValue.length < 10 || cleanedValue.length > 15) {
                                    return 'Phone number must be between 10 and 15 digits';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        MultiSelectChipField<String?>(
                          items: industries.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList(),
                          initialValue: selectedIndustries,
                          onTap: (List<String?> values) {
                            ref.read(selectedIndustriesProvider.notifier).state = values.whereType<String>().toList();
                            ref.invalidate(selectedDevExpertiseProvider);
                            ref.invalidate(selectedMarkExpertiseProvider);
                          },
                          headerColor: Theme.of(context).unselectedWidgetColor,
                          title: Text(
                            'Industry',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          decoration: BoxDecoration(),
                          textStyle: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
                          selectedChipColor: Theme.of(context).colorScheme.secondary,
                          selectedTextStyle: TextStyle(color: Colors.white),
                        ),
                        if (selectedIndustries.contains('Development & Product'))
                          Column(
                            children: [
                              MultiSelectChipField<String?>(
                                items: devExpertiseItems,
                                initialValue: selectedDevExpertise,
                                onTap: (List<String?> values) {
                                  ref.read(selectedDevExpertiseProvider.notifier).state = values.whereType<String>().toList();
                                },
                                headerColor: Theme.of(context).unselectedWidgetColor,
                                title: Text(
                                  'Developer Expertise',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                decoration: BoxDecoration(),
                                selectedChipColor: Theme.of(context).colorScheme.secondary,
                                selectedTextStyle: TextStyle(color: Colors.white),
                                textStyle: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
                              ),
                              CustomTextFormField(
                                controller: editDevExpertise,
                                hintText: 'Add more expertise',
                                labelText: 'Add more expertise',
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
                                },
                              ),
                            ],
                          ),
                        if (selectedIndustries.contains('Advertising & Marketing')) const SizedBox(height: 10),
                        if (selectedIndustries.contains('Advertising & Marketing'))
                          Column(
                            children: [
                              MultiSelectChipField<String?>(
                                items: markExpertiseItems,
                                initialValue: selectedMarkExpertise,
                                onTap: (List<String?> values) {
                                  ref.read(selectedMarkExpertiseProvider.notifier).state = values.whereType<String>().toList();
                                },
                                headerColor: Theme.of(context).unselectedWidgetColor,
                                title: Text(
                                  'Marketing Expertise',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                decoration: BoxDecoration(),
                                selectedChipColor: Theme.of(context).colorScheme.secondary,
                                selectedTextStyle: TextStyle(color: Colors.white),
                                textStyle: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
                              ),
                              CustomTextFormField(
                                controller: editMarkExpertise,
                                hintText: 'Add more expertise',
                                labelText: 'Add more expertise',
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
                        SizedBox(height: 10),
                        MultiSelectChipField<String?>(
                          items: servicesItems,
                          initialValue: selectedServices,
                          title: Text(
                            'Services',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          headerColor: Theme.of(context).unselectedWidgetColor,
                          onTap: (List<String?> values) {
                            ref.read(selectedServicesProvider.notifier).state = values.whereType<String>().toList();
                          },
                          decoration: BoxDecoration(),
                          selectedChipColor: Theme.of(context).colorScheme.secondary,
                          selectedTextStyle: TextStyle(color: Colors.white),
                          textStyle: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
                        ),
                        CustomTextFormField(
                          hintText: "Enter your Location",
                          controller: locationCont,
                          textInputAction: TextInputAction.done,
                          labelText: 'Location',
                          border: const OutlineInputBorder(),
                          suffixIcon: Icon(Icons.edit),
                          validator: (value) {
                            if (!ValidationUtils.isNotEmpty(value!)) {
                              return 'Location is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          hintText: "Tell us something about yourself...",
                          controller: aboutCont,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.multiline,
                          labelText: 'About Me',
                          border: const OutlineInputBorder(),
                          maxLines: 5,
                          suffixIcon: Icon(Icons.edit),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'About cannot be empty';
                            } else if (value.length < 50) {
                              return 'About me must be at least 50 characters long';
                            } else if (value.length > 500) {
                              return 'About me must not be more than 500 characters long';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
      UserProfileProvider.uploadBannerProvider(
        UploadBannerParams(
          fileName: "placeholderBanner.jpg",
          fileType: lookupMimeType(filePath),
          userId: userDetails!['user_id'],
          userType: userDetails['type'],
        ),
      ).future,
    );
    ref.read(UserProfileProvider.uploadToAWSProvider(
      UploadToAWSParams(
        url: uploadedBanner.url,
        fileName: "placeholderBanner.jpg",
        file: file,
        fileType: lookupMimeType(filePath),
      ),
    ));
    return uploadedBanner.key;
  }

  Future<String?> sendDefaultAvatar({WidgetRef? ref, Map<String, String>? userDetails}) async {
    final gender = ref!.watch(selectedGenderProvider).selectedGender;
    String assetPath;

    String _getRandomAsset(List<String> assets, Random random) {
      int index = random.nextInt(assets.length);
      return assets[index];
    }

    String _getAssetByGender(String? gender) {
      Random random = Random();
      if (gender == null) {
        return Assets.PERSON;
      } else if (gender == "Male") {
        return _getRandomAsset(Assets.MALE_ASSETS, random);
      } else if (gender == "Female") {
        return _getRandomAsset(Assets.FEMALE_ASSETS, random);
      } else {
        return Assets.OTHERS;
      }
    }

    if (gender == null) {
      assetPath = _getAssetByGender(gender);
    } else {
      assetPath = _getAssetByGender(gender);
    }

    final byteData = await rootBundle.load(assetPath);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/placeholderAvatar.png');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    // Get the file path
    final filePath = file.path;

    var uploadedAvatar = await ref.read(
      UserProfileProvider.uploadAvatarProvider(
        UploadAvatarParams(
          fileName: "placeholderAvatar.png",
          fileType: lookupMimeType(filePath),
          userId: userDetails!['user_id'],
          userType: userDetails['type'],
        ),
      ).future,
    );
    ref.read(UserProfileProvider.uploadToAWSProvider(
      UploadToAWSParams(
        url: uploadedAvatar.url,
        fileName: "placeholderAvatar.png",
        file: file,
        fileType: lookupMimeType(filePath),
      ),
    ));
    return uploadedAvatar.key;
  }
}
