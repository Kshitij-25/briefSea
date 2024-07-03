import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomChatCards extends StatelessWidget {
  const CustomChatCards({
    super.key,
    this.onTap,
    this.chatName,
    this.chatMessage,
    this.isUserOnline,
  });

  final void Function()? onTap;
  final String? chatName;
  final String? chatMessage;
  final bool? isUserOnline;

  @override
  Widget build(BuildContext context) {
    math.Random random = math.Random(chatName?.hashCode);
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
                chatName?[0].toUpperCase() ?? "",
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
          chatName ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          chatMessage ?? '...',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(),
        ),
      ),
    );
  }
}
