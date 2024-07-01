import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../data/models/notification_model.dart';

class CustomNotificationTile extends StatelessWidget {
  const CustomNotificationTile({
    super.key,
    required this.notificationModel,
    required this.confirmDismiss,
    this.onDismissed,
  });

  final NotificationModel notificationModel;
  final Future<bool> Function() confirmDismiss;
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(notificationModel.createdAt ?? "");
    math.Random random = math.Random(notificationModel.senderId?.hashCode);
    Color userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    return Dismissible(
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
        color: Colors.red,
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
        leading: CircleAvatar(
          backgroundColor: userColor,
          child: Text(
            notificationModel.senderName?[0] ?? '',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          notificationModel.senderName ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(notificationModel.notification ?? ''),
        trailing: Text(
          timeago.format(dateTime, locale: 'en_short'),
        ),
      ),
    );
  }
}
