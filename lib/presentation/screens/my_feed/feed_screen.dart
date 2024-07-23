import 'dart:developer';

import 'package:briefsea/data/core/api_constants.dart';
import 'package:briefsea/data/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../data/models/briefs_model.dart';
import '../../../data/models/chat_user_model.dart';
import '../../../data/models/image_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/likes_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/reply_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/reply_state_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import '../../widgets/custom_comment_card.dart';
import '../../widgets/reply_modal_sheet.dart';
import '../messages/chat_screen.dart';

class FeedScreen extends ConsumerWidget {
  FeedScreen({
    super.key,
    this.briefId,
  });

  static const routeName = '/feedScreen';

  final String? briefId;

  final TextEditingController commentCont = TextEditingController();
  final TextEditingController replyCont = TextEditingController();

  Future<BriefsModel?> _initializeBriefImageProviders(WidgetRef ref, BriefsModel briefModel) async {
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

  Future<CommentModel?> _initializeCommentImageProviders(WidgetRef ref, CommentModel commentModel) async {
    try {
      if (commentModel.avatarSrc != null && commentModel.avatarSrc != '') {
        ImageModel avatarUrl = await ref.watch(getImageProvider(src: commentModel.avatarSrc!).future);
        if (avatarUrl.url != null && avatarUrl.url != '') {
          commentModel = commentModel.copyWith(avatarSrc: avatarUrl.url);
        }
      }

      // if (commentModel.imgSrc != null && commentModel.imgSrc != '') {
      //   ImageModel postImage = await ref.watch(getImageProvider(src: commentModel.imgSrc!).future);
      //   if (postImage.url != null && postImage.url != '') {
      //     commentModel = commentModel.copyWith(imgSrc: postImage.url);
      //   }
      // }

      return commentModel;
    } catch (e) {
      print('Error initializing image providers: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var brief = ref.watch(getSingleBriefProvider(briefId: briefId));

    final userDetails = ref.watch(userDetailsProvider);
    final textFieldFocusNode = ref.watch(textFieldFocusNodeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        // title: Text(
        //   brief.name ?? "",
        //   style: const TextStyle(
        //     fontWeight: FontWeight.bold,
        //     color: Colors.white,
        //   ),
        // ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       CupertinoIcons.bookmark,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //     icon: const Icon(
        //       CupertinoIcons.ellipsis_vertical,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 70 * ScaleSize.textScaleFactor(context),
            color: Theme.of(context).colorScheme.secondary,
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
            child: brief.when(
              data: (brief) {
                final getComments = ref.watch(getAllCommentsProvider(threadId: brief!.id));
                return Column(
                  children: [
                    FutureBuilder(
                      future: _initializeBriefImageProviders(ref, brief),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          return CustomBriefsCard(
                            isUserTrue: (brief.userId == userDetails['user_id']) ? true : false,
                            maxLine: 100,
                            cardVisible: false,
                            postImage: snapshot.data?.imgSrc,
                            avatarName: snapshot.data?.avatarSrc,
                            brief: brief,
                            onCommentTap: (brief) {
                              final focusNode = ref.read(textFieldFocusNodeProvider);
                              focusNode.requestFocus();
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
                          );
                        }
                      },
                    ),
                    Expanded(
                      child: getComments.when(
                        data: (comments) {
                          return ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              print("${brief.userId}== ${userDetails['user_id']}");
                              return FutureBuilder(
                                future: _initializeCommentImageProviders(ref, comments[index]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const SizedBox.shrink();
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text('Error: ${snapshot.error}'));
                                  } else {
                                    return CustomCommentCard(
                                      isUserTrue: (brief.userId == userDetails['user_id']) ? true : false,
                                      avatarName: snapshot.data?.avatarSrc,
                                      isReplies: false,
                                      onCommentTap: (p0) {
                                        ref.watch(isReplyStateProvider.notifier).state = true;
                                        customReplyModalSheet(
                                          context,
                                          comments: comments[index],
                                          replyCont: replyCont,
                                          threadId: brief.id,
                                          userDetails: userDetails,
                                        );
                                      },
                                      onLikeTap: (p0) async {
                                        try {
                                          if (!comments[index].isCommentLiked) {
                                            await ref.read(postLikeProvider(
                                              threadId: comments[index].threadId,
                                              type: userDetails['type'],
                                              uName: userDetails['user_name'],
                                              userId: userDetails['user_id'],
                                              replyId: comments[index].id,
                                            ).future);
                                          } else {
                                            await ref.read(deleteLikeProvider(
                                              likeId: comments[index].commentLikeId,
                                              threadId: comments[index].threadId,
                                            ).future);
                                          }
                                          ref.invalidate(getAllCommentsProvider(threadId: brief.id));
                                        } catch (e) {
                                          log(e.toString());
                                        }
                                      },
                                      onDMTap: (p0) async {
                                        var isChatCreated = await ref.watch(
                                          createNewChatProvider(
                                            receiverId: comments[index].userId!,
                                            senderId: userDetails['user_id']!,
                                          ).future,
                                        );

                                        if (isChatCreated == true) {
                                          ChatUserModel chatUserModel = await ref.watch(
                                            getDMUserProvider(
                                              receiverId: comments[index].userId!,
                                              senderId: userDetails['user_id']!,
                                            ).future,
                                          );
                                          context.pushNamed(
                                            ChatScreen.routeName,
                                            extra: chatUserModel,
                                          );
                                        }
                                      },
                                      commentModel: comments[index],
                                      loggedInUserId: userDetails['user_id'],
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
                      ),
                    ),
                    SafeArea(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 90,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          border: Border(
                            top: BorderSide(color: Colors.black26),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  focusNode: textFieldFocusNode,
                                  controller: commentCont,
                                  textCapitalization: TextCapitalization.sentences,
                                  minLines: 1,
                                  maxLines: 100,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: "Reply to this brief",
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                enableFeedback: true,
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                elevation: 0,
                              ),
                              onPressed: () async {
                                var commentPosted = await ref.read(postReplyProvider(
                                  commentText: commentCont.text,
                                  threadId: brief.id,
                                  userId: userDetails['user_id'],
                                ).future);
                                if (commentPosted == true) {
                                  if (brief.userId != userDetails['user_id']) {
                                    await ref.read(postNewNotificationProvider(
                                      requestBody: {
                                        "type": 'brief comment',
                                        "sender_id": userDetails['user_id'],
                                        "sender_name": userDetails['user_name'],
                                        "receiver_id": brief.userId,
                                        "notification": "${userDetails['user_name']} commented on your brief.",
                                        "thread_id": brief.id,
                                      },
                                    ).future);
                                  }
                                  commentCont.clear();
                                }
                                ref.invalidate(getAllCommentsProvider(threadId: brief.id));
                                ref.invalidate(getAllBriefsProvider);
                                ref.invalidate(getUserBriefsProvider);
                                ref.invalidate(getSingleBriefProvider(briefId: brief.id));
                              },
                              child: Text(
                                "Post",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
