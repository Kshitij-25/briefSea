import 'dart:developer';

import 'package:briefsea/data/models/briefs_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../data/models/image_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/likes_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/briefs_state_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import '../../widgets/post_brief_modal_sheet.dart';
import 'feed_screen.dart';

class MyBriefsScreen extends ConsumerWidget {
  MyBriefsScreen({super.key, this.pageController});
  // AsyncValue<List<UserBriefsModel?>?> userBriefs;

  final PageController? pageController;
  final TextEditingController postEditController = TextEditingController();

  Future<BriefsModel?> _initializeImageProviders(WidgetRef ref, BriefsModel briefModel) async {
    try {
      if (briefModel.avatarSrc != null && briefModel.avatarSrc != '') {
        ImageModel avatarUrl = await ref.watch(getImageProvider(src: briefModel.avatarSrc!).future);
        if (avatarUrl.url != null && avatarUrl.url != '') {
          briefModel = briefModel.copyWith(avatarSrc: avatarUrl.url);
        }
      }

      if (briefModel.imgSrc != null && briefModel.imgSrc != '') {
        ImageModel postImage = await ref.watch(getImageProvider(src: briefModel.imgSrc!).future);
        if (postImage.url != null && postImage.url != '') {
          briefModel = briefModel.copyWith(imgSrc: postImage.url);
        }
      }

      return briefModel;
    } catch (e) {
      print('Error initializing image providers: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);
    final selectedFilter = ref.watch(selectedBriefsFilter);
    final selectedImage = ref.watch(selectedPostImageProvider);

    return ref.watch(getUserBriefsProvider).when(
          data: (briefs) {
            if (briefs == null || briefs.isEmpty) {
              return const Center(
                child: Text('All the briefs you’ve posted will be here'),
              );
            }
            List<BriefsModel?> filteredBriefs = briefs.where((brief) {
              if (selectedFilter == 'All') {
                return true;
              } else if (selectedFilter == 'Public') {
                return brief!.isVisible == true;
              } else if (selectedFilter == 'Private') {
                return brief!.isVisible == false;
              }
              return false;
            }).toList();
            return Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF4B26FD),
                        ),
                      ),
                      onPressed: () {
                        ref.read(selectedBriefsFilter.notifier).setFilter('All');
                        ref.invalidate(getUserBriefsProvider);
                      },
                      child: const Text(
                        'All',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFF4B26FD),
                      )),
                      onPressed: () {
                        ref.read(selectedBriefsFilter.notifier).setFilter('Public');
                        ref.invalidate(getUserBriefsProvider);
                      },
                      child: const Text(
                        'Public',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFF4B26FD),
                      )),
                      onPressed: () {
                        ref.read(selectedBriefsFilter.notifier).setFilter('Private');
                        ref.invalidate(getUserBriefsProvider);
                      },
                      child: const Text(
                        'Private',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: filteredBriefs.isEmpty && selectedFilter == "Private"
                      ? const Center(
                          child: Text('All the private briefs you’ve posted will be here'),
                        )
                      : filteredBriefs.isEmpty
                          ? const Center(
                              child: Text('All the public briefs you’ve posted will be here'),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredBriefs.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                  future: _initializeImageProviders(ref, filteredBriefs[index]!),
                                  builder: (context, snapshot) {
                                    return CustomBriefsCard(
                                      isUserTrue: filteredBriefs[index]!.userId == userDetails['user_id'] ? true : false,
                                      brief: filteredBriefs[index],
                                      postImage: snapshot.data?.imgSrc,
                                      avatarName: snapshot.data?.avatarSrc,
                                      onSelected: (value) async {
                                        if (value == 'edit') {
                                          postEditController.text = filteredBriefs[index]!.postText ?? '';
                                          customPostBriefModalSheet(
                                            context,
                                            selectedImage: selectedImage,
                                            postTextCont: postEditController,
                                            postingAs: filteredBriefs[index]?.name,
                                            photoOnTap: () async {
                                              // final ImagePicker picker = ImagePicker();
                                              // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                              // if (image != null) {
                                              //   var uploadedThreadImage = await ref.read(uploadThreadImageProvider(
                                              //     fileName: image.name,
                                              //     fileType: lookupMimeType(image.path),
                                              //     userId: userData['user_id'],
                                              //     userType: userData['type'],
                                              //   ).future);
                                              //   ref.read(uploadToAWSProvider(
                                              //     url: uploadedThreadImage.url,
                                              //     fileName: image.name,
                                              //     file: File(image.path),
                                              //     fileType: lookupMimeType(image.path),
                                              //   ).future);
                                              //   ref.read(uploadedThreadImageKeyProvider.notifier).state = uploadedThreadImage.key;

                                              //   ref.read(selectedPostImageProvider.notifier).state = File(image.path);
                                              // }
                                            },
                                            postOnTap: (postText, selectedCategory) async {
                                              if (postEditController.text.isNotEmpty) {
                                                if (selectedCategory != '') {
                                                  var status = await ref.watch(
                                                    editBriefProvider(
                                                      briefId: filteredBriefs[index]!.id!,
                                                      isVisible: filteredBriefs[index]!.isVisible!,
                                                      avatarSrc: filteredBriefs[index]!.avatarSrc!,
                                                      category: selectedCategory,
                                                      createdAt: filteredBriefs[index]!.createdAt!,
                                                      updatedAt: filteredBriefs[index]!.updatedAt!,
                                                      imgSrc: filteredBriefs[index]!.imgSrc!,
                                                      postText: postText,
                                                      userId: filteredBriefs[index]!.userId!,
                                                      uname: filteredBriefs[index]!.name!,
                                                      type: filteredBriefs[index]!.type!,
                                                      likesCount: filteredBriefs[index]!.likesCount!,
                                                      replyCount: filteredBriefs[index]!.replyCount!,
                                                      postedAt: filteredBriefs[index]!.postedAt!,
                                                    ).future,
                                                  );

                                                  if (status == true) {
                                                    postEditController.clear();
                                                    GoRouter.of(context).pop();
                                                  }
                                                  ref.invalidate(getAllBriefsProvider);
                                                  ref.invalidate(getUserBriefsProvider);
                                                } else {
                                                  AppUtility(context).error('Choose a category first.');
                                                }
                                              }
                                            },
                                          );
                                        } else if (value == "delete") {
                                          var isDeleted = await ref.watch(deleteBriefProvider(briefId: filteredBriefs[index]?.id).future);
                                          if (isDeleted == true) {
                                            ref.invalidate(getUserBriefsProvider);
                                          }
                                        } else if (value == "visible") {
                                          var isVisible = await ref.watch(editBriefProvider(
                                            briefId: filteredBriefs[index]!.id!,
                                            isVisible: !filteredBriefs[index]!.isVisible!,
                                            avatarSrc: filteredBriefs[index]!.avatarSrc!,
                                            category: filteredBriefs[index]!.category!,
                                            createdAt: filteredBriefs[index]!.createdAt!,
                                            updatedAt: filteredBriefs[index]!.updatedAt!,
                                            imgSrc: filteredBriefs[index]!.imgSrc!,
                                            postText: filteredBriefs[index]!.postText!,
                                            userId: filteredBriefs[index]!.userId!,
                                            uname: filteredBriefs[index]!.name!,
                                            type: filteredBriefs[index]!.type!,
                                            likesCount: filteredBriefs[index]!.likesCount!,
                                            replyCount: filteredBriefs[index]!.replyCount!,
                                            postedAt: filteredBriefs[index]!.postedAt!,
                                          ).future);
                                          if (isVisible == true) {
                                            ref.invalidate(getUserBriefsProvider);
                                          }
                                        }
                                      },
                                      onCommentTap: (brief) async {
                                        context.pushNamed(
                                          FeedScreen.routeName,
                                          extra: {'briefId': filteredBriefs[index]!.id},
                                        );
                                      },
                                      onLikeTap: (brief) async {
                                        try {
                                          if (!brief!.isPostLiked) {
                                            await ref.read(postLikeProvider(
                                              threadId: brief.id,
                                              type: userDetails['type'],
                                              uName: userDetails['user_name'],
                                              userId: userDetails['user_id'],
                                              replyId: null,
                                            ).future);
                                          } else {
                                            await ref.read(deleteLikeProvider(
                                              likeId: brief.postLikeId,
                                              threadId: brief.id,
                                            ).future);
                                          }
                                          ref.invalidate(getUserBriefsProvider);
                                        } catch (e) {
                                          log(e.toString());
                                        }
                                      },
                                      onShareTap: (brief) {},
                                      onTap: () async {
                                        context.pushNamed(
                                          FeedScreen.routeName,
                                          extra: {'briefId': filteredBriefs[index]!.id},
                                        );
                                      },
                                    );
                                  },
                                );
                              },
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
        );
  }
}
