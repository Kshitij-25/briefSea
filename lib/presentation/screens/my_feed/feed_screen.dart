import 'dart:developer';

import 'package:briefsea/data/core/api_constants.dart';
import 'package:briefsea/presentation/params/chat_params.dart';
import 'package:briefsea/presentation/params/likes_params.dart';
import 'package:briefsea/presentation/params/notification_params.dart';
import 'package:briefsea/presentation/params/reply_params.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../data/core/app_error.dart';
import '../../../data/models/briefs_result.dart';
import '../../../data/models/chat_user_model.dart';
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

class FeedScreen extends ConsumerStatefulWidget {
  FeedScreen({super.key, this.briefId});

  static const routeName = '/feedScreen';

  final String? briefId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final TextEditingController commentCont = TextEditingController();
  final TextEditingController replyCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var singleBrief = ref.watch(BriefsProviders.getSingleBriefProvider(widget.briefId));

    final userDetails = ref.watch(userDetailsProvider);
    final textFieldFocusNode = ref.watch(textFieldFocusNodeProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
              child: singleBrief.when(
                data: (brief) {
                  if (brief == null) {
                    return Container();
                  }
                  final getComments = ref.watch(ReplyProvider.getAllCommentsProvider(brief.id));
                  return Column(
                    children: [
                      CustomBriefsCard(
                        isUserTrue: (brief.userId == userDetails['user_id']) ? true : false,
                        maxLine: 100,
                        cardVisible: false,
                        // postImage: snapshot.data?.imgSrc,
                        // avatarName: snapshot.data?.avatarSrc,
                        brief: brief,
                        onCommentTap: (brief) {
                          final focusNode = ref.read(textFieldFocusNodeProvider);
                          focusNode.requestFocus();
                        },
                        onLikeTap: (_) async {
                          // final tempBrief = brief;
                          // if (brief!.likeObj!.userId == null) {
                          //   final data = brief!.likeObj?.copyWith(userId: userDetails['user_id']);
                          //   brief = brief!.copyWith(likeObj: data, likesCount: brief!.likesCount! + 1);
                          //   setState(() {});
                          // } else {
                          //   final data = brief!.likeObj?.copyWith(userId: null);
                          //   brief = brief!.copyWith(likeObj: data, likesCount: brief!.likesCount! - 1);
                          //   setState(() {});
                          // }
                          try {
                            if (brief.likeObj!.userId == null) {
                              await ref.read(
                                LikesProvider.postLikeProvider(
                                  PostLikeParams(
                                    threadId: brief.id,
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
                                "receiver_id": brief.userId,
                                "notification": "${userDetails['user_name']} liked your brief.",
                                "thread_id": brief.id,
                              };
                              if (brief.userId != userDetails['user_id']) {
                                await ref.read(NotificationProvider.postNewNotificationProvider(
                                  PostNewNotificationParams(requestBody: requestBody),
                                ).future);
                              }
                            } else if (brief.likeObj!.userId != null) {
                              await ref.read(LikesProvider.deleteLikeProvider(
                                DeleteLikeParams(
                                  likeId: brief.likeObj!.id,
                                  threadId: brief.id,
                                ),
                              ).future);
                            }
                            ref.invalidate(briefsNotifierProvider);
                            ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: 1);
                            ref.invalidate(BriefsProviders.getUserBriefsProvider);
                            ref.invalidate(BriefsProviders.getSingleBriefProvider);
                          } catch (e) {
                            log(e.toString());
                            //   if (tempBrief!.likeObj!.userId != null) {
                            //     setState(() {
                            //       final data = tempBrief.likeObj?.copyWith(userId: userDetails['user_id']);
                            //       brief = tempBrief.copyWith(likeObj: data, likesCount: tempBrief.likesCount! + 1);
                            //     });
                            //   } else {
                            //     setState(() {
                            //       final data = tempBrief.likeObj?.copyWith(userId: null);
                            //       brief = tempBrief.copyWith(likeObj: data, likesCount: tempBrief.likesCount! - 1);
                            //     });
                            //   }
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
                                print("${brief.userId}== ${userDetails['user_id']}");
                                return CustomCommentCard(
                                  isUserTrue: (brief.userId == userDetails['user_id']) ? true : false,
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
                                    final tempComment = comments[index];
                                    if (comments[index].likeObj!.userId == null) {
                                      setState(() {
                                        final data = comments[index].likeObj?.copyWith(userId: userDetails['user_id']);
                                        comments[index] = comments[index].copyWith(likeObj: data, likesCount: comments[index].likesCount! + 1);
                                      });
                                    } else {
                                      setState(() {
                                        final data = comments[index].likeObj?.copyWith(userId: null);
                                        comments[index] = comments[index].copyWith(likeObj: data, likesCount: comments[index].likesCount! - 1);
                                      });
                                    }
                                    try {
                                      if (tempComment.likeObj?.userId == null) {
                                        await Future.delayed(Duration(milliseconds: 200));
                                        // throw Exception();
                                        await ref.read(
                                          LikesProvider.postLikeProvider(
                                            PostLikeParams(
                                              threadId: comments[index].threadId,
                                              type: userDetails['type'],
                                              uName: userDetails['user_name'],
                                              userId: userDetails['user_id'],
                                              replyId: comments[index].id,
                                            ),
                                          ).future,
                                        );
                                        var requestBody = {
                                          "type": 'Comment liked',
                                          "sender_id": userDetails['user_id'],
                                          "sender_name": userDetails['user_name'],
                                          "receiver_id": comments[index].userId,
                                          "notification": "${userDetails['user_name']} liked your comment.",
                                          "thread_id": brief.id,
                                          "reply_id": comments[index].id,
                                        };
                                        if (comments[index].userId != userDetails['user_id']) {
                                          await ref.read(
                                            NotificationProvider.postNewNotificationProvider(
                                              PostNewNotificationParams(requestBody: requestBody),
                                            ).future,
                                          );
                                        }
                                      } else {
                                        await ref.read(
                                          LikesProvider.deleteLikeProvider(
                                            DeleteLikeParams(
                                              likeId: comments[index].likeObj?.id,
                                              threadId: comments[index].threadId,
                                            ),
                                          ).future,
                                        );
                                      }
                                      // ref.invalidate(ReplyProvider.getAllCommentsProvider);
                                    } catch (e) {
                                      log(e.toString());
                                      if (tempComment.likeObj?.userId != null) {
                                        setState(() {
                                          final data = tempComment.likeObj?.copyWith(userId: userDetails['user_id']);
                                          comments[index] = tempComment.copyWith(likeObj: data, likesCount: tempComment.likesCount);
                                        });
                                      } else {
                                        setState(() {
                                          final data = tempComment.likeObj?.copyWith(userId: null);
                                          comments[index] = tempComment.copyWith(likeObj: data, likesCount: tempComment.likesCount);
                                        });
                                      }
                                    }
                                  },
                                  onDMTap: (p0) async {
                                    var isChatCreated = await ref.watch(
                                      ChatProvider.createNewChatProvider(
                                        CreateNewChatParams(
                                          receiverId: comments[index].userId!,
                                          senderId: userDetails['user_id']!,
                                        ),
                                      ).future,
                                    );

                                    if (isChatCreated == true) {
                                      ChatUserModel chatUserModel = await ref.watch(
                                        ChatProvider.getDMUserProvider(
                                          GetDMUserParams(
                                            receiverId: comments[index].userId!,
                                            senderId: userDetails['user_id']!,
                                          ),
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
                              },
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
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
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
                                    decoration: InputDecoration.collapsed(
                                      hintText: "Reply to this brief",
                                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).hintColor),
                                    ),
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.scrim),
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
                                  var commentPosted = await ref.read(ReplyProvider.postReplyProvider(
                                    PostReplyParams(
                                      commentText: commentCont.text.trim(),
                                      threadId: brief.id,
                                      userId: userDetails['user_id'],
                                    ),
                                  ).future);
                                  if (commentPosted == true) {
                                    if (brief.userId != userDetails['user_id']) {
                                      var requestBody = {
                                        "type": 'brief comment',
                                        "sender_id": userDetails['user_id'],
                                        "sender_name": userDetails['user_name'],
                                        "receiver_id": brief.userId,
                                        "notification": "${userDetails['user_name']} commented on your brief.",
                                        "thread_id": brief.id,
                                      };
                                      await ref.read(NotificationProvider.postNewNotificationProvider(
                                        PostNewNotificationParams(requestBody: requestBody),
                                      ).future);
                                    }
                                    commentCont.clear();
                                  }
                                  ref.invalidate(ReplyProvider.getAllCommentsProvider(brief.id));
                                  ref.invalidate(briefsNotifierProvider);
                                  ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: 1);
                                  ref.invalidate(BriefsProviders.getUserBriefsProvider);
                                  ref.invalidate(BriefsProviders.getSingleBriefProvider(brief.id));
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
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
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
