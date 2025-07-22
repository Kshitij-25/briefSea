import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../common/app_utils/screen_size.dart';
import '../../data/models/comment_model.dart';
import '../../data/models/image_model.dart';
import '../providers/user_profile_provider.dart';
import '../screens/profile/profile_screen.dart';
import 'linkable_text.dart';

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
    this.onSelected,
    this.width,
    this.isCommentReply = false,
    this.isAuthor = false,
  });

  final Function(CommentModel?) onCommentTap;
  final Function(CommentModel?) onLikeTap;
  final Function(CommentModel?) onDMTap;
  final Function(String)? onSelected;
  final CommentModel? commentModel;
  final String? loggedInUserId;
  final bool? isReplies;
  final bool isUserTrue;
  final bool? isCommentReply;
  final bool? isAuthor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    math.Random random = math.Random(commentModel?.userId.hashCode);
    Color userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7);
    if (commentModel == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: commentModel!.userId == loggedInUserId ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: isCommentReply == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              (commentModel!.userId != loggedInUserId) || isCommentReply == true
                  ? GestureDetector(
                      onTap: () {
                        if (isUserTrue != true && commentModel!.userId != null) {
                          context.push(
                            ProfileScreen.routeName,
                            extra: {
                              'isOtherProfile': true,
                              'otherUserId': commentModel!.userId,
                            },
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0.0),
                        child: _NetworkCommentAvatar(
                          userColor: userColor,
                          commentModel: commentModel,
                          isCommentReply: isCommentReply,
                        ),
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
                        width: width ?? ScreenSize.width(context) * 0.77,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (isUserTrue != true && commentModel!.userId != null) {
                                      context.push(
                                        ProfileScreen.routeName,
                                        extra: {
                                          'isOtherProfile': true,
                                          'otherUserId': commentModel!.userId,
                                        },
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        commentModel?.name ?? "",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                      ),
                                      if (isAuthor == true)
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.outline,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "AUTHOR",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                          ),
                                        ),
                                      if (commentModel?.isEdited == true)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: CircleAvatar(
                                            radius: 2 * ScaleSize.textScaleFactor(context),
                                            backgroundColor: Theme.of(context).colorScheme.outline,
                                          ),
                                        ),
                                      if (commentModel?.isEdited == true)
                                        Text(
                                          "Edited",
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.outline,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                        ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Posting as ${commentModel?.type?[0].toUpperCase()}${commentModel?.type?.substring(1) ?? ""}",
                                  style: const TextStyle(
                                    color: Color(0xFF4A26FE),
                                    fontSize: 11,
                                  ),
                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              timeago.format(DateTime.fromMillisecondsSinceEpoch(commentModel!.postedAt!), locale: 'en_short'),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.outline),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                            ),
                            if ((commentModel!.userId == loggedInUserId && isCommentReply != true) || (isUserTrue == true && isCommentReply != true))
                              PopupMenuButton(
                                enableFeedback: true,
                                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                icon: Icon(
                                  CupertinoIcons.chevron_down,
                                  color: Theme.of(context).colorScheme.outline,
                                  size: 14 * ScaleSize.textScaleFactor(context),
                                ),
                                itemBuilder: (context) {
                                  return <PopupMenuEntry<String>>[
                                    if (commentModel!.userId == loggedInUserId)
                                      PopupMenuItem<String>(
                                        value: 'edit',
                                        child: Text(
                                          isReplies == true ? 'Edit Reply' : 'Edit Comment',
                                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                        ),
                                      ),
                                    PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Text(
                                        isReplies == true ? 'Delete Reply' : 'Delete Comment',
                                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                      ),
                                    ),
                                  ];
                                },
                                onSelected: onSelected,
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
                        width: width ?? ScreenSize.width(context) * 0.77,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: LinkableText(
                            text: commentModel?.commentText ?? "",
                            maxLines: 5000,
                            style1: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: 14 * ScaleSize.textScaleFactor(context),
                                ),
                            style2: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: 14 * ScaleSize.textScaleFactor(context),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (commentModel!.userId == loggedInUserId) && isCommentReply != true
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: _NetworkCommentAvatar(
                        userColor: userColor,
                        commentModel: commentModel,
                        isCommentReply: isCommentReply,
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
                  isLiked: commentModel?.likeObj?.userId != null ? true : false,
                  iconLabel: (commentModel?.likesCount != null)
                      ? (commentModel!.likesCount! < 1
                          ? 'Like'
                          : commentModel!.likesCount == 1
                              ? '${commentModel!.likesCount} Like'
                              : "${commentModel!.likesCount} Likes")
                      : '-',
                  onPressed: () => onLikeTap(commentModel),
                ),
                _BriefInputButton(
                  iconData: CupertinoIcons.arrowshape_turn_up_left,
                  iconLabel: (commentModel?.replyCount != null)
                      ? (commentModel!.replyCount! < 1
                          ? 'Reply'
                          : commentModel!.replyCount! == 1
                              ? '${commentModel!.replyCount} Reply'
                              : "${commentModel!.replyCount} Replies")
                      : '-',
                  onPressed: () => onCommentTap(commentModel),
                ),
                if (isUserTrue == true && commentModel!.userId != loggedInUserId)
                  _BriefInputButton(
                    iconData: CupertinoIcons.chat_bubble_2,
                    iconLabel: "Chat Now",
                    onPressed: () => onDMTap(commentModel),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _NetworkCommentAvatar extends ConsumerWidget {
  const _NetworkCommentAvatar({
    required this.userColor,
    required this.commentModel,
    this.isCommentReply,
  });

  final Color userColor;

  final CommentModel? commentModel;
  final bool? isCommentReply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _initializeCommentImageProviders(ref, commentModel!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            backgroundColor: userColor,
            radius: isCommentReply == true ? 25 * ScaleSize.textScaleFactor(context) : 15 * ScaleSize.textScaleFactor(context),
          );
        } else if (snapshot.hasError) {
          return Center(child: Icon(Icons.error, color: Colors.red));
        } else {
          final avatarName = snapshot.data?.avatarSrc;
          return CircleAvatar(
            backgroundColor: userColor,
            backgroundImage: avatarName != null && avatarName != ''
                ? CachedNetworkImageProvider(
                    avatarName,
                    cacheKey: avatarName,
                  )
                : null,
            radius: isCommentReply == true ? 25 * ScaleSize.textScaleFactor(context) : 15 * ScaleSize.textScaleFactor(context),
            child: avatarName == null || avatarName == ''
                ? Text(
                    commentModel?.name?[0] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  )
                : const SizedBox.shrink(),
          );
        }
      },
    );
  }

  Future<CommentModel?> _initializeCommentImageProviders(WidgetRef ref, CommentModel commentModel) async {
    try {
      if (commentModel.avatarSrc != null && commentModel.avatarSrc != '' && !commentModel.avatarSrc!.contains('https')) {
        ImageModel avatarUrl = await ref.watch(UserProfileProvider.getImageProvider(commentModel.avatarSrc!).future);
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
    return InkWell(
      enableFeedback: true,
      onTap: onPressed,
      child: Container(
        child: Row(
          children: [
            Icon(
              iconData,
              color: Theme.of(context).colorScheme.outline,
              size: 18 * ScaleSize.textScaleFactor(context),
            ),
            const SizedBox(width: 5),
            Text(
              iconLabel ?? "",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
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
    return InkWell(
      enableFeedback: true,
      onTap: onPressed,
      child: Container(
        child: Row(
          children: [
            !isLiked
                ? Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).colorScheme.outline,
                    size: 18 * ScaleSize.textScaleFactor(context),
                  )
                : Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.red,
                    size: 18 * ScaleSize.textScaleFactor(context),
                  ),
            const SizedBox(width: 5),
            Text(
              iconLabel ?? "",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
            ),
          ],
        ),
      ),
    );
  }
}
