import 'package:briefsea/data/data_sources/chat_remote_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/screen_size.dart';
import '../../../data/core/api_client.dart';
import '../../../data/di/get_it.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, this.sendMessage});

  static const routeName = "/chatScreen";

  final Function()? sendMessage;

  @override
  Widget build(BuildContext context) {
    final apiClient = getItInstance<ApiClient>();
    ChatRemoteDataSourceImpl(apiClient).getChatMessages("66669b4b3644b4ea3abe2115");
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
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      border: Border(
                        top: BorderSide(color: Colors.black26),
                      ),
                    ),
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
                          onPressed: sendMessage,
                          icon: const Icon(
                            CupertinoIcons.arrow_up_circle_fill,
                            color: Color(0xFF212121),
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
