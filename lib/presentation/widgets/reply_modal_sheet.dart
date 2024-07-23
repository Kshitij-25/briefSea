import 'dart:ui';

import 'package:briefsea/common/app_utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/comment_model.dart';
import '../providers/notification_provider.dart';
import '../providers/reply_provider.dart';
import '../state_providers/reply_state_provider.dart';
import 'custom_comment_card.dart';

Future<void> customReplyModalSheet(
  BuildContext context, {
  CommentModel? comments,
  Map<String, String>? userDetails,
  TextEditingController? replyCont,
  String? threadId,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    isScrollControlled: true,
    context: context,
    constraints: BoxConstraints.fromViewConstraints(ViewConstraints(minWidth: ScreenSize.width(context))),
    builder: (context) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) => replyCont?.clear(),
        child: Consumer(
          builder: (context, ref, child) {
            final getReplies = ref.watch(getAllReplyOnCommentProvider(commentId: comments!.id));
            final isReplies = ref.watch(isReplyStateProvider.notifier).state;
            return getReplies.when(
              data: (replies) {
                return FractionallySizedBox(
                  heightFactor: 0.85,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: replies.length,
                          itemBuilder: (context, index) {
                            return CustomCommentCard(
                              isUserTrue: false,
                              isReplies: isReplies,
                              onCommentTap: (p0) {},
                              onLikeTap: (p0) {},
                              onDMTap: (p0) {},
                              commentModel: replies[index],
                              loggedInUserId: userDetails!['user_id'],
                            );
                          },
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            height: 90,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
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
                                      controller: replyCont,
                                      textCapitalization: TextCapitalization.sentences,
                                      minLines: 1,
                                      maxLines: 100,
                                      decoration: const InputDecoration.collapsed(
                                        hintText: "Reply to this comment",
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
                                    var replyPosted = await ref.read(
                                      postReplyProvider(
                                        commentText: replyCont!.text,
                                        threadId: threadId,
                                        userId: userDetails!['user_id'],
                                        replyId: comments.id,
                                      ).future,
                                    );
                                    if (replyPosted == true) {
                                      if (comments.userId != userDetails['user_id']) {
                                        await ref.read(postNewNotificationProvider(
                                          requestBody: {
                                            "type": 'comment reply',
                                            "sender_id": userDetails['user_id'],
                                            "sender_name": userDetails['user_name'],
                                            "receiver_id": comments.userId,
                                            "notification": "${userDetails['user_name']} replied on your comment.",
                                            "thread_id": threadId,
                                            "reply_id": comments.id,
                                          },
                                        ).future);
                                      }
                                      replyCont.clear();
                                    }
                                    ref.invalidate(getAllReplyOnCommentProvider(commentId: comments.id));
                                    ref.invalidate(getAllCommentsProvider(threadId: threadId));
                                  },
                                  child: Text(
                                    "Reply",
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
                        ),
                      )
                    ],
                  ),
                );
              },
              error: (error, stackTrace) {
                return Center(child: Text('Error: $error'));
              },
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          },
        ),
      );
    },
  );
}
