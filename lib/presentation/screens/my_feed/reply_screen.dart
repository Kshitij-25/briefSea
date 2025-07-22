import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../data/core/app_error.dart';
import '../../../data/di/get_it.dart';
import '../../../data/models/briefs_result.dart';
import '../../../data/models/chat_user_model.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/services/notification_service.dart';
import '../../params/chat_params.dart';
import '../../params/notification_params.dart';
import '../../params/reply_params.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/reply_provider.dart';
import '../../widgets/custom_comment_card.dart';
import '../messages/chat_screen.dart';

class ReplyScreen extends HookConsumerWidget {
  static const String routeName = "/replyScreen";

  final CommentModel? commentModel;
  final BriefsResult? briefResult;

  ReplyScreen({
    super.key,
    this.commentModel,
    this.briefResult,
  });

  final TextEditingController replyCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditReply = useState(false);
    final initialReply = useState('');
    final initialReplyId = useState('');
    final isEditComment = useState(false);
    final initialComment = useState('');
    final initialCommentId = useState('');
    final userDetails = ref.watch(userDetailsProvider);
    final getReplies = ref.watch(ReplyProvider.getAllReplyOnCommentProvider(commentModel!.id));
    final textFieldFocusNode = ref.watch(textFieldFocusNodeProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          centerTitle: true,
          title: Text(
            'Comment Replies',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Stack(
          children: [
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
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Column(
                  children: [
                    // Text(
                    //   "Replies to ${commentModel!.name}'s comment on this post.",
                    //   style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
                    // ),
                    // Divider(color: Theme.of(context).colorScheme.outline),
                    CustomCommentCard(
                      isAuthor: (briefResult?.userId == commentModel?.userId) ? true : false,
                      isUserTrue: (briefResult?.userId == userDetails['user_id']) ? true : false,
                      isReplies: false,
                      onCommentTap: (value) {
                        final focusNode = ref.read(textFieldFocusNodeProvider);
                        focusNode.requestFocus();
                      },
                      onLikeTap: (value) {},
                      onDMTap: (p0) async {
                        var isChatCreated = await ref.watch(
                          ChatProvider.createNewChatProvider(
                            CreateNewChatParams(
                              receiverId: commentModel!.userId!,
                              senderId: userDetails['user_id']!,
                            ),
                          ).future,
                        );

                        if (isChatCreated == true) {
                          ChatUserModel chatUserModel = await ref.watch(
                            ChatProvider.getDMUserProvider(
                              GetDMUserParams(
                                receiverId: commentModel!.userId!,
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
                      commentModel: commentModel,
                      loggedInUserId: userDetails['user_id'],
                      onSelected: (value) {},
                      isCommentReply: true,
                    ),
                    Expanded(
                      child: getReplies.when(
                        data: (replies) {
                          return Padding(
                            padding: EdgeInsets.only(left: 30 * ScaleSize.textScaleFactor(context)),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: replies.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    CustomCommentCard(
                                      isAuthor: (briefResult?.userId == replies[index].userId) ? true : false,
                                      width: ScreenSize.width(context) * 0.7,
                                      isUserTrue: (briefResult?.userId == userDetails['user_id']) ? true : false,
                                      isReplies: true,
                                      onCommentTap: (value) {},
                                      onLikeTap: (value) {},
                                      onDMTap: (value) {},
                                      commentModel: replies[index],
                                      loggedInUserId: userDetails['user_id'],
                                      onSelected: (value) async {
                                        if (value == 'edit') {
                                          await _editReply(
                                            context,
                                            replies[index],
                                            isEditReply,
                                            initialReply,
                                            initialReplyId,
                                            ref,
                                          );
                                        } else if (value == "delete") {
                                          await _deleteComment(context, replies[index]);
                                        }
                                      },
                                    ),
                                    if (userDetails['user_id'] != replies[index].userId)
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 1,
                                            height: ScreenSize.height(context) * 0.1,
                                            color: Theme.of(context).colorScheme.outlineVariant,
                                          ),
                                          Container(
                                            height: 1,
                                            width: 10,
                                            color: Theme.of(context).colorScheme.outlineVariant,
                                          ),
                                        ],
                                      ),
                                  ],
                                );
                              },
                            ),
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
                                  controller: replyCont,
                                  textCapitalization: TextCapitalization.sentences,
                                  minLines: 1,
                                  maxLines: 100,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Reply on this comment",
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
                                if (replyCont.text.isEmpty) {
                                  return;
                                }
                                if (isEditReply.value == true) {
                                  if (replyCont.text != initialReply.value) {
                                    await ref.read(
                                      ReplyProvider.editCommentProvider(
                                        EditReplyParams(
                                          commentText: replyCont.text.trim(),
                                          commentId: initialReplyId.value,
                                        ),
                                      ).future,
                                    );
                                  }
                                  replyCont.clear();
                                } else {
                                  var replyPosted = await ref.read(
                                    ReplyProvider.postReplyProvider(
                                      PostReplyParams(
                                        commentText: replyCont.text,
                                        threadId: briefResult?.id,
                                        userId: userDetails['user_id'],
                                        replyId: commentModel?.id,
                                      ),
                                    ).future,
                                  );
                                  if (replyPosted == true) {
                                    if (commentModel?.userId != userDetails['user_id']) {
                                      final notificationServices = getItInstance<NotificationServices>();
                                      await ref.read(NotificationProvider.replyNotificationProvider(
                                        NotificationParams(
                                          commentId: commentModel?.id,
                                          receiverId: commentModel?.userId,
                                          threadId: briefResult?.id,
                                        ),
                                      ).future);
                                      notificationServices.sendPushNotification(
                                        userToken: commentModel!.fcmToken!,
                                        body: "Replied to your comment",
                                        title: userDetails['user_name']!,
                                      );
                                    }
                                    replyCont.clear();
                                  }
                                }
                                ref.invalidate(ReplyProvider.getAllReplyOnCommentProvider);
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editReply(
    BuildContext context,
    CommentModel comment,
    ValueNotifier<bool> isEditReply,
    ValueNotifier<String> initialReply,
    ValueNotifier<String> initialReplyId,
    WidgetRef ref,
  ) async {
    initialReply.value = comment.commentText ?? '';
    initialReplyId.value = comment.id ?? '';
    replyCont.text = comment.commentText ?? '';
    final focusNode = ref.read(textFieldFocusNodeProvider);
    focusNode.requestFocus();
    isEditReply.value = true;
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
            Consumer(builder: (context, ref, _) {
              return TextButton(
                onPressed: () async {
                  var isDeleted = await ref.watch(ReplyProvider.deleteCommentProvider(comment.id).future);
                  if (isDeleted == true) {
                    ref.invalidate(ReplyProvider.getAllReplyOnCommentProvider);
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
              );
            }),
          ],
        );
      },
    );
  }
}
