import 'package:flutter/material.dart';

class CustomChatCards extends StatelessWidget {
  const CustomChatCards({
    super.key,
    this.onTap,
    this.chatName,
    this.chatMessage,
  });

  final void Function()? onTap;
  final String? chatName;
  final String? chatMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF1B0C6B),
        ),
        title: Text(
          chatName!,
          style: const TextStyle(
            color: Color(0xFF33BBE7),
          ),
        ),
        subtitle: Text(
          chatMessage!,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
