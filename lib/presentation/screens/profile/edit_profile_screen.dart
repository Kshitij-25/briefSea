import 'dart:developer';

import 'package:briefsea/presentation/params/user_profile_params.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../common/app_utils/debouncer.dart';
import '../../../common/app_utils/screen_size.dart';
import '../../../common/app_utils/shared_prefs_helper.dart';
import '../../../common/app_utils/validation_utils.dart';
import '../../../common/static_data/expertise_data.dart';
import '../../../common/static_data/industry_data.dart';
import '../../../data/models/user_profile_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../state_providers/verify_profile_industry_provider.dart';
import '../../widgets/custom_text_form_field.dart';
import 'edit_profile_widgets/avatar_widget.dart';
import 'edit_profile_widgets/banner_widget.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  EditProfileScreen({super.key, required this.userProfileModel});

  static const routeName = '/editProfileScreen';

  final UserProfileModel userProfileModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController editNameCont = TextEditingController();
  final TextEditingController editPostingAsCont = TextEditingController();
  final TextEditingController editUserNameCont = TextEditingController();
  final TextEditingController editLinkedInCont = TextEditingController();
  final TextEditingController editPortfolioCont = TextEditingController();
  final TextEditingController editExperienceCont = TextEditingController();
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

  late String initialName;
  late String initialPostingAs;
  late String initialUserName;
  late String initialLinkedIn;
  late String initialPortfolio;
  late String initialExperience;
  late String initialCountryCode;
  late String initialPhoneNumber;
  late String initialCompany;
  late String initialJobTitle;
  late String initialLocation;
  late String initialAboutMe;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final devExpertiseItems = techExpertiseData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
        final markExpertiseItems = marketingExpertiseData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();

        ref.read(selectedIndustriesProvider.notifier).state = widget.userProfileModel.industry ?? [];
        ref.read(selectedDevExpertiseProvider.notifier).state = widget.userProfileModel.devExpertise ?? [];
        ref.read(selectedMarkExpertiseProvider.notifier).state = widget.userProfileModel.markExpertise ?? [];
        ref.read(devExpertiseItemsProvider.notifier).state = devExpertiseItems;
        ref.read(markExpertiseItemsProvider.notifier).state = markExpertiseItems;

        initialName = widget.userProfileModel.name ?? '';
        initialPostingAs = widget.userProfileModel.postingAs ?? '';
        initialUserName = widget.userProfileModel.userName ?? '';
        initialLinkedIn = widget.userProfileModel.linkedinLink ?? '';
        initialPortfolio = widget.userProfileModel.portfolioLink ?? '';
        initialExperience = widget.userProfileModel.expDuration ?? '';
        initialCountryCode = widget.userProfileModel.countryCode.toString();
        initialPhoneNumber = widget.userProfileModel.contact.toString();
        initialCompany = widget.userProfileModel.worksAt ?? '';
        initialJobTitle = widget.userProfileModel.post ?? '';
        initialLocation = widget.userProfileModel.location ?? '';
        initialAboutMe = widget.userProfileModel.aboutMe ?? '';

        editNameCont.text = initialName;
        editPostingAsCont.text = initialPostingAs;
        editUserNameCont.text = initialUserName;
        editLinkedInCont.text = initialLinkedIn;
        editPortfolioCont.text = initialPortfolio;
        editExperienceCont.text = initialExperience;
        editCountryCodeCont.text = initialCountryCode;
        editPhoneNumberCont.text = initialPhoneNumber;
        editCompanyCont.text = initialCompany;
        editJobTitleCont.text = initialJobTitle;
        editLocationCont.text = initialLocation;
        editAboutCont.text = initialAboutMe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    editUserNameCont.addListener(() {
      _debouncer.run(() async {
        if (_formKey.currentState!.validate()) {
          if (editUserNameCont.text.isNotEmpty) {
            var doesUsernameExist = await ref.read(UserProfileProvider.checkUserNameProvider(editUserNameCont.text).future);

            if (!doesUsernameExist) {
              AppUtility(context).error("Username already exists.");
            }
          }
        }
      });
    });

    bool _hasChanges() {
      return editNameCont.text != initialName ||
          editPostingAsCont.text != initialPostingAs ||
          editUserNameCont.text != initialUserName ||
          editLinkedInCont.text != initialLinkedIn ||
          editPortfolioCont.text != initialPortfolio ||
          editExperienceCont.text != initialExperience ||
          editCountryCodeCont.text != initialCountryCode ||
          editPhoneNumberCont.text != initialPhoneNumber ||
          editCompanyCont.text != initialCompany ||
          editJobTitleCont.text != initialJobTitle ||
          editLocationCont.text != initialLocation ||
          editAboutCont.text != initialAboutMe;
    }

    final selectedIndustries = ref.watch(selectedIndustriesProvider);
    final selectedDevExpertise = ref.watch(selectedDevExpertiseProvider);
    final selectedMarkExpertise = ref.watch(selectedMarkExpertiseProvider);
    final devExpertiseItemsFromProvider = ref.watch(devExpertiseItemsProvider);
    final markExpertiseItemsFromProvider = ref.watch(markExpertiseItemsProvider);
    final servicesItems = ref.watch(servicesItemsProvider.notifier).state;
    final userData = ref.watch(userDetailsProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        print(_hasChanges());
        if (_hasChanges()) {
          await showAdaptiveDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog.adaptive(
                content: const Text(
                  'Are you sure you want to discard these changes?',
                  style: TextStyle(color: Colors.black),
                ),
                title: const Text(
                  'Discard Changes?',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      GoRouter.of(context).pop();
                    },
                    child: Text(
                      'Discard',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          GoRouter.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          centerTitle: true,
          title: Text(
            "Edit Profile",
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
                  var selectedIndustry = ref.watch(selectedIndustriesProvider.notifier).state;
                  var selectedDevExpertise = ref.watch(selectedDevExpertiseProvider.notifier).state;
                  var selectedMarkExpertise = ref.watch(selectedMarkExpertiseProvider.notifier).state;
                  var selectedServices = ref.watch(selectedServicesProvider.notifier).state;
                  var selectedGender = ref.watch(selectedGenderProvider).selectedGender;
                  if (uploadedBannerKey == '' || uploadedBannerKey == null) {
                    uploadedBannerKey = widget.userProfileModel.bannerSrc;
                  }
                  if (uploadedAvatarKey == '' || uploadedAvatarKey == null) {
                    uploadedAvatarKey = widget.userProfileModel.avatarSrc;
                  }
                  if (selectedIndustry.isEmpty) {
                    selectedIndustry = widget.userProfileModel.industry!.toList();
                  }
                  if (selectedDevExpertise.isEmpty) {
                    selectedDevExpertise = widget.userProfileModel.devExpertise?.toList() ?? [];
                  }
                  if (selectedMarkExpertise.isEmpty) {
                    selectedMarkExpertise = widget.userProfileModel.markExpertise?.toList() ?? [];
                  }
                  if (selectedServices.isEmpty) {
                    selectedServices = widget.userProfileModel.services?.toList() ?? [];
                  }

                  var fullProfileData = {
                    'isVerified': widget.userProfileModel.isVerified,
                    'user_id': widget.userProfileModel.userId,
                    'name': editUserNameCont.text.trim(),
                    'postingAs': userData['type'],
                    'industry': selectedIndustry,
                    'devExpertise': selectedDevExpertise,
                    'markExpertise': selectedMarkExpertise,
                    'clients': widget.userProfileModel.clients,
                    'services': selectedServices,
                    'testimonials': widget.userProfileModel.testimonials,
                    'viewAccess': widget.userProfileModel.viewAccess,
                    'userName': editUserNameCont.text.trim(),
                    'countryCode': int.tryParse(editCountryCodeCont.text.trim()),
                    'contact': int.tryParse(editPhoneNumberCont.text.trim()),
                    'gender': selectedGender,
                    'post': widget.userProfileModel.post,
                    'worksAt': widget.userProfileModel.worksAt,
                    'location': editLocationCont.text.trim(),
                    'aboutMe': editAboutCont.text.trim(),
                    'avatarSrc': uploadedAvatarKey ?? '',
                    'bannerSrc': uploadedBannerKey ?? '',
                    'createdAt': widget.userProfileModel.createdAt,
                    'updatedAt': widget.userProfileModel.updatedAt,
                    'experience': widget.userProfileModel.experience,
                    'linkedinLink': editLinkedInCont.text.trim(),
                    'portfolioLink': editPortfolioCont.text.trim(),
                    'expDuration': editExperienceCont.text.trim(),
                  };

                  var profileEdited = await ref.read(
                    UserProfileProvider.editProfileProvider(
                      EditProfileParams(
                        userId: userData['user_id']!,
                        fullProfileData: fullProfileData,
                      ),
                    ).future,
                  );
                  if (profileEdited.acknowledged == true) {
                    ref.read(userAvatarNotifierProvider.notifier).loadUserAvatar();
                    ref.invalidate(UserProfileProvider.getUserProfileProvider);
                    AppUtility(context).message('Profile updated successfully');
                    GoRouter.of(context).pop();
                  }
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
                          userDetails: userData,
                          userProfileData: widget.userProfileModel,
                        ),
                        AvatarWidget(
                          userDetails: userData,
                          userProfileData: widget.userProfileModel,
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
                            controller: editNameCont,
                            hintColor: Colors.black,
                            labelText: 'Name',
                            border: const OutlineInputBorder(),
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            readOnly: true,
                            controller: editPostingAsCont,
                            hintColor: Colors.black,
                            labelText: 'Posting as',
                            border: const OutlineInputBorder(),
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            controller: editUserNameCont,
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
                            controller: editLinkedInCont,
                            textInputAction: TextInputAction.next,
                            hintText: "Enter your LinkedIn Profile Url (Optional)",
                            labelText: 'LinkedIn Url (Optional)',
                            border: const OutlineInputBorder(),
                            suffixIcon: Icon(Icons.edit),
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            controller: editPortfolioCont,
                            textInputAction: TextInputAction.next,
                            hintText: "Enter your Portfolio Url (Optional)",
                            labelText: 'Portfolio Url (Optional)',
                            border: const OutlineInputBorder(),
                            suffixIcon: Icon(Icons.edit),
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            controller: editExperienceCont,
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
                            value: ref.watch(selectedGenderProvider).selectedGender ?? widget.userProfileModel.gender,
                            onChanged: (String? newValue) async {
                              log("NEW VALUE=====> $newValue");

                              ref.read(selectedGenderProvider).setGender(newValue!);

                              await SharedPreferencesHelper.saveString('userGender', newValue);
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
                                  border: const OutlineInputBorder(),
                                  controller: editCountryCodeCont,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  labelText: 'Country',
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
                                  controller: editPhoneNumberCont,
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
                          SizedBox(height: 10),
                          MultiSelectChipField<String?>(
                            title: Text(
                              'Industry',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            items: industries.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList(),
                            initialValue: selectedIndustries,
                            onTap: (List<String?> values) {
                              ref.read(selectedIndustriesProvider.notifier).state = values.whereType<String>().toList();
                            },
                            headerColor: Theme.of(context).unselectedWidgetColor,
                            decoration: BoxDecoration(),
                            selectedChipColor: Theme.of(context).colorScheme.secondary,
                            selectedTextStyle: TextStyle(color: Colors.white),
                            textStyle: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
                          ),
                          if (selectedIndustries.contains('Development & Product'))
                            Column(
                              children: [
                                MultiSelectChipField<String?>(
                                  title: Text(
                                    'Developer Expertise',
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                  items: devExpertiseItemsFromProvider,
                                  headerColor: Theme.of(context).unselectedWidgetColor,
                                  initialValue: selectedDevExpertise,
                                  onTap: (List<String?> values) {
                                    ref.read(selectedDevExpertiseProvider.notifier).state = values.whereType<String>().toList();
                                  },
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
                                      final updatedDevExpertiseItems = List<MultiSelectItem<String?>>.from(devExpertiseItemsFromProvider)
                                        ..add(MultiSelectItem<String?>(newItem, newItem));
                                      ref.read(devExpertiseItemsProvider.notifier).state = updatedDevExpertiseItems;
                                      ref.read(selectedDevExpertiseProvider.notifier).state.add(newItem);
                                      editDevExpertise.clear();
                                    }
                                  },
                                ),
                              ],
                            ),
                          if (selectedIndustries.contains('Advertising & Marketing')) SizedBox(height: 10),
                          if (selectedIndustries.contains('Advertising & Marketing'))
                            Column(
                              children: [
                                MultiSelectChipField<String?>(
                                  title: Text(
                                    'Marketing Expertise',
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                  textStyle: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
                                  items: markExpertiseItemsFromProvider,
                                  initialValue: selectedMarkExpertise,
                                  headerColor: Theme.of(context).unselectedWidgetColor,
                                  onTap: (List<String?> values) {
                                    ref.read(selectedMarkExpertiseProvider.notifier).state = values.whereType<String>().toList();
                                  },
                                  decoration: BoxDecoration(),
                                  selectedChipColor: Theme.of(context).colorScheme.secondary,
                                  selectedTextStyle: TextStyle(color: Colors.white),
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
                                      final updatedMarkExpertiseItems = List<MultiSelectItem<String?>>.from(markExpertiseItemsFromProvider)
                                        ..add(MultiSelectItem<String?>(newItem, newItem));
                                      ref.read(markExpertiseItemsProvider.notifier).state = updatedMarkExpertiseItems;
                                      ref.read(selectedMarkExpertiseProvider.notifier).state.add(newItem);
                                      editMarkExpertise.clear();
                                    }
                                  },
                                )
                              ],
                            ),
                          SizedBox(height: 10),
                          MultiSelectChipField<String?>(
                            title: Text(
                              'Services',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            headerColor: Theme.of(context).unselectedWidgetColor,
                            items: servicesItems,
                            initialValue: widget.userProfileModel.services?.whereType<String>().toList() ?? [],
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
                            labelText: 'Location',
                            border: const OutlineInputBorder(),
                            suffixIcon: Icon(Icons.edit),
                            controller: editLocationCont,
                            textInputAction: TextInputAction.done,
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
                            labelText: 'About Me',
                            border: const OutlineInputBorder(),
                            suffixIcon: Icon(Icons.edit),
                            controller: editAboutCont,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
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
      ),
    );
  }
}
