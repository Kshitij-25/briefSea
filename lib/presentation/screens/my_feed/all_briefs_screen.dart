import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../data/core/api_constants.dart';
import '../../../data/models/briefs_result.dart';
import '../../params/briefs_params.dart';
import '../../params/likes_params.dart';
import '../../params/notification_params.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/likes_provider.dart';
import '../../providers/notification_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import '../../widgets/post_brief_modal_sheet.dart';
import 'feed_screen.dart';

class AllBriefsScreen extends ConsumerStatefulWidget {
  AllBriefsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AllBriefsScreenState();
}

class AllBriefsScreenState extends ConsumerState<AllBriefsScreen> {
  final TextEditingController postEditController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  // static const pageSize = 10;
  static const pageSize = 5;

  final PagingController<int, BriefsResult?> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      log(pageKey.toString() + 'PAGEKEY');
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ref.read(BriefsProviders.getAllBriefsProvider(pageKey).future);
      final isLastPage = newItems!.briefResult!.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.briefResult!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems.briefResult!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void refresh() {
    _pagingController.refresh();
  }

  void toggleLike(BriefsResult? brief, int index, String? userId, String? likedId) {
    if (likedId == null) {
      //Like Brief

      setState(() {
        final data = brief?.likeObj?.copyWith(userId: userId);
        _pagingController.itemList![index] = brief?.copyWith(likeObj: data);
      });
    } else {
      //Delete Like Brief
      setState(() {
        final data = brief?.likeObj?.copyWith(userId: null);
        _pagingController.itemList![index] = brief?.copyWith(likeObj: data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(userDetailsProvider);
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        ref.invalidate(BriefsProviders.getAllBriefsProvider);
        _pagingController.refresh();

        _pagingController.refresh();
      },
      child: PagedListView<int, BriefsResult?>(
        scrollController: scrollController,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<BriefsResult?>(
          itemBuilder: (context, brief, index) {
            if (brief == null) {
              return Container();
            }
            return CustomBriefsCard(
              isUserTrue: brief.userId != userDetails['user_id'] ? false : true,
              brief: brief,
              // postImage: snapshot.data?.imgSrc,
              // avatarName: snapshot.data?.avatarSrc,
              onSelected: (value) async {
                if (value == 'edit') {
                  postEditController.text = brief?.postText ?? '';
                  List<String>? initialVisibleTo = brief?.isVisibleTo;
                  await customPostBriefModalSheet(
                    context,
                    selectedImage: ref.watch(selectedPostImageProvider),
                    postTextCont: postEditController,
                    postingAs: brief?.name,
                    onVisbileSelect: (List<String?> values) {
                      // log(values.toString());
                      if (!listEquals(values, initialVisibleTo)) {
                        List<String>? updatedVisibleTo = List.from(brief?.isVisibleTo ?? []);
                        updatedVisibleTo.clear();
                        updatedVisibleTo.addAll(values.whereType<String>().toList());
                        // Remove duplicates by converting to a Set and back to a List
                        updatedVisibleTo = updatedVisibleTo.toSet().toList();
                        log(updatedVisibleTo.toString());
                        log(initialVisibleTo.toString());

                        if (brief != null) {
                          final updatedBrief = brief?.copyWith(isVisibleTo: updatedVisibleTo);
                          brief = updatedBrief;
                        }
                      }
                    },
                    selectedVisibleTo: brief?.isVisibleTo ?? [],
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
                                briefId: brief!.id!,
                                isVisible: brief!.isVisible!,
                                userId: brief!.userId!,
                                uname: brief!.name!,
                                type: brief!.type!,
                                category: selectedCategory,
                                postText: postText.trim(),
                                imgSrc: brief!.imgSrc!,
                                avatarSrc: brief!.avatarSrc!,
                                createdAt: brief!.createdAt!,
                                updatedAt: brief!.updatedAt!,
                                likesCount: brief!.likesCount!,
                                replyCount: brief!.replyCount!,
                                postedAt: brief!.postedAt!,
                                isVisibleTo: brief!.isVisibleTo,
                              ),
                            ).future,
                          );

                          if (status == true) {
                            postEditController.clear();
                            GoRouter.of(context).pop();
                          }
                          ref.invalidate(BriefsProviders.getAllBriefsProvider);
                          ref.invalidate(BriefsProviders.getUserBriefsProvider);
                          _pagingController.refresh();
                        } else {
                          AppUtility(context).error('Choose a category first.');
                        }
                      }
                    },
                  );
                  _pagingController.refresh();
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
                              var isDeleted = await ref.watch(BriefsProviders.deleteBriefProvider(brief?.id).future);
                              if (isDeleted == true) {
                                ref.invalidate(BriefsProviders.getAllBriefsProvider);
                                _pagingController.refresh();
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
                        briefId: brief!.id!,
                        isVisible: !brief!.isVisible!,
                        userId: brief!.userId!,
                        uname: brief!.name!,
                        type: brief!.type!,
                        category: brief!.category!,
                        postText: brief!.postText!,
                        imgSrc: brief!.imgSrc!,
                        avatarSrc: brief!.avatarSrc!,
                        createdAt: brief!.createdAt!,
                        updatedAt: brief!.updatedAt!,
                        likesCount: brief!.likesCount!,
                        replyCount: brief!.replyCount!,
                        postedAt: brief!.postedAt!,
                        isVisibleTo: brief!.isVisibleTo,
                      ),
                    ).future,
                  );
                  if (isVisible == true) {
                    ref.invalidate(BriefsProviders.getUserBriefsProvider);
                    _pagingController.refresh();
                  }
                }
              },
              onCommentTap: (brief) async {
                context.pushNamed(
                  FeedScreen.routeName,
                  extra: {'briefId': brief?.id},
                );
              },
              onLikeTap: (_) async {
                final tempBrief = brief;
                if (brief!.likeObj!.userId == null) {
                  setState(() {
                    final data = brief?.likeObj?.copyWith(userId: userDetails['user_id']);
                    _pagingController.itemList![index] = brief?.copyWith(likeObj: data, likesCount: brief!.likesCount! + 1);
                  });
                } else {
                  setState(() {
                    final data = brief?.likeObj?.copyWith(userId: null);
                    _pagingController.itemList![index] = brief?.copyWith(likeObj: data, likesCount: brief!.likesCount! - 1);
                  });
                }
                try {
                  await Future.delayed(Duration(milliseconds: 200));
                  // throw Exception();

                  if (brief!.likeObj!.userId == null) {
                    await ref.read(
                      LikesProvider.postLikeProvider(
                        PostLikeParams(
                          threadId: brief!.id,
                          type: userDetails['type'],
                          uName: userDetails['user_name'],
                          userId: userDetails['user_id'],
                          replyId: null,
                        ),
                      ).future,
                    );
                    var requestBody = {
                      "type": 'brief liked',
                      "sender_id": userDetails['user_id'],
                      "sender_name": userDetails['user_name'],
                      "receiver_id": brief!.userId,
                      "notification": "${userDetails['user_name']} liked your brief.",
                      "thread_id": brief!.id,
                    };
                    if (brief!.userId != userDetails['user_id']) {
                      await ref.read(NotificationProvider.postNewNotificationProvider(
                        PostNewNotificationParams(requestBody: requestBody),
                      ).future);
                    }
                  } else if (brief!.likeObj!.userId != null) {
                    await ref.read(
                      LikesProvider.deleteLikeProvider(
                        DeleteLikeParams(
                          likeId: brief!.likeObj!.id,
                          threadId: brief!.id,
                        ),
                      ).future,
                    );
                  }
                } catch (e) {
                  log(e.toString());
                  if (tempBrief!.likeObj!.userId != null) {
                    setState(() {
                      final data = tempBrief.likeObj?.copyWith(userId: userDetails['user_id']);
                      _pagingController.itemList![index] = tempBrief.copyWith(likeObj: data, likesCount: tempBrief.likesCount);
                    });
                  } else {
                    setState(() {
                      final data = tempBrief.likeObj?.copyWith(userId: null);
                      _pagingController.itemList![index] = tempBrief.copyWith(likeObj: data, likesCount: tempBrief.likesCount);
                    });
                  }
                  AppUtility(context).error('Something went wrong.');
                }
              },
              onShareTap: (brief) {
                shareBrief(brief!);
              },
              onTap: () async {
                context.pushNamed(
                  FeedScreen.routeName,
                  extra: {'briefId': brief?.id},
                );
              },
            );
          },
        ),
      ),
    );
  }

  void shareBrief(BriefsResult brief) {
    Share.share(
      'Check out this brief by: ${brief.name![0].toUpperCase()}${brief.name!.substring(1)} at\n ${ApiConstants.shareBrief}/${brief.id}',
      subject: 'Check out this brief!',
    );
  }
}



