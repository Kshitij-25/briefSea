import 'dart:developer';

import 'package:briefsea/data/core/api_constants.dart';
import 'package:briefsea/data/models/chat_user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../data/models/briefs_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/likes_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/reply_provider.dart';
import '../../state_providers/reply_state_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import '../../widgets/custom_comment_card.dart';
import '../../widgets/reply_modal_sheet.dart';
import '../messages/chat_screen.dart';

class FeedScreen extends ConsumerWidget {
  FeedScreen({
    super.key,
    this.brief,
  });

  static const routeName = '/feedScreen';

  final BriefsModel? brief;

  final TextEditingController commentCont = TextEditingController();
  final TextEditingController replyCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getComments = ref.watch(getAllCommentsProvider(threadId: brief!.id));
    final userDetails = ref.watch(userDetailsProvider);
    final textFieldFocusNode = ref.watch(textFieldFocusNodeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B26FD),
        title: Text(
          brief?.name ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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
            child: Column(
              children: [
                CustomBriefsCard(
                  isUserTrue: (brief!.userId == userDetails['user_id']) ? true : false,
                  maxLine: 100,
                  cardVisible: false,
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
                ),
                Expanded(
                  child: getComments.when(
                    data: (comments) {
                      return ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          print("${brief!.userId}== ${userDetails['user_id']}");
                          return CustomCommentCard(
                            isUserTrue: (brief!.userId == userDetails['user_id']) ? true : false,
                            isReplies: false,
                            onCommentTap: (p0) {
                              ref.watch(isReplyStateProvider.notifier).state = true;
                              customReplyModalSheet(
                                context,
                                comments: comments[index],
                                replyCont: replyCont,
                                threadId: brief!.id,
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
                                ref.invalidate(getAllCommentsProvider(threadId: brief!.id));
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
                                context.push(
                                  ChatScreen.routeName,
                                  extra: chatUserModel,
                                );
                              }
                            },
                            commentModel: comments[index],
                            loggedInUserId: userDetails['user_id'],
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
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF4B26FD)),
                            elevation: WidgetStateProperty.all<double>(0),
                          ),
                          onPressed: () async {
                            var commentPosted = await ref.read(postReplyProvider(
                              commentText: commentCont.text,
                              threadId: brief!.id,
                              userId: userDetails['user_id'],
                            ).future);
                            if (commentPosted == true) {
                              if (brief!.userId != userDetails['user_id']) {
                                await ref.read(postNewNotificationProvider(
                                  requestBody: {
                                    "type": 'brief comment',
                                    "sender_id": userDetails['user_id'],
                                    "sender_name": userDetails['user_name'],
                                    "receiver_id": brief!.userId,
                                    "notification": "${userDetails['user_name']} commented on your brief.",
                                    "thread_id": brief!.id,
                                  },
                                ).future);
                              }
                              commentCont.clear();
                            }
                            ref.invalidate(getAllCommentsProvider(threadId: brief!.id));
                            ref.invalidate(getAllBriefsProvider);
                            ref.invalidate(getUserBriefsProvider);
                            ref.invalidate(getSingleBriefProvider(briefId: brief!.id));
                          },
                          child: const Text(
                            "Post",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
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
