import 'dart:io';
import 'dart:ui';

import 'package:briefsea/common/static_data/posting_for_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../common/app_utils/screen_size.dart';
import '../../common/static_data/industry_data.dart';

Future<void> customPostBriefModalSheet(
  BuildContext context, {
  TextEditingController? postTextCont,
  File? selectedImage,
  String? postingAs,
  // Function()? influencerOnTap,
  // Function()? technologyOnTap,
  required Function()? photoOnTap,
  required Function(String, String)? postOnTap,
  required Function(List<String?>)? onVisbileSelect,
  required final List<String>? selectedVisibleTo,
}) {
  final FocusNode textFieldFocusNode = FocusNode();

  return showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
    isScrollControlled: true,
    context: context,
    constraints: BoxConstraints.fromViewConstraints(ViewConstraints(minWidth: ScreenSize.width(context))),
    builder: (context) {
      bool isCategoryVisible = false;
      String? selectedCategory = "";

      WidgetsBinding.instance.addPostFrameCallback((_) {
        textFieldFocusNode.requestFocus();
        // FocusScope.of(context).requestFocus(textFieldFocusNode);
      });

      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          postTextCont?.clear();
          selectedImage?.delete();
          textFieldFocusNode.dispose();
        },
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: ScreenSize.height(context) * 0.94,
              width: ScreenSize.width(context),
              child: Stack(
                children: [
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Column(
                      children: [
                        SizedBox(
                          // height: isCategoryVisible == true ? ScreenSize.height(context) * 0.32 :
                          height: ScreenSize.height(context) * 0.38,
                          child: SingleChildScrollView(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    enableFeedback: true,
                                    onPressed: () {
                                      GoRouter.of(context).pop();
                                      postTextCont?.clear();
                                      selectedImage?.delete();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.clear,
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                                    iconSize: 30 * ScaleSize.textScaleFactor(context),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20 * ScaleSize.textScaleFactor(context),
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                        child: Text(
                                          postingAs == '' ? "" : postingAs?[0].toUpperCase() ?? '',
                                          style: Theme.of(context).textTheme.titleMedium,
                                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isCategoryVisible = !isCategoryVisible;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.secondary,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                                              child: Text(
                                                // "Posting as a ${postingAs!}",
                                                "Choose a category",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(color: Theme.of(context).colorScheme.onSecondary),
                                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        // maxHeight: isCategoryVisible != true ? ScreenSize.height(context) * 0.37 : ScreenSize.height(context) * 0.29,
                                        ),
                                    child: TextField(
                                      autofocus: true,
                                      maxLines: null,
                                      // expands: true,
                                      maxLength: 500,
                                      minLines: 1,
                                      controller: postTextCont,
                                      focusNode: textFieldFocusNode,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Post a brief, Describe in detail",
                                        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                              color: Theme.of(context).colorScheme.outline,
                                              fontSize: 14 * ScaleSize.textScaleFactor(context),
                                            ),
                                        // hintStyle: TextStyle(
                                        //   color: Colors.grey,
                                        //   fontSize: 14 * ScaleSize.textScaleFactor(context),
                                        // ),
                                      ),
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                if (selectedImage != null)
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Image.file(
                                      selectedImage,
                                      height: 250,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 0,
                    right: 0,
                    child: Container(
                      child: Column(
                        children: [
                          MultiSelectChipField<String?>(
                            items: postingAsData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList(),
                            initialValue: selectedVisibleTo ?? [],
                            onTap: onVisbileSelect,
                            // onTap: (List<String?> values) {
                            //   ref.read(selectedVisibleToProvider.notifier).state = values.whereType<String>().toList();
                            // },
                            showHeader: false,
                            decoration: BoxDecoration(),
                            textStyle: TextStyle(fontSize: 14 * ScaleSize.textScaleFactor(context)),
                            selectedChipColor: const Color(0xFF4C27FF),
                            selectedTextStyle: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                  visible: isCategoryVisible,
                                  child: SizedBox(
                                    height: 94 * ScaleSize.textScaleFactor(context),
                                    // width: ScreenSize.width(context),
                                    child: ListView(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(10),
                                      scrollDirection: Axis.horizontal,
                                      children: industries.map((industry) {
                                        return _CategorySelector(
                                          categoryName: industry['label']!,
                                          selectedCategory: selectedCategory!,
                                          onTap: (industryName) {
                                            setState(() {
                                              selectedCategory = industryName;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                // IconButton(
                                //   icon: const Icon(CupertinoIcons.photo, size: 30),
                                //   onPressed: photoOnTap,
                                //   // () async {
                                //   //   final ImagePicker picker = ImagePicker();
                                //   //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                //   //   if (image != null) {
                                //   //     var uploadedThreadImage = await ref.read(uploadThreadImageProvider(
                                //   //       fileName: image.name,
                                //   //       fileType: AppUtility(context).getMediaType(image.path),
                                //   //       userId: userData['user_id'],
                                //   //       userType: userData['type'],
                                //   //     ).future);
                                //   //     ref.read(uploadToAWSProvider(
                                //   //       url: uploadedThreadImage.url,
                                //   //       fileName: image.name,
                                //   //       file: File(image.path),
                                //   //       fileType: AppUtility(context).getMediaType(image.path),
                                //   //     ).future);
                                //   //     ref.read(uploadedThreadImageKeyProvider.notifier).state = uploadedThreadImage.key;

                                //   //     ref.read(selectedPostImageProvider.notifier).state = File(image.path);
                                //   //   }
                                //   // },
                                // ),
                                // const SizedBox(width: 10),
                                // IconButton(
                                //   icon: const Icon(CupertinoIcons.circle_grid_hex, size: 30),
                                //   onPressed: () {
                                //     setState(() {
                                //       // isCategoryVisible = !isCategoryVisible;
                                //       isPostingForVisible = !isPostingForVisible;
                                //     });
                                //   },
                                // ),
                                const Spacer(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    enableFeedback: true,
                                    backgroundColor: Theme.of(context).colorScheme.secondary,
                                  ),
                                  onPressed: () {
                                    if (postOnTap != null) postOnTap(postTextCont?.text ?? "", selectedCategory!);
                                  },
                                  child: Text(
                                    'Post',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                          color: Theme.of(context).colorScheme.onSecondary,
                                        ),
                                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector({
    required this.categoryName,
    required this.selectedCategory,
    required this.onTap,
  });
  final String categoryName;
  final String selectedCategory;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(categoryName);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              radius: 20 * ScaleSize.textScaleFactor(context),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: selectedCategory == categoryName
                  ? const Icon(
                      CupertinoIcons.checkmark,
                      color: Colors.white,
                    )
                  : Text(
                      categoryName[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                    ),
            ),
          ),
          SizedBox(height: 5 * ScaleSize.textScaleFactor(context)), // Add some space between the CircleAvatar and the text
          SizedBox(
            width: 70 * ScaleSize.textScaleFactor(context), // Set the width to the same as CircleAvatar's diameter
            child: Text(
              categoryName,
              style: const TextStyle(color: Colors.black, fontSize: 10),
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
              textAlign: TextAlign.center,
              maxLines: 2, // Allow the text to wrap to two lines
              overflow: TextOverflow.ellipsis, // Show ellipsis if text overflows
            ),
          ),
        ],
      ),
    );
  }
}