// class AllBriefsScreen extends ConsumerStatefulWidget {
//   const AllBriefsScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _AllBriefsScreenState();
// }

// class _AllBriefsScreenState extends ConsumerState<AllBriefsScreen> {
//   final TextEditingController postEditController = TextEditingController();
//   final ScrollController scrollController = ScrollController();
//   static const pageSize = 10;
//   // static const pageSize = 5;
//   @override
//   Widget build(BuildContext context) {
//     final getAllBriefsAsync = ref.watch(BriefsProviders.getAllBriefsProvider(1));
//     final totalResults = getAllBriefsAsync.valueOrNull?.totalResults;

//     return ListView.builder(
//       itemCount: totalResults,
//       itemBuilder: (context, index) {
//         final page = index ~/ pageSize + 1;
//         final indexInPage = index % pageSize;

//         final getAllBriefsAsync = ref.watch(BriefsProviders.getAllBriefsProvider(page));
//         return getAllBriefsAsync.when(
//           data: (briefs) {
//             if (indexInPage >= briefs!.briefResult!.length) {
//               return null;
//             }
//             BriefsResult brief = briefs.briefResult![indexInPage];
//             return CustomBriefsCard(
//               isUserTrue: brief.userId != ref.watch(userDetailsProvider)['user_id'] ? false : true,
//               brief: brief,
//               // postImage: snapshot.data?.imgSrc,
//               // avatarName: snapshot.data?.avatarSrc,
//               onSelected: (value) async {
//                 if (value == 'edit') {
//                   postEditController.text = brief.postText ?? '';
//                   List<String>? initialVisibleTo = brief.isVisibleTo;
//                   await customPostBriefModalSheet(
//                     context,
//                     selectedImage: ref.watch(selectedPostImageProvider),
//                     postTextCont: postEditController,
//                     postingAs: brief.name,
//                     onVisbileSelect: (List<String?> values) {
//                       // log(values.toString());
//                       if (!listEquals(values, initialVisibleTo)) {
//                         List<String>? updatedVisibleTo = List.from(brief.isVisibleTo ?? []);
//                         updatedVisibleTo.clear();
//                         updatedVisibleTo.addAll(values.whereType<String>().toList());
//                         // Remove duplicates by converting to a Set and back to a List
//                         updatedVisibleTo = updatedVisibleTo.toSet().toList();
//                         log(updatedVisibleTo.toString());
//                         log(initialVisibleTo.toString());

