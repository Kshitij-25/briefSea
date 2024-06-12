import 'package:briefsea/presentation/providers/chat_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/screen_size.dart';
import '../../../data/models/chat_message_model.dart';
import '../../../data/models/chat_user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/socket_provider.dart';

class ChatScreen extends ConsumerWidget {
  ChatScreen({
    super.key,
    required this.chatUser,
  });

  static const routeName = "/chatScreen";

  final ChatUserModel chatUser;

  final TextEditingController sendMessage = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatMessage = ref.watch(getChatMessagesProvider(conversationId: chatUser.conversationId!));
    final userData = ref.watch(userDetailsProvider);
    final socket = ref.watch(socketProvider);

    // Listen to incoming messages via Socket.IO
    socket.on('message', (data) {
      // Convert data to the message model (if needed)
      ChatMessageModel message = ChatMessageModel.fromJson(data);

      // Update UI with new message
      // You can update the UI by adding the new message to the list of messages
      // Assuming you have a list of messages and a method to add messages to that list
      // You can use ref.read to get the message list provider and update it accordingly
      // ref.read(chatMessagesListProvider).addMessage(message);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B26FD),
        title: Text(
          chatUser.name ?? "",
          style: const TextStyle(
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
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Expanded(
                    child: chatMessage.when(
                      data: (messages) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            if (messages[index].senderId == userData['user_id']) {
                              return _SentMessage(
                                message: messages[index].messageText ?? "",
                              );
                            } else {
                              return _ReceivedMessage(
                                message: messages[index].messageText ?? "",
                              );
                            }
                          },
                        );
                      },
                      error: (error, stackTrace) {
                        return Center(child: Text('Error: $error'));
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
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
                          Expanded(
                            child: TextField(
                              controller: sendMessage,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration.collapsed(
                                hintText: "Send a message...",
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              DateTime now = DateTime.now();
                              String formattedTime = DateFormat('MM/d/yyyy, hh:mm:ss a').format(now);
                              if (sendMessage.text.isNotEmpty) {
                                // Emit message through Socket.IO
                                // socket.emit('message', {
                                //   'conversation_id': chatUser.conversationId!,
                                //   'message': sendMessage.text,
                                //   'receiver_d': chatUser.id!,
                                //   'sender_id': userData['user_id']!,
                                //   'typedAt': formattedTime,
                                // });
                                var isMessageSend = await ref.read(
                                  sendChatMessagesProvider(
                                    conversationId: chatUser.conversationId!,
                                    messageText: sendMessage.text,
                                    receiverId: chatUser.id!,
                                    senderId: userData['user_id']!,
                                    typedAt: formattedTime,
                                  ).future,
                                );
                                if (isMessageSend == true) {
                                  sendMessage.clear();
                                  ref.invalidate(getChatMessagesProvider(conversationId: chatUser.conversationId!));
                                }
                              }
                            },
                            icon: const Icon(
                              CupertinoIcons.arrow_up_circle_fill,
                              size: 30,
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
          ),
        ],
      ),
    );
  }
}

class _SentMessage extends StatelessWidget {
  const _SentMessage({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    ));

    return Padding(
      padding: const EdgeInsets.only(right: 18.0, left: 50, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}

class _ReceivedMessage extends StatelessWidget {
  const _ReceivedMessage({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
    ));

    return Padding(
      padding: const EdgeInsets.only(right: 50.0, left: 18, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
