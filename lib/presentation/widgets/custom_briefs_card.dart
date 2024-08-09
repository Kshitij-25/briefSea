import 'dart:math' as math hide log;

import 'package:briefsea/presentation/screens/profile/profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../common/app_utils/screen_size.dart';
import '../../data/models/briefs_result.dart';
import '../../data/models/image_model.dart';
import '../providers/user_profile_provider.dart';
import 'linkable_text.dart';

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
  });

  final Function(BriefsResult?) onCommentTap;
  final Function(BriefsResult?) onLikeTap;
  final Function(BriefsResult?) onShareTap;
  final Function(String)? onSelected;
  final VoidCallback? onTap;
  final BriefsResult? brief;
  final bool cardVisible;
  final int? maxLine;
  final String? postImage;
  final bool isUserTrue;

  @override
  Widget build(BuildContext context) {
    math.Random random = math.Random(brief?.userId.hashCode);
    Color userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7);
    if (brief == null) {
      return const SizedBox();
    }
    // log("${brief?.likeObj?.userId}" + '${brief?.likeObj?.name}');
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
                    child: NetworkAvatarWidget(
                      userColor: userColor,
                      brief: brief,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Text(
                          '${brief?.name?[0].toUpperCase()}${brief?.name?.substring(1) ?? ""}',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                        ),
                      ),
                      Text(
                        "Posting as ${brief?.type?[0].toUpperCase()}${brief?.type?.substring(1) ?? ""}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                      Text(
                        brief?.category ?? "",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      )
                    ],
                  ),
                  const Spacer(),
                  if (isUserTrue != false && cardVisible == true)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: PopupMenuButton(
                        enableFeedback: true,
                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                        icon: Icon(
                          CupertinoIcons.chevron_down,
                          color: Theme.of(context).colorScheme.outline,
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
                    ),
                  Text(
                    brief?.postedAt != null ? timeago.format(DateTime.fromMillisecondsSinceEpoch(brief!.postedAt!), locale: 'en_short') : '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.outline),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: LinkableText(
                  text: brief?.postText ?? "",
                  maxLines: maxLine ?? 6,
                  style1: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  style2: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
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
                    isLiked: brief?.likeObj?.userId != null ? true : false,
                    iconLabel: (brief?.likesCount != null) ? (brief!.likesCount! < 1 ? 'Like' : "${brief!.likesCount} Likes") : '-',
                    onPressed: () => onLikeTap(brief),
                  ),
                  _BriefInputButton(
                    iconData: CupertinoIcons.chat_bubble,
                    iconLabel: (brief?.replyCount != null) ? (brief!.replyCount! < 1 ? 'Comment' : "${brief!.replyCount} Comments") : '-',
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

class NetworkAvatarWidget extends ConsumerWidget {
  const NetworkAvatarWidget({
    super.key,
    required this.userColor,
    required this.brief,
  });

  final Color userColor;
  final BriefsResult? brief;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            backgroundColor: userColor,
            radius: 25 * ScaleSize.textScaleFactor(context),
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
            radius: 25 * ScaleSize.textScaleFactor(context),
            child: avatarName == null || avatarName == ''
                ? Text(
                    brief?.name?[0] ?? "",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 22,
                        ),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  )
                : const SizedBox.shrink(),
          );
        }
      },
      future: _initializeImageProviders(ref, brief!),
    );
  }

  Future<BriefsResult?> _initializeImageProviders(WidgetRef ref, BriefsResult briefModel) async {
    try {
      if (briefModel.avatarSrc != null && briefModel.avatarSrc != '') {
        ImageModel avatarUrl = await ref.watch(UserProfileProvider.getImageProvider(briefModel.avatarSrc!).future);
        if (avatarUrl.url != null && avatarUrl.url != '') {
          briefModel = briefModel.copyWith(avatarSrc: avatarUrl.url);
        }
      }

      if (briefModel.imgSrc != null && briefModel.imgSrc != '') {
        ImageModel postImage = await ref.watch(UserProfileProvider.getImageProvider(briefModel.imgSrc!).future);
        if (postImage.url != null && postImage.url != '') {
          briefModel = briefModel.copyWith(imgSrc: postImage.url);
        }
      }

      return briefModel;
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
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
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
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: child,
      );
    } else {
      return child;
    }
  }
}
