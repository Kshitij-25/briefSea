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
    DateTime dateTime = DateTime.parse(notificationModel.createdAt ?? "");
    math.Random random = math.Random(notificationModel.senderId?.hashCode);
    Color userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(notificationModel.createdAt ?? DateTime.now().toString()), // Ensure unique key for each item
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
      child: ListTile(
        tileColor: Colors.white,
        onTap: onTap,
        leading: CircleAvatar(
          radius: 25 * ScaleSize.textScaleFactor(context),
          backgroundColor: userColor,
          backgroundImage: notificationModel.avatar != null && notificationModel.avatar != ''
              ? CachedNetworkImageProvider(
                  notificationModel.avatar!,
                  cacheKey: notificationModel.avatar!,
                )
              : null,
          child: notificationModel.avatar == null || notificationModel.avatar == ''
              ? Text(
                  notificationModel.senderName?[0] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                )
              : SizedBox.shrink(),
        ),
        title: Text(
          notificationModel.senderName ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
        ),
        subtitle: Text(
          notificationModel.notification ?? '',
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
        ),
        trailing: Text(
          timeago.format(dateTime, locale: 'en_short'),
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
        ),
        // trailing: Text(
        //   DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(notificationModel.notifiedAt ?? 0)),
        //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
        //         color: Theme.of(context).colorScheme.onSurface,
        //       ),
        // ),
      ),
    );
  }
}
