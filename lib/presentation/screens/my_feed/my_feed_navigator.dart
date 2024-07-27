import 'dart:io';

import 'package:briefsea/common/app_utils/app_utility.dart';
import 'package:briefsea/common/others/strings.dart';
import 'package:briefsea/presentation/params/user_profile_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../params/briefs_params.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/briefs_state_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../widgets/custom_tab_bar.dart';
import '../../widgets/post_brief_modal_sheet.dart';
import 'all_briefs_screen.dart';
import 'my_briefs_screen.dart';

class MyFeedNavigator extends ConsumerWidget {
  const MyFeedNavigator({super.key, this.homePageController});

  final PageController? homePageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(briefsTabIndexProvider);
    final pageController = PageController(initialPage: currentIndex);

    final selectedImage = ref.watch(selectedPostImageProvider);
    final userData = ref.watch(userDetailsProvider);

    final selectedVisibleTo = ref.watch(selectedVisibleToProvider.notifier).state;

    final TextEditingController postTextCont = TextEditingController();

    void onPageChanged(int index) {
      ref.read(briefsTabIndexProvider.notifier).state = index;
    }

    void onTabTapped(int index) {
      pageController.jumpToPage(index);
      ref.read(briefsTabIndexProvider.notifier).state = index;
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 70,
          color: Theme.of(context).colorScheme.secondary,
        ),
        Container(
          height: ScreenSize.height(context),
          width: ScreenSize.width(context),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child: Column(
            children: [
              Container(
                height: 155 * ScaleSize.textScaleFactor(context),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    stops: const [0.1, 0.9],
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context).colorScheme.surfaceContainer,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: CustomTabBar(
                        tab1Text: "All Briefs",
                        tab2Text: "My Briefs",
                        onSelectedIndex: (p0) {
                          onTabTapped(p0);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        customPostBriefModalSheet(
                          context,
                          selectedImage: selectedImage,
                          postTextCont: postTextCont,
                          postingAs: userData['firstName'] == "" ? userData['user_name'] : userData['firstName'],
                          onVisbileSelect: (List<String?> values) {
                            ref.read(selectedVisibleToProvider.notifier).state = values.whereType<String>().toList();
                          },
                          selectedVisibleTo: selectedVisibleTo,
                          photoOnTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              var uploadedThreadImage = await ref.read(BriefsProviders.uploadThreadImageProvider(
                                UploadThreadImageParams(
                                  fileName: image.name,
                                  fileType: lookupMimeType(image.path)!,
                                  userId: userData['user_id']!,
                                  userType: userData['type']!,
                                ),
                              ).future);
                              ref.read(UserProfileProvider.uploadToAWSProvider(
                                UploadToAWSParams(
                                  url: uploadedThreadImage.url,
                                  fileName: image.name,
                                  file: File(image.path),
                                  fileType: lookupMimeType(image.path),
                                ),
                              ).future);
                              ref.read(uploadedThreadImageKeyProvider.notifier).state = uploadedThreadImage.key;

                              ref.read(selectedPostImageProvider.notifier).state = File(image.path);
                            }
                          },
                          postOnTap: (postText, selectedCategory) async {
                            if (postTextCont.text.isNotEmpty) {
                              if (selectedCategory != '') {
                                var status = await ref.watch(
                                  BriefsProviders.postBriefProvider(
                                    PostBriefParams(
                                      userId: userData['user_id'],
                                      uName: userData['user_name'],
                                      type: userData['type'],
                                      postText: postText,
                                      imgSrc: ref.read(uploadedThreadImageKeyProvider.notifier).state,
                                      category: selectedCategory,
                                      isVisibleTo: selectedVisibleTo,
                                    ),
                                  ).future,
                                );
                                if (status == true) {
                                  postTextCont.clear();
                                  GoRouter.of(context).pop();
                                }
                                ref.invalidate(BriefsProviders.getAllBriefsProvider);
                                ref.invalidate(BriefsProviders.getUserBriefsProvider);
                              } else {
                                AppUtility(context).error('Choose a category first.');
                              }
                            }
                          },
                        );
                      },
                      child: Container(
                        height: 50 * ScaleSize.textScaleFactor(context),
                        width: ScreenSize.width(context),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              // color: Color(0xFF030305),
                              color: Colors.grey[300]!,
                              blurRadius: 5,
                              offset: const Offset(2.50, 2.50),
                            ),
                            BoxShadow(
                              // color: Color(0xFF141122),
                              color: Colors.grey[300]!,
                              blurRadius: 5,
                              offset: const Offset(-2.50, -2.50),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Icon(
                                CupertinoIcons.add_circled_solid,
                                color: Colors.grey,
                                size: 35 * ScaleSize.textScaleFactor(context),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  Strings.postABrief,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    AllBriefsScreen(pageController: homePageController),
                    MyBriefsScreen(pageController: homePageController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
