import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../common/app_utils/screen_size.dart';
import '../../data/models/comment_model.dart';

class CustomCommentCard extends StatelessWidget {
  const CustomCommentCard({
    super.key,
    required this.onCommentTap,
    required this.onLikeTap,
    required this.onDMTap,
    this.commentModel,
    this.loggedInUserId,
    this.isReplies,
    required this.isUserTrue,
    this.avatarName,
  });

  final Function(CommentModel?) onCommentTap;
  final Function(CommentModel?) onLikeTap;
  final Function(CommentModel?) onDMTap;
  final CommentModel? commentModel;
  final String? loggedInUserId;
  final bool? isReplies;
  final bool isUserTrue;
  final String? avatarName;

  @override
  Widget build(BuildContext context) {
    math.Random random = math.Random(commentModel?.userId.hashCode);
    Color userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    if (commentModel == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commentModel!.userId != loggedInUserId
                  ? Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: CircleAvatar(
                        backgroundColor: userColor,
                        backgroundImage: avatarName != null && avatarName != '' ? NetworkImage(avatarName!) : null,
                        radius: 15,
                        child: avatarName == null || avatarName == ''
                            ? Text(
                                commentModel?.name?[0] ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    )
                  : const SizedBox.shrink(),
              Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: ScreenSize.width(context) * 0.77,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  commentModel?.name ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Posting as ${commentModel?.type ?? ""}",
                                  style: const TextStyle(
                                    color: Color(0xFF4A26FE),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              timeago.format(DateTime.fromMillisecondsSinceEpoch(commentModel!.postedAt!), locale: 'en_short'),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   "Posting as $postingAs",
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //   ),
                      // ),
                      SizedBox(
                        width: ScreenSize.width(context) * 0.77,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            commentModel?.commentText ?? "",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              commentModel!.userId == loggedInUserId
                  ? Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: CircleAvatar(
                        backgroundColor: userColor,
                        backgroundImage: avatarName != null && avatarName != '' ? NetworkImage(avatarName!) : null,
                        radius: 15,
                        child: avatarName == null || avatarName == ''
                            ? Text(
                                commentModel?.name?[0] ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          if (isReplies != true)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _BriefLikeButton(
                  isLiked: commentModel!.isCommentLiked,
                  iconLabel:
                      (commentModel?.likesCount != null) ? (commentModel!.likesCount == 0 ? 'Like' : "${commentModel!.likesCount} Likes") : '-',
                  onPressed: () => onLikeTap(commentModel),
                ),
                _BriefInputButton(
                  iconData: CupertinoIcons.arrowshape_turn_up_left,
                  iconLabel:
                      (commentModel!.replyCount != null) ? (commentModel!.replyCount == 0 ? 'Reply' : "${commentModel!.replyCount} Reply") : '-',
                  onPressed: () => onCommentTap(commentModel),
                ),
                if (isUserTrue == true && commentModel!.userId != loggedInUserId)
                  _BriefInputButton(
                    iconData: CupertinoIcons.envelope_open_fill,
                    iconLabel: "DM",
                    onPressed: () => onDMTap(commentModel),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _BriefInputButton extends StatelessWidget {
  const _BriefInputButton({
    this.onPressed,
    required this.iconData,
    this.iconLabel,
  });

  final void Function()? onPressed;
  final IconData iconData;
  final String? iconLabel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.grey,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              iconLabel ?? "",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BriefLikeButton extends StatelessWidget {
  const _BriefLikeButton({
    this.onPressed,
    this.iconLabel,
    this.isLiked = false,
  });

  final void Function()? onPressed;
  final String? iconLabel;
  final bool isLiked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Row(
          children: [
            !isLiked
                ? const Icon(
                    CupertinoIcons.heart,
                    color: Colors.grey,
                    size: 18,
                  )
                : const Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.red,
                    size: 18,
                  ),
            const SizedBox(width: 5),
            Text(
              iconLabel ?? "",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