//                         final updatedBrief = brief.copyWith(isVisibleTo: updatedVisibleTo);
//                         brief = updatedBrief;
//                       }
//                     },
//                     selectedVisibleTo: brief.isVisibleTo ?? [],
//                     photoOnTap: () async {
//                       // final ImagePicker picker = ImagePicker();
//                       // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//                       // if (image != null) {
//                       //   var uploadedThreadImage = await ref.read(uploadThreadImageProvider(
//                       //     fileName: image.name,
//                       //     fileType: lookupMimeType(image.path),
//                       //     userId: userData['user_id'],
//                       //     userType: userData['type'],
//                       //   ).future);
//                       //   ref.read(uploadToAWSProvider(
//                       //     url: uploadedThreadImage.url,
//                       //     fileName: image.name,
//                       //     file: File(image.path),
//                       //     fileType: lookupMimeType(image.path),
//                       //   ).future);
//                       //   ref.read(uploadedThreadImageKeyProvider.notifier).state = uploadedThreadImage.key;

//                       //   ref.read(selectedPostImageProvider.notifier).state = File(image.path);
//                       // }
//                     },
//                     postOnTap: (postText, selectedCategory) async {
//                       if (postEditController.text.isNotEmpty) {
//                         if (selectedCategory != '') {
//                           var status = await ref.watch(
//                             BriefsProviders.editBriefProvider(
//                               EditBriefParams(
//                                 briefId: brief.id!,
//                                 isVisible: brief.isVisible!,
//                                 userId: brief.userId!,
//                                 uname: brief.name!,
//                                 type: brief.type!,
//                                 category: selectedCategory,
//                                 postText: postText,
//                                 imgSrc: brief.imgSrc!,
//                                 avatarSrc: brief.avatarSrc!,
//                                 createdAt: brief.createdAt!,
//                                 updatedAt: brief.updatedAt!,
//                                 likesCount: brief.likesCount!,
//                                 replyCount: brief.replyCount!,
//                                 postedAt: brief.postedAt!,
//                                 isVisibleTo: brief.isVisibleTo,
//                               ),
//                             ).future,
//                           );

