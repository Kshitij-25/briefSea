import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../data/models/briefs_model.dart';
import '../../data/models/image_model.dart';

class CustomBriefsCard extends StatelessWidget {
  CustomBriefsCard({
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

  final Function(BriefsModel?) onCommentTap;
  final Function(BriefsModel?) onLikeTap;
  final Function(BriefsModel?) onShareTap;
  final Function(String)? onSelected;
  final VoidCallback? onTap;
  final BriefsModel? brief;
  final bool cardVisible;
  final int? maxLine;
  Future<ImageModel>? postImage;
  final bool isUserTrue;

  @override
  Widget build(BuildContext context) {
    if (brief == null) {
      return const SizedBox();
    }
    return InkWell(
      onTap: onTap,
      child: _BriefCard(
        isCardVisible: cardVisible,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF1B0C6B),
                    radius: 25,
                    child: Text(
                      brief?.name?[0] ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textScaler: const TextScaler.linear(1.3),
                    ),
                    // backgroundImage: avatarUrl?.url != "" ? NetworkImage(avatarUrl!.url!) : null,
                  ),
                  // FutureBuilder(
                  //   future: avatarUrl,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const CircularProgressIndicator();
                  //     } else if (snapshot.hasError || !snapshot.hasData) {
                  //       return const Icon(
                  //         CupertinoIcons.camera_fill,
                  //         color: Colors.white,
                  //         size: 30,
                  //       );
                  //     } else {
                  //       return CircleAvatar(
                  //         backgroundImage: NetworkImage(snapshot.data!.url!),
                  //         radius: 70,
                  //       );
                  //     }
                  //   },
                  // ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brief?.name ?? "",
                        style: const TextStyle(
                          color: Color(0xFF33BBE7),
                        ),
                      ),
                      Text(
                        "Posting as a ${brief?.type ?? ""}",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      cardVisible == false
                          ? Text(
                              ">> ${brief?.category ?? ""}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    brief?.postedAt != null ? timeago.format(DateTime.fromMillisecondsSinceEpoch(brief!.postedAt!), locale: 'en_short') : '',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  if (isUserTrue == false)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: PopupMenuButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        itemBuilder: (context) {
                          return <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'message',
                              child: Text('Chat with user'),
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
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // if (cardVisible == false && brief?.imgSrc != null && (brief!.imgSrc != ""))
              //   Container(
              //     height: 300,
              //     width: 300,
              //     color: const Color(0xFF1B0C6B),
              //   ),
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
