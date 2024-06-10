import 'dart:io';

import 'package:briefsea/presentation/providers/breifs_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/app_utility.dart';
import '../../common/screen_size.dart';
import '../providers/auth_provider.dart';
import '../providers/user_profile_provider.dart';
import '../state_providers/image_picker_provider.dart';

class PostBriefModalSheet extends StatelessWidget {
  PostBriefModalSheet({super.key});

  final TextEditingController postTextCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.grey[300]!,
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Consumer(builder: (context, ref, child) {
              final selectedImage = ref.watch(selectedPostImageProvider);
              final userData = ref.watch(userDetailsProvider);
              return SizedBox(
                height: ScreenSize.height(context) * 0.95,
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              context.pop();
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
                                size: 30,
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
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                                    child: Text(
                                      "Posting as Freelancer",
                                      style: TextStyle(color: Colors.white),
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
                              maxHeight: MediaQuery.of(context).size.height * 0.4,
                            ),
                            child: TextField(
                              autofocus: true,
                              maxLines: null,
                              expands: true,
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
                            child: selectedImage != null
                                ? Image.file(
                                    selectedImage,
                                    height: 250,
                                    fit: BoxFit.fill,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: const Icon(CupertinoIcons.photo, size: 30),
                                  onPressed: () async {
                                    final ImagePicker picker = ImagePicker();
                                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      var uploadedThreadImage = await ref.read(uploadThreadImageProvider(
                                        fileName: image.name,
                                        fileType: AppUtility(context).getMediaType(image.path),
                                        userId: userData['user_id'],
                                        userType: userData['type'],
                                      ).future);
                                      ref.read(uploadToAWSProvider(
                                        url: uploadedThreadImage.url,
                                        fileName: image.name,
                                        file: File(image.path),
                                        fileType: AppUtility(context).getMediaType(image.path),
                                      ).future);
                                      ref.read(uploadedThreadImageKeyProvider.notifier).state = uploadedThreadImage.key;

                                      ref.read(selectedPostImageProvider.notifier).state = File(image.path);
                                    }
                                  },
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color(0xFF212121),
                                  )),
                                  onPressed: () async {
                                    if (postTextCont.text.isNotEmpty) {
                                      var status = await ref.watch(postBriefProvider(
                                        userId: userData['user_id'],
                                        uName: userData['user_name'],
                                        type: userData['type'],
                                        postText: postTextCont.text,
                                        imgSrc: ref.read(uploadedThreadImageKeyProvider.notifier).state,
                                        category: "Tech",
                                      ).future);

                                      if (status == true) {
                                        postTextCont.clear();
                                        context.pop();
                                      }
                                      ref.invalidate(getAllBriefsProvider);
                                      ref.invalidate(getUserBriefsProvider);
                                    }
                                  },
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
                  ),
                ),
              );
            });
          },
        );
      },
      child: Container(
        height: 50,
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Icon(
                CupertinoIcons.add_circled_solid,
                color: Colors.grey,
                size: 35,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Post a brief...",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
