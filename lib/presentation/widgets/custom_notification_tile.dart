import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../common/app_utils/screen_size.dart';
import '../../data/models/notification_model.dart';

class CustomNotificationTile extends StatelessWidget {
  const CustomNotificationTile({
    super.key,
    required this.notificationModel,
    required this.confirmDismiss,
    this.onDismissed,
    this.onTap,
  });

  final NotificationModel notificationModel;
  final Future<bool> Function() confirmDismiss;
  final VoidCallback? onDismissed;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    math.Random random = math.Random(notificationModel.senderId?.hashCode);
    Color userColor = Color(
      (random.nextDouble() * 0xFFFFFF).toInt(),
    ).withOpacity(0.7);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(
        notificationModel.createdAt ?? DateTime.now().toString(),
      ), // Ensure unique key for each item
      confirmDismiss: (direction) async {
        return await confirmDismiss();
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDismissed;
        }
      },
      background: Container(
        color: Colors.white,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: notificationModel.isViewed == true
              ? Theme.of(context).colorScheme.surfaceContainerLowest
              : Theme.of(context).colorScheme.primaryFixed,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (notificationModel.isClicked != true)
                      CircleAvatar(
                        radius: 5 * ScaleSize.textScaleFactor(context),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.inverseSurface,
                      ),
                    SizedBox(
                      width: notificationModel.isClicked != true ? 10 : 20,
                    ),
                    CircleAvatar(
                      radius: 25 * ScaleSize.textScaleFactor(context),
                      backgroundColor: userColor,
                      backgroundImage:
                          notificationModel.avatar != null &&
                              notificationModel.avatar != ''
                          ? CachedNetworkImageProvider(
                              notificationModel.avatar!,
                              cacheKey: notificationModel.avatar!,
                            )
                          : null,
                      child:
                          notificationModel.avatar == null ||
                              notificationModel.avatar == ''
                          ? Text(
                              notificationModel.senderName?[0] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              textScaler: TextScaler.linear(
                                ScaleSize.textScaleFactor(context),
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: ScreenSize.width(context) * 0.6,
                      child: Text(
                        notificationModel.notification ?? '',
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textScaler: TextScaler.linear(
                          ScaleSize.textScaleFactor(context),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      timeago.format(
                        DateTime.fromMillisecondsSinceEpoch(
                          notificationModel.notifiedAt!,
                        ),
                        locale: 'en_short',
                      ),
                      style: const TextStyle(color: Colors.black),
                      textScaler: TextScaler.linear(
                        ScaleSize.textScaleFactor(context),
                      ),
                    ),
                  ],
                ),
                if (notificationModel.briefText != null &&
                        notificationModel.briefText != '' ||
                    notificationModel.commentText != null &&
                        notificationModel.commentText != '')
                  Container(
                    margin: EdgeInsets.only(
                      left: 80 * ScaleSize.textScaleFactor(context),
                    ),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceDim,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      notificationModel.briefText ??
                          notificationModel.commentText ??
                          '',
                      style: const TextStyle(color: Colors.black),
                      textScaler: TextScaler.linear(
                        ScaleSize.textScaleFactor(context),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
