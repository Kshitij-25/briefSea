import 'dart:math' as math;

import 'package:briefsea/common/app_utils/screen_size.dart';
import 'package:flutter/material.dart';

import '../../data/models/chat_user_model.dart';

class CustomChatCards extends StatelessWidget {
  const CustomChatCards({
    super.key,
    this.onTap,
    this.chatUserModel,
    this.isUserOnline,
  });

  final void Function()? onTap;
  // final String? chatName;
  // final String? chatMessage;
  final bool? isUserOnline;
  final ChatUserModel? chatUserModel;

  @override
  Widget build(BuildContext context) {
    math.Random random = math.Random(chatUserModel?.id?.hashCode);
    Color userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 25 * ScaleSize.textScaleFactor(context),
              backgroundColor: userColor,
              child: Text(
                chatUserModel?.name?[0].toUpperCase() ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 15 * ScaleSize.textScaleFactor(context),
                height: 15 * ScaleSize.textScaleFactor(context),
                decoration: BoxDecoration(
                  color: isUserOnline == true ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 3,
                  ),
                ),
              ),
            )
          ],
        ),
        title: Text(
          chatUserModel?.name ?? '',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
        ),
        subtitle: Text(
          chatUserModel?.lastMsg ?? '...',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
        ),
      ),
    );
  }
}
