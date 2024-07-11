import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../data/core/api_constants.dart';
import '../../../data/models/briefs_model.dart';
import '../../../data/models/image_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/likes_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import '../../widgets/post_brief_modal_sheet.dart';
import 'feed_screen.dart';

class AllBriefsScreen extends ConsumerWidget {
  AllBriefsScreen({super.key, this.pageController});

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
    final selectedImage = ref.watch(selectedPostImageProvider);
    return ref.watch(getAllBriefsProvider).when(
          data: (briefs) {
            if (briefs == null || briefs.isEmpty) {
              return const Center(
                child: Text('No Briefs Found'),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: briefs.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: _initializeImageProviders(ref, briefs[index]!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return CustomBriefsCard(
                        isUserTrue: briefs[index]!.userId != userDetails['user_id'] ? false : true,
                        brief: briefs[index],
                        postImage: snapshot.data?.imgSrc,
                        avatarName: snapshot.data?.avatarSrc,
                        onSelected: (value) async {
                          if (value == 'edit') {
                            postEditController.text = briefs[index]!.postText ?? '';
                            customPostBriefModalSheet(
                              context,
                              selectedImage: selectedImage,
                              postTextCont: postEditController,
                              postingAs: briefs[index]?.name,
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
                                        briefId: briefs[index]!.id!,
                                        isVisible: briefs[index]!.isVisible!,
                                        avatarSrc: briefs[index]!.avatarSrc!,
                                        category: selectedCategory,
                                        createdAt: briefs[index]!.createdAt!,
                                        updatedAt: briefs[index]!.updatedAt!,
                                        imgSrc: briefs[index]!.imgSrc!,
                                        postText: postText,
                                        userId: briefs[index]!.userId!,
                                        uname: briefs[index]!.name!,
                                        type: briefs[index]!.type!,
                                        likesCount: briefs[index]!.likesCount!,
                                        replyCount: briefs[index]!.replyCount!,
                                        postedAt: briefs[index]!.postedAt!,
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
                            var isDeleted = await ref.watch(deleteBriefProvider(briefId: briefs[index]?.id).future);
                            if (isDeleted == true) {
                              ref.invalidate(getAllBriefsProvider);
                            }
                          } else if (value == "visible") {
                            var isVisible = await ref.watch(editBriefProvider(
                              briefId: briefs[index]!.id!,
                              isVisible: !briefs[index]!.isVisible!,
                              avatarSrc: briefs[index]!.avatarSrc!,
                              category: briefs[index]!.category!,
                              createdAt: briefs[index]!.createdAt!,
                              updatedAt: briefs[index]!.updatedAt!,
                              imgSrc: briefs[index]!.imgSrc!,
                              postText: briefs[index]!.postText!,
                              userId: briefs[index]!.userId!,
                              uname: briefs[index]!.name!,
                              type: briefs[index]!.type!,
                              likesCount: briefs[index]!.likesCount!,
                              replyCount: briefs[index]!.replyCount!,
                              postedAt: briefs[index]!.postedAt!,
                            ).future);
                            if (isVisible == true) {
                              ref.invalidate(getUserBriefsProvider);
                            }
                          }
                        },
                        onCommentTap: (brief) async {
                          context.pushNamed(
                            FeedScreen.routeName,
                            extra: {'briefId': briefs[index]!.id},
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
                              if (brief.userId != userDetails['user_id']) {
                                await ref.read(postNewNotificationProvider(
                                  requestBody: {
                                    "type": 'brief liked',
                                    "sender_id": userDetails['user_id'],
                                    "sender_name": userDetails['user_name'],
                                    "receiver_id": brief.userId,
                                    "notification": "${userDetails['user_name']} liked your brief.",
                                    "thread_id": brief.id,
                                  },
                                ).future);
                              }
                            } else {
                              await ref.read(deleteLikeProvider(
                                likeId: brief.postLikeId,
                                threadId: brief.id,
                              ).future);
                            }
                            ref.invalidate(getAllBriefsProvider);
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        onShareTap: (brief) {
                          shareBrief(brief!);
                        },
                        onTap: () async {
                          context.pushNamed(
                            FeedScreen.routeName,
                            extra: {'briefId': briefs[index]!.id},
                          );
                        },
                      );
                    }
                  },
                );
              },
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

  void shareBrief(BriefsModel brief) {
    Share.share(
      'Check out this brief by: ${brief.name![0].toUpperCase()}${brief.name!.substring(1)} at\n ${ApiConstants.shareBrief}/${brief.id}',
      subject: 'Check out this brief!',
    );
  }
}