//                           if (status == true) {
//                             postEditController.clear();
//                             GoRouter.of(context).pop();
//                           }
//                           ref.invalidate(BriefsProviders.getAllBriefsProvider);
//                           ref.invalidate(BriefsProviders.getUserBriefsProvider);
//                         } else {
//                           AppUtility(context).error('Choose a category first.');
//                         }
//                       }
//                     },
//                   );
//                 } else if (value == "delete") {
//                   await showAdaptiveDialog<bool>(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog.adaptive(
//                         content: const Text(
//                           'Deleting this brief will permanently remove it from the system. This action cannot be undone.',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         title: const Text(
//                           'Are you sure you want to delete this brief?',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         actions: [
//                           TextButton(
//                             style: TextButton.styleFrom(
//                               enableFeedback: true,
//                             ),
//                             onPressed: () {
//                               context.pop(false);
//                             },
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             style: TextButton.styleFrom(
//                               enableFeedback: true,
//                             ),
//                             onPressed: () async {
//                               var isDeleted = await ref.watch(BriefsProviders.deleteBriefProvider(brief.id).future);
//                               if (isDeleted == true) {
//                                 ref.invalidate(BriefsProviders.getAllBriefsProvider);
//                                 context.pop();
//                               }
//                             },
//                             child: Text(
//                               'Delete',
//                               style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                                     color: Colors.black,
//                                   ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 } else if (value == "visible") {
//                   var isVisible = await ref.watch(
//                     BriefsProviders.editBriefProvider(
//                       EditBriefParams(
//                         briefId: brief.id!,
//                         isVisible: !brief.isVisible!,
//                         userId: brief.userId!,
//                         uname: brief.name!,
//                         type: brief.type!,
//                         category: brief.category!,
//                         postText: brief.postText!,
//                         imgSrc: brief.imgSrc!,
//                         avatarSrc: brief.avatarSrc!,
//                         createdAt: brief.createdAt!,
//                         updatedAt: brief.updatedAt!,
//                         likesCount: brief.likesCount!,
//                         replyCount: brief.replyCount!,
//                         postedAt: brief.postedAt!,
//                         isVisibleTo: brief.isVisibleTo,
//                       ),
//                     ).future,
//                   );
//                   if (isVisible == true) {
//                     ref.invalidate(BriefsProviders.getUserBriefsProvider);
//                   }
//                 }
//               },
//               onCommentTap: (brief) async {
//                 context.pushNamed(
//                   FeedScreen.routeName,
//                   extra: {'briefId': brief?.id},
//                 );
//               },
//               onLikeTap: (_) async {
//                 final tempBrief = brief;
//                 // if (brief.likeObj!.userId == null) {
//                 //   setState(() {
//                 //     final data = brief.likeObj?.copyWith(userId: userDetails['user_id']);
//                 //     _pagingController.itemList![index] = brief.copyWith(likeObj: data, likesCount: brief.likesCount! + 1);
//                 //   });
//                 // } else {
//                 //   setState(() {
//                 //     final data = brief.likeObj?.copyWith(userId: null);
//                 //     _pagingController.itemList![index] = brief.copyWith(likeObj: data, likesCount: brief.likesCount! - 1);
//                 //   });
//                 // }
//                 // try {
//                 //   await Future.delayed(Duration(milliseconds: 200));
//                 //   // throw Exception();

//                 //   if (brief.likeObj!.userId == null) {
//                 //     await ref.read(
//                 //       LikesProvider.postLikeProvider(
//                 //         PostLikeParams(
//                 //           threadId: brief.id,
//                 //           type: userDetails['type'],
//                 //           uName: userDetails['user_name'],
//                 //           userId: userDetails['user_id'],
//                 //           replyId: null,
//                 //         ),
//                 //       ).future,
//                 //     );
//                 //     var requestBody = {
//                 //       "type": 'brief liked',
//                 //       "sender_id": userDetails['user_id'],
//                 //       "sender_name": userDetails['user_name'],
//                 //       "receiver_id": brief.userId,
//                 //       "notification": "${userDetails['user_name']} liked your brief.",
//                 //       "thread_id": brief.id,
//                 //     };
//                 //     if (brief.userId != userDetails['user_id']) {
//                 //       await ref.read(NotificationProvider.postNewNotificationProvider(
//                 //         PostNewNotificationParams(requestBody: requestBody),
//                 //       ).future);
//                 //     }
//                 //   } else if (brief.likeObj!.userId != null) {
//                 //     await ref.read(
//                 //       LikesProvider.deleteLikeProvider(
//                 //         DeleteLikeParams(
//                 //           likeId: brief.likeObj!.id,
//                 //           threadId: brief.id,
//                 //         ),
//                 //       ).future,
//                 //     );
//                 //   }
//                 // } catch (e) {
//                 //   log(e.toString());
//                 //   if (tempBrief.likeObj!.userId != null) {
//                 //     setState(() {
//                 //       final data = tempBrief.likeObj?.copyWith(userId: userDetails['user_id']);
//                 //       _pagingController.itemList![index] = tempBrief.copyWith(likeObj: data, likesCount: tempBrief.likesCount);
//                 //     });
//                 //   } else {
//                 //     setState(() {
//                 //       final data = tempBrief.likeObj?.copyWith(userId: null);
//                 //       _pagingController.itemList![index] = tempBrief.copyWith(likeObj: data, likesCount: tempBrief.likesCount);
//                 //     });
//                 //   }
//                 //   AppUtility(context).error('Something went wrong.');
//                 // }
//               },
//               onShareTap: (brief) {
//                 shareBrief(brief!);
//               },
//               onTap: () async {
//                 context.pushNamed(
//                   FeedScreen.routeName,
//                   extra: {'briefId': brief.id},
//                 );
//               },
//             );
//           },
//           error: (error, stackTrace) {
//             if (error is AppError) {
//               return Center(
//                 child: Text(
//                   error.errorMessage.toString(),
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
//                 ),
//               );
//             }
//             return Center(
//               child: Text('ERROR : ${error.toString()}'),
//             );
//           },
//           loading: () => Container(
//             height: ScreenSize.height(context) * 0.7,
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void shareBrief(BriefsResult brief) {
//     Share.share(
//       'Check out this brief by: ${brief.name![0].toUpperCase()}${brief.name!.substring(1)} at\n ${ApiConstants.shareBrief}/${brief.id}',
//       subject: 'Check out this brief!',
//     );
//   }
// }