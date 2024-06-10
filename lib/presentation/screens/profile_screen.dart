import 'dart:io';

import 'package:briefsea/common/app_utility.dart';
import 'package:briefsea/presentation/providers/user_profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/screen_size.dart';
import '../providers/auth_provider.dart';
import '../state_providers/image_picker_provider.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: bodyWidget(context, ref),
    );
  }

  final ImagePicker _picker = ImagePicker();

  bodyWidget(context, WidgetRef ref) {
    final selectedProfile = ref.watch(selectedProfileImageProvider);
    final selectedBanner = ref.watch(selectedBannerImageProvider);
    final userDetails = ref.watch(getUserProfileProvider);
    final userData = ref.watch(userDetailsProvider);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 70,
          color: const Color(0xFF4B26FD),
        ),
        Container(
          height: ScreenSize.height(context),
          width: ScreenSize.width(context),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.white,
          ),
          child: userDetails.when(
            data: (userDetails) {
              var avatarUrl = ref.watch(getImageProvider(src: userDetails.avatarSrc!).future);
              var bannerUrl = ref.watch(getImageProvider(src: userDetails.bannerSrc!).future);
              return Column(
                children: [
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                            width: ScreenSize.width(context),
                            height: ScreenSize.height(context) * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.pink[100]!,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: selectedBanner != null
                                ? Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                        ),
                                        child: Image(
                                          width: ScreenSize.width(context),
                                          image: FileImage(selectedBanner),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () async {
                                            final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                                            if (pickedFile != null) {
                                              var uploadedAvatar = await ref.read(uploadBannerProvider(
                                                fileName: pickedFile.name,
                                                fileType: AppUtility(context).getMediaType(pickedFile.path),
                                                userId: userDetails.userId,
                                                userType: userData['type'],
                                              ).future);
                                              ref.read(uploadToAWSProvider(
                                                url: uploadedAvatar.url,
                                                fileName: pickedFile.name,
                                                file: File(pickedFile.path),
                                                fileType: AppUtility(context).getMediaType(pickedFile.path),
                                              ));
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
                                          var uploadedAvatar = await ref.read(uploadBannerProvider(
                                            fileName: pickedFile.name,
                                            fileType: AppUtility(context).getMediaType(pickedFile.path),
                                            userId: userDetails.userId,
                                            userType: userData['type'],
                                          ).future);
                                          ref.read(uploadToAWSProvider(
                                            url: uploadedAvatar.url,
                                            fileName: pickedFile.name,
                                            file: File(pickedFile.path),
                                            fileType: AppUtility(context).getMediaType(pickedFile.path),
                                          ));
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
                                      userId: userDetails.userId,
                                      userType: userData['type'],
                                    ).future);
                                    ref.read(uploadToAWSProvider(
                                      url: uploadedAvatar.url,
                                      fileName: pickedFile.name,
                                      file: File(pickedFile.path),
                                      fileType: AppUtility(context).getMediaType(pickedFile.path),
                                    ));
                                    ref.read(selectedProfileImageProvider.notifier).state = File(pickedFile.path);
                                  }
                                },
                                child: selectedProfile != null
                                    ? const CircleAvatar(
                                        backgroundColor: Color(0xFF1B0C6B),
                                        // backgroundImage: FileImage(selectedProfile),
                                        radius: 70,
                                      )
                                    : FutureBuilder(
                                        future: avatarUrl,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError || !snapshot.hasData) {
                                            return const Icon(
                                              CupertinoIcons.camera_fill,
                                              color: Colors.white,
                                              size: 30,
                                            );
                                          } else {
                                            return CircleAvatar(
                                              backgroundColor: const Color(0xFF1B0C6B),
                                              backgroundImage: NetworkImage(snapshot.data!.url!),
                                              radius: 70,
                                            );
                                          }
                                        },
                                      ),
                              ),
                            ),
                          ),
                        ]),
                        Container(
                          width: ScreenSize.width(context),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text(
                                  userDetails.name!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textScaler: const TextScaler.linear(1.7),
                                ),
                                Text(
                                  userDetails.post!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textScaler: const TextScaler.linear(1),
                                ),
                                Text(
                                  userDetails.industry!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                  textScaler: const TextScaler.linear(1),
                                ),
                                Text(
                                  userDetails.worksAt!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textScaler: const TextScaler.linear(1.2),
                                ),
                                Text(
                                  "Posting as ${userData['type']![0].toUpperCase()}${userData['type']!.substring(1)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                  textScaler: const TextScaler.linear(1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) {
              return Center(child: Text('Error: $error'));
            },
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ],
    );
  }
}
