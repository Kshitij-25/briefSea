import 'dart:math' as math;

import 'package:briefsea/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../common/app_utils/screen_size.dart';
import '../../data/models/briefs_model.dart';

class CustomBriefsCard extends StatelessWidget {
  const CustomBriefsCard({
    super.key,
    this.brief,
    required this.onCommentTap,
    required this.onLikeTap,
    required this.onShareTap,
    this.onTap,
    this.cardVisible = true,
    this.maxLine,
    this.postImage,
    required this.isUserTrue,
    this.onSelected,
    this.avatarName,
  });

  final Function(BriefsModel?) onCommentTap;
  final Function(BriefsModel?) onLikeTap;
  final Function(BriefsModel?) onShareTap;
  final Function(String)? onSelected;
  final VoidCallback? onTap;
  final BriefsModel? brief;
  final bool cardVisible;
  final int? maxLine;
  final String? postImage;
  final String? avatarName;
  final bool isUserTrue;

  @override
  Widget build(BuildContext context) {
    math.Random random = math.Random(brief?.userId.hashCode);
    Color userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    if (brief == null) {
      return const SizedBox();
    }
    return InkWell(
      onTap: onTap,
      child: _BriefCard(
        isCardVisible: cardVisible,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isUserTrue != true) {
                        context.push(
                          ProfileScreen.routeName,
                          extra: {
                            'isOtherProfile': true,
                            'otherUserId': brief!.userId,
                          },
                        );
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: userColor,
                      backgroundImage: avatarName != null && avatarName != '' ? NetworkImage(avatarName!) : null,
                      radius: 25 * ScaleSize.textScaleFactor(context),
                      child: avatarName == null || avatarName == ''
                          ? Text(
                              brief?.name?[0] ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${brief?.name?[0].toUpperCase()}${brief?.name?.substring(1) ?? ""}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                      Text(
                        "Posting as ${brief?.type?[0].toUpperCase()}${brief?.type?.substring(1) ?? ""}",
                        style: const TextStyle(
                          color: Color(0xFF4A26FE),
                          fontSize: 11,
                        ),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                      Text(
                        brief?.category ?? "",
                        style: const TextStyle(
                          color: Color(0xFF4A26FE),
                          fontSize: 11,
                        ),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    brief?.postedAt != null ? timeago.format(DateTime.fromMillisecondsSinceEpoch(brief!.postedAt!), locale: 'en_short') : '',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  ),
                  if (isUserTrue != false)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: PopupMenuButton(
                        enableFeedback: true,
                        color: Colors.white,
                        icon: const Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.grey,
                        ),
                        itemBuilder: (context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'edit',
                              child: Text(
                                'Edit Brief',
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'visible',
                              child: Text(
                                brief?.isVisible == true ? 'Make it Private' : 'Make it Public',
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: Text(
                                'Delete Brief',
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              ),
                            ),
                          ];
                        },
                        onSelected: onSelected,
                      ),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  brief?.postText ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  maxLines: maxLine ?? 6,
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (cardVisible == false && brief?.imgSrc != null && (brief?.imgSrc != ""))
                Container(
                  height: 300,
                  width: 300,
                  color: const Color(0xFF1B0C6B),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BriefLikeButton(
                    isLiked: brief!.isPostLiked,
                    iconLabel: (brief?.likesCount != null) ? (brief!.likesCount == 0 ? 'Like' : "${brief!.likesCount} Likes") : '-',
                    onPressed: () => onLikeTap(brief),
                  ),
                  _BriefInputButton(
                    iconData: CupertinoIcons.chat_bubble,
                    iconLabel: (brief?.replyCount != null) ? (brief!.replyCount == 0 ? 'Comment' : "${brief!.replyCount} Comments") : '-',
                    onPressed: () => onCommentTap(brief),
                  ),
                  _BriefInputButton(
                    iconData: CupertinoIcons.arrowshape_turn_up_right,
                    iconLabel: "Share",
                    onPressed: () => onShareTap(brief),
                  ),
                ],
              ),
            ],
          ),
        ),
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

class _BriefCard extends StatelessWidget {
  const _BriefCard({
    required this.child,
    this.isCardVisible = true,
  });

  final Widget child;
  final bool isCardVisible;

  @override
  Widget build(BuildContext context) {
    if (isCardVisible) {
      return Card(
        color: Colors.white,
        child: child,
      );
    } else {
      return child;
    }
  }
}
