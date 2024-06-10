import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/screen_size.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const routeName = "/chatScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B26FD),
        title: const Text(
          "Chat",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            color: const Color(0xFF4B26FD),
          ),
          Container(
            height: ScreenSize.height(context),
            width: ScreenSize.width(context),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const Expanded(
                  child: Text("No messages"),
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 70,
                    color: Colors.white,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.photo),
                        ),
                        const Expanded(
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration.collapsed(
                              hintText: "Send a message...",
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.arrow_up_circle_fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
