import 'dart:developer';

import 'package:briefsea/data/models/briefs_result.dart';
import 'package:briefsea/presentation/params/likes_params.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../common/app_utils/screen_size.dart';
import '../../../data/core/app_error.dart';
import '../../params/briefs_params.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/likes_provider.dart';
import '../../state_providers/briefs_state_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import '../../widgets/post_brief_modal_sheet.dart';
import 'feed_screen.dart';

class MyBriefsScreen extends ConsumerWidget {
  MyBriefsScreen({super.key});

  final TextEditingController postEditController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);
    final selectedFilter = ref.watch(selectedBriefsFilter);
    final selectedImage = ref.watch(selectedPostImageProvider);

    return ref.watch(BriefsProviders.getUserBriefsProvider).when(
          data: (briefs) {
            if (briefs == null || briefs.isEmpty) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-0.73, 0.68),
                      end: Alignment(0.73, -0.68),
                      colors: [Color(0xFF4A26FE), Color(0xFF222CFF)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'All the briefs you’ve posted will be here',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.42,
                      ),
                      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                    ),
                  ),
                ),
              );
            }
            List<BriefsResult?> filteredBriefs = briefs.where((brief) {
              if (selectedFilter == 'All') {
                return true;
              } else if (selectedFilter == 'Public') {
                return brief?.isVisible == true;
              } else if (selectedFilter == 'Private') {
                return brief?.isVisible == false;
              }
              return false;
            }).toList();
            return Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ButtonStyle(
                        enableFeedback: true,
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onPressed: () {
                        ref.read(selectedBriefsFilter.notifier).setFilter('All');
                        ref.invalidate(BriefsProviders.getUserBriefsProvider);
                      },
                      child: Text(
                        'All',
                        style: TextStyle(color: Colors.white),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ButtonStyle(
                          enableFeedback: true,
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondary,
                          )),
                      onPressed: () {
                        ref.read(selectedBriefsFilter.notifier).setFilter('Public');
                        ref.invalidate(BriefsProviders.getUserBriefsProvider);
                      },
                      child: Text(
                        'Public',
                        style: TextStyle(color: Colors.white),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ButtonStyle(
                          enableFeedback: true,
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondary,
                          )),
                      onPressed: () {
                        ref.read(selectedBriefsFilter.notifier).setFilter('Private');
                        ref.invalidate(BriefsProviders.getUserBriefsProvider);
                      },
                      child: Text(
                        'Private',
                        style: TextStyle(color: Colors.white),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: filteredBriefs.isEmpty && selectedFilter == "Private"
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(-0.73, 0.68),
                                end: Alignment(0.73, -0.68),
                                colors: [Color(0xFF4A26FE), Color(0xFF222CFF)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'All the private briefs you’ve posted will be here',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.42,
                                ),
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              ),
                            ),
                          ),
                        )
                      : filteredBriefs.isEmpty
                          ? Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(-0.73, 0.68),
                                    end: Alignment(0.73, -0.68),
                                    colors: [Color(0xFF4A26FE), Color(0xFF222CFF)],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'All the public briefs you’ve posted will be here',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.42,
                                    ),
                                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                  ),
                                ),
                              ),
                            )
                          : RefreshIndicator.adaptive(
                              onRefresh: () async {
                                ref.invalidate(BriefsProviders.getUserBriefsProvider);
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: filteredBriefs.length,
                                itemBuilder: (context, index) {
                                  return CustomBriefsCard(
                                    isUserTrue: filteredBriefs[index]!.userId == userDetails['user_id'] ? true : false,
                                    brief: filteredBriefs[index],
                                    // postImage: snapshot.data?.imgSrc,
                                    // avatarName: snapshot.data?.avatarSrc,
                                    onSelected: (value) async {
                                      if (value == 'edit') {
                                        postEditController.text = filteredBriefs[index]!.postText ?? '';
                                        List<String>? initialVisibleTo = filteredBriefs[index]!.isVisibleTo;
                                        customPostBriefModalSheet(
                                          context,
                                          selectedImage: selectedImage,
                                          postTextCont: postEditController,
                                          postingAs: filteredBriefs[index]?.name,
                                          onVisbileSelect: (List<String?> values) {
                                            // log(values.toString());
                                            if (!listEquals(values, initialVisibleTo)) {
                                              List<String>? updatedVisibleTo = List.from(filteredBriefs[index]!.isVisibleTo ?? []);
                                              updatedVisibleTo.clear();
                                              updatedVisibleTo.addAll(values.whereType<String>().toList());
                                              // Remove duplicates by converting to a Set and back to a List
                                              updatedVisibleTo = updatedVisibleTo.toSet().toList();
                                              log(updatedVisibleTo.toString());
                                              log(initialVisibleTo.toString());

                                              filteredBriefs[index] = filteredBriefs[index]!.copyWith(isVisibleTo: updatedVisibleTo);
                                            }
                                          },
                                          selectedVisibleTo: filteredBriefs[index]!.isVisibleTo ?? [],
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
                                                  BriefsProviders.editBriefProvider(
                                                    EditBriefParams(
                                                      briefId: filteredBriefs[index]!.id!,
                                                      isVisible: filteredBriefs[index]!.isVisible!,
                                                      userId: filteredBriefs[index]!.userId!,
                                                      uname: filteredBriefs[index]!.name!,
                                                      type: filteredBriefs[index]!.type!,
                                                      category: selectedCategory,
                                                      postText: postText.trim(),
                                                      imgSrc: filteredBriefs[index]!.imgSrc!,
                                                      avatarSrc: filteredBriefs[index]!.avatarSrc!,
                                                      createdAt: filteredBriefs[index]!.createdAt!,
                                                      updatedAt: filteredBriefs[index]!.updatedAt!,
                                                      likesCount: filteredBriefs[index]!.likesCount!,
                                                      replyCount: filteredBriefs[index]!.replyCount!,
                                                      postedAt: filteredBriefs[index]!.postedAt!,
                                                      isVisibleTo: filteredBriefs[index]!.isVisibleTo,
                                                    ),
                                                  ).future,
                                                );

                                                if (status == true) {
                                                  postEditController.clear();
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
                                      } else if (value == "delete") {
                                        await showAdaptiveDialog<bool>(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog.adaptive(
                                              content: const Text(
                                                'Deleting this brief will permanently remove it from the system. This action cannot be undone.',
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              title: const Text(
                                                'Are you sure you want to delete this brief?',
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    enableFeedback: true,
                                                  ),
                                                  onPressed: () {
                                                    context.pop(false);
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    enableFeedback: true,
                                                  ),
                                                  onPressed: () async {
                                                    var isDeleted =
                                                        await ref.watch(BriefsProviders.deleteBriefProvider(filteredBriefs[index]?.id).future);
                                                    if (isDeleted == true) {
                                                      ref.invalidate(BriefsProviders.getUserBriefsProvider);
                                                      context.pop();
                                                    }
                                                  },
                                                  child: Text(
                                                    'Delete',
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                          color: Colors.black,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else if (value == "visible") {
                                        var isVisible = await ref.watch(
                                          BriefsProviders.editBriefProvider(
                                            EditBriefParams(
                                              briefId: filteredBriefs[index]!.id!,
                                              isVisible: !filteredBriefs[index]!.isVisible!,
                                              userId: filteredBriefs[index]!.userId!,
                                              uname: filteredBriefs[index]!.name!,
                                              type: filteredBriefs[index]!.type!,
                                              category: filteredBriefs[index]!.category!,
                                              postText: filteredBriefs[index]!.postText!,
                                              imgSrc: filteredBriefs[index]!.imgSrc!,
                                              avatarSrc: filteredBriefs[index]!.avatarSrc!,
                                              createdAt: filteredBriefs[index]!.createdAt!,
                                              updatedAt: filteredBriefs[index]!.updatedAt!,
                                              likesCount: filteredBriefs[index]!.likesCount!,
                                              replyCount: filteredBriefs[index]!.replyCount!,
                                              postedAt: filteredBriefs[index]!.postedAt!,
                                              isVisibleTo: filteredBriefs[index]!.isVisibleTo,
                                            ),
                                          ).future,
                                        );
                                        if (isVisible == true) {
                                          ref.invalidate(BriefsProviders.getUserBriefsProvider);
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
                                        if (brief!.likeObj!.userId == null) {
                                          await ref.read(LikesProvider.postLikeProvider(
                                            PostLikeParams(
                                              threadId: brief.id,
                                              type: userDetails['type'],
                                              uName: userDetails['user_name'],
                                              userId: userDetails['user_id'],
                                              replyId: null,
                                            ),
                                          ).future);
                                        } else if (brief.likeObj!.userId != null) {
                                          await ref.read(LikesProvider.deleteLikeProvider(
                                            DeleteLikeParams(
                                              likeId: brief.likeObj!.id,
                                              threadId: brief.id,
                                            ),
                                          ).future);
                                        }
                                        ref.invalidate(BriefsProviders.getUserBriefsProvider);
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
                              ),
                            ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            if (error is AppError) {
              return Center(
                child: Text(
                  error.errorMessage.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                ),
              );
            }
            return Center(
              child: Text('ERROR : ${error.toString()}'),
            );
          },
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
