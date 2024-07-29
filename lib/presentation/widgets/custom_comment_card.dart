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
  });

  final Function(CommentModel?) onCommentTap;
  final Function(CommentModel?) onLikeTap;
  final Function(CommentModel?) onDMTap;
  final CommentModel? commentModel;
  final String? loggedInUserId;
  final bool? isReplies;
  final bool isUserTrue;

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
            mainAxisAlignment: commentModel!.userId == loggedInUserId ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commentModel!.userId != loggedInUserId
                  ? GestureDetector(
                      onTap: () {
                        if (isUserTrue != true) {
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
                        child: NetworkCommentAvatar(
                          userColor: userColor,
                          commentModel: commentModel,
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
                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
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
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
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
                            maxLines: 5000,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              commentModel!.userId == loggedInUserId
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: NetworkCommentAvatar(
                        userColor: userColor,
                        commentModel: commentModel,
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
                  isLiked: commentModel?.likeObj?.id != null ? true : false,
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

class NetworkCommentAvatar extends ConsumerWidget {
  const NetworkCommentAvatar({
    super.key,
    required this.userColor,
    required this.commentModel,
  });

  final Color userColor;

  final CommentModel? commentModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _initializeCommentImageProviders(ref, commentModel!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final avatarName = snapshot.data?.avatarSrc;
          return CircleAvatar(
            backgroundColor: userColor,
            backgroundImage: avatarName != null && avatarName != '' ? CachedNetworkImageProvider(avatarName) : null,
            radius: 15 * ScaleSize.textScaleFactor(context),
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
      if (commentModel.avatarSrc != null && commentModel.avatarSrc != '') {
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
              color: Colors.grey,
              size: 18 * ScaleSize.textScaleFactor(context),
            ),
            const SizedBox(width: 5),
            Text(
              iconLabel ?? "",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
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
                    color: Colors.grey,
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
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
            ),
          ],
        ),
      ),
    );
  }
}
