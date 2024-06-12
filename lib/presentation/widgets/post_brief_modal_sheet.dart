import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/industry_data.dart';
import '../../common/screen_size.dart';

Future<void> customPostBriefModalSheet(
  BuildContext context, {
  TextEditingController? postTextCont,
  File? selectedImage,
  String? postingAs,
  // Function()? influencerOnTap,
  // Function()? technologyOnTap,
  Function()? photoOnTap,
  Function(String, String)? postOnTap,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.grey[300]!,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      bool isCategoryVisible = false;
      String? selectedCategory = "";
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          postTextCont?.clear();
          selectedImage?.delete();
        },
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: ScreenSize.height(context) * 0.94,
              child: Column(
                children: [
                  SizedBox(
                    height: isCategoryVisible == true ? ScreenSize.height(context) * 0.415 : ScreenSize.height(context) * 0.51,
                    child: SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                                postTextCont?.clear();
                                selectedImage?.delete();
                              },
                              icon: const Icon(
                                CupertinoIcons.clear,
                                color: Colors.grey,
                              ),
                              iconSize: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.person_crop_circle_fill,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF212121),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                                      child: Text(
                                        "Posting as a ${postingAs!}",
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: isCategoryVisible != true ? ScreenSize.height(context) * 0.4 : ScreenSize.height(context) * 0.3,
                              ),
                              child: TextField(
                                autofocus: true,
                                maxLines: null,
                                expands: true,
                                maxLength: 500,
                                controller: postTextCont,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Write your brief...",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
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
                  Visibility(
                    visible: isCategoryVisible,
                    child: SizedBox(
                      height: 100,
                      width: ScreenSize.width(context),
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
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: const Icon(CupertinoIcons.photo, size: 30),
                            onPressed: photoOnTap,
                            // () async {
                            //   final ImagePicker picker = ImagePicker();
                            //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            //   if (image != null) {
                            //     var uploadedThreadImage = await ref.read(uploadThreadImageProvider(
                            //       fileName: image.name,
                            //       fileType: AppUtility(context).getMediaType(image.path),
                            //       userId: userData['user_id'],
                            //       userType: userData['type'],
                            //     ).future);
                            //     ref.read(uploadToAWSProvider(
                            //       url: uploadedThreadImage.url,
                            //       fileName: image.name,
                            //       file: File(image.path),
                            //       fileType: AppUtility(context).getMediaType(image.path),
                            //     ).future);
                            //     ref.read(uploadedThreadImageKeyProvider.notifier).state = uploadedThreadImage.key;

                            //     ref.read(selectedPostImageProvider.notifier).state = File(image.path);
                            //   }
                            // },
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(CupertinoIcons.circle_grid_hex, size: 30),
                            onPressed: () {
                              setState(() {
                                isCategoryVisible = !isCategoryVisible;
                              });
                              // print(!isCategoryVisible);
                              // ref.read(isCategoryVisibleProvider.notifier).state = isCategoryVisible == false ? true : false;
                              // ref.invalidate(isCategoryVisibleProvider);
                            },
                          ),
                          const Spacer(),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xFF212121),
                            )),
                            onPressed: () {
                              if (postOnTap != null) postOnTap(postTextCont?.text ?? "", selectedCategory!);
                            },
                            // () async {
                            //   if (postTextCont.text.isNotEmpty) {
                            //     var status = await ref.watch(postBriefProvider(
                            //       userId: userData['user_id'],
                            //       uName: userData['user_name'],
                            //       type: userData['type'],
                            //       postText: postTextCont.text,
                            //       imgSrc: ref.read(uploadedThreadImageKeyProvider.notifier).state,
                            //       category: selectedCategory,
                            //     ).future);

                            //     if (status == true) {
                            //       postTextCont.clear();
                            //       context.pop();
                            //     }
                            //     ref.invalidate(getAllBriefsProvider);
                            //     ref.invalidate(getUserBriefsProvider);
                            //   }
                            // },
                            child: const Text(
                              'Post',
                              style: TextStyle(color: Colors.grey),
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
              radius: 20,
              backgroundColor: const Color(0xFF1B0C6B),
              child: selectedCategory == categoryName
                  ? const Icon(
                      CupertinoIcons.checkmark,
                      color: Colors.white,
                    )
                  : const SizedBox(),
            ),
          ),
          const SizedBox(height: 5), // Add some space between the CircleAvatar and the text
          SizedBox(
            width: 50, // Set the width to the same as CircleAvatar's diameter
            child: Text(
              categoryName,
              style: const TextStyle(color: Colors.black, fontSize: 10),
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
