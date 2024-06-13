import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../common/screen_size.dart';
import '../../data/models/comment_model.dart';

class CustomCommentCard extends StatelessWidget {
  const CustomCommentCard({
    super.key,
    required this.onCommentTap,
    required this.onLikeTap,
    required this.onShareTap,
    this.commentModel,
    this.loggedInUserId,
    this.isReplies,
  });

  final Function(CommentModel?) onCommentTap;
  final Function(CommentModel?) onLikeTap;
  final Function(CommentModel?) onShareTap;
  final CommentModel? commentModel;
  final String? loggedInUserId;
  final bool? isReplies;

  @override
  Widget build(BuildContext context) {
    if (commentModel == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commentModel!.userId != loggedInUserId
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF1B0C6B),
                        radius: 15,
                        child: Text(
                          commentModel?.name?[0] ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textScaler: const TextScaler.linear(0.8),
                        ),
                        // backgroundImage: NetworkImage('${ApiConstants.BASE_URL}/$imgSrc'),
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
                            Text(
                              commentModel?.name ?? "",
                              style: const TextStyle(
                                color: Color(0xFF33BBE7),
                              ),
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
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF1B0C6B),
                        radius: 15,
                        child: Text(
                          commentModel?.name?[0] ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textScaler: const TextScaler.linear(0.8),
                        ),
                        // backgroundImage: NetworkImage('${ApiConstants.BASE_URL}/$imgSrc'),
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
                // _BriefInputButton(
                //   iconData: CupertinoIcons.arrowshape_turn_up_right,
                //   iconLabel: "Share",
                //   onPressed: () => onShareTap(commentModel),
                // ),
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
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        elevation: WidgetStateProperty.all<double>(0),
      ),
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: Colors.grey,
      ),
      label: Text(
        iconLabel ?? "",
        style: const TextStyle(color: Colors.grey),
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
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        elevation: WidgetStateProperty.all<double>(0),
      ),
      onPressed: onPressed,
      icon: !isLiked
          ? const Icon(
              CupertinoIcons.heart,
              color: Colors.grey,
            )
          : const Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
            ),
      label: Text(
        iconLabel ?? "",
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
