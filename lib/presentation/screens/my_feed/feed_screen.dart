import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../common/others/assets.dart';
import '../../../data/core/api_constants.dart';
import '../../../data/core/app_error.dart';
import '../../../data/di/get_it.dart';
import '../../../data/models/briefs_result.dart';
import '../../../data/models/chat_user_model.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/services/notification_service.dart';
import '../../params/chat_params.dart';
import '../../params/likes_params.dart';
import '../../params/notification_params.dart';
import '../../params/reply_params.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/likes_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/reply_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import '../../widgets/custom_comment_card.dart';
import '../messages/chat_screen.dart';
import 'reply_screen.dart';

class FeedScreen extends StatefulHookConsumerWidget {
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
    final isEditComment = useState(false);
    final initialComment = useState('');
    final initialCommentId = useState('');

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
                              final likeId = await ref.read(
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
                              if (brief.userId != userDetails['user_id']) {
                                final notificationServices = getItInstance<NotificationServices>();
                                await ref.read(NotificationProvider.briefLikeNotificationProvider(
                                  NotificationParams(
                                    likeId: likeId,
                                    threadId: brief.id,
                                    receiverId: brief.userId,
                                    briefText: brief.postText,
                                  ),
                                ).future);
                                notificationServices.sendPushNotification(
                                  userToken: brief.fcmToken!,
                                  body: "Liked your Brief",
                                  title: userDetails['user_name']!,
                                );
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
                            if (comments.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.noComments,
                                    height: 150 * ScaleSize.textScaleFactor(context),
                                    width: 200 * ScaleSize.textScaleFactor(context),
                                  ),
                                  Text(
                                    'Be the first to comment!',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.secondary,
                                      foregroundColor: Theme.of(context).colorScheme.onSecondary,
                                    ),
                                    onPressed: () {
                                      final focusNode = ref.read(textFieldFocusNodeProvider);
                                      focusNode.requestFocus();
                                    },
                                    child: Text('Comment'),
                                  ),
                                ],
                              );
                            } else
                              return ListView.builder(
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  return CustomCommentCard(
                                    isAuthor: (brief.userId == comments[index].userId) ? true : false,
                                    isUserTrue: (brief.userId == userDetails['user_id']) ? true : false,
                                    isReplies: false,
                                    onCommentTap: (p0) {
                                      GoRouter.of(context).pushNamed(
                                        ReplyScreen.routeName,
                                        extra: {
                                          'commentModel': comments[index],
                                          'briefResult': brief,
                                        },
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
                                          final likeId = await ref.read(
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
                                          if (comments[index].userId != userDetails['user_id']) {
                                            final notificationServices = getItInstance<NotificationServices>();
                                            await ref.read(NotificationProvider.commentLikeNotificationProvider(
                                              NotificationParams(
                                                commentId: comments[index].id,
                                                threadId: brief.id,
                                                receiverId: comments[index].userId,
                                                commentText: comments[index].commentText,
                                                likeId: likeId,
                                              ),
                                            ).future);
                                            notificationServices.sendPushNotification(
                                              userToken: comments[index].fcmToken!,
                                              body: "Liked your Comment",
                                              title: userDetails['user_name']!,
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
                                    onSelected: (value) async {
                                      if (value == 'edit') {
                                        await _editComment(
                                          context,
                                          comments[index],
                                          isEditComment,
                                          initialComment,
                                          initialCommentId,
                                        );
                                      } else if (value == "delete") {
                                        await _deleteComment(context, comments[index]);
                                      }
                                    },
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
                                      hintText: "Comment on this brief",
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
                                  if (isEditComment.value == true) {
                                    if (commentCont.text != initialComment.value)
                                      await ref.read(
                                        ReplyProvider.editCommentProvider(
                                          EditReplyParams(
                                            commentText: commentCont.text.trim(),
                                            commentId: initialCommentId.value,
                                          ),
                                        ).future,
                                      );
                                    commentCont.clear();
                                  } else {
                                    var commentPosted = await ref.read(ReplyProvider.postReplyProvider(
                                      PostReplyParams(
                                        commentText: commentCont.text.trim(),
                                        threadId: brief.id,
                                        userId: userDetails['user_id'],
                                      ),
                                    ).future);
                                    if (commentPosted == true) {
                                      if (brief.userId != userDetails['user_id']) {
                                        final notificationServices = getItInstance<NotificationServices>();
                                        await ref.read(NotificationProvider.commentNotificationProvider(
                                          NotificationParams(
                                            threadId: brief.id,
                                            receiverId: brief.userId,
                                          ),
                                        ).future);
                                        notificationServices.sendPushNotification(
                                          userToken: brief.fcmToken!,
                                          body: "Commented on your Brief",
                                          title: userDetails['user_name']!,
                                        );
                                      }
                                      commentCont.clear();
                                    }
                                  }
                                  ref.invalidate(ReplyProvider.getAllCommentsProvider);
                                  ref.invalidate(briefsNotifierProvider);
                                  ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: 1);
                                  ref.invalidate(BriefsProviders.getUserBriefsProvider);
                                  ref.invalidate(BriefsProviders.getSingleBriefProvider);
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

  Future<void> _editComment(
    BuildContext context,
    CommentModel comment,
    ValueNotifier<bool> isEditComment,
    ValueNotifier<String> initialComment,
    ValueNotifier<String> initialCommentId,
  ) async {
    initialComment.value = comment.commentText ?? '';
    initialCommentId.value = comment.id ?? '';
    commentCont.text = comment.commentText ?? '';
    final focusNode = ref.read(textFieldFocusNodeProvider);
    focusNode.requestFocus();
    isEditComment.value = true;
  }

  Future<void> _deleteComment(BuildContext context, CommentModel comment) async {
    await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text(
            'Delete Comment?',
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            'Are you sure you want to delete this comment?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                var isDeleted = await ref.watch(ReplyProvider.deleteCommentProvider(comment.id).future);
                if (isDeleted == true) {
                  ref.invalidate(ReplyProvider.getAllCommentsProvider);
                  ref.invalidate(briefsNotifierProvider);
                  ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: 1);
                  ref.invalidate(BriefsProviders.getUserBriefsProvider);
                  ref.invalidate(BriefsProviders.getSingleBriefProvider);
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
  }
}
