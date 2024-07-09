import 'dart:math' as math;

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
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: userColor,
              child: Text(
                chatUserModel?.name?[0].toUpperCase() ?? "",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 15,
                height: 15,
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
        // leading: CircleAvatar(
        //   backgroundColor: const Color(0xFF1B0C6B),
        //   child: Text(
        //     chatName?[0].toUpperCase() ?? "",
        //     style: const TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        title: Text(
          chatUserModel?.name ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          chatUserModel?.lastMsg ?? '...',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(),
        ),
      ),
    );
  }
}
