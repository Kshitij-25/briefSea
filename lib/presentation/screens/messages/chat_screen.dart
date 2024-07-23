import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../data/models/chat_message_model.dart';
import '../../../data/models/chat_user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/messages_list_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/socket_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
    required this.chatUser,
  });

  static const routeName = "/chatScreen";

  final ChatUserModel chatUser;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController sendMessage = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    sendMessage.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatMessageState = ref.watch(chatMessagesProvider(widget.chatUser.conversationId));
    final userData = ref.watch(userDetailsProvider);
    final sendMsg = ref.read(sendMessageProvider);
    ref.read(socketEventListenerProvider(widget.chatUser.conversationId!));

    // Scroll to the bottom when messages are updated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chatMessageState.chatMessages != null) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          widget.chatUser.name ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
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
            color: Theme.of(context).colorScheme.secondary,
          ),
          Container(
            height: ScreenSize.height(context),
            width: ScreenSize.width(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (chatMessageState.isLoading)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  if (chatMessageState.error != null)
                    Center(
                      child: Text(chatMessageState.error!),
                    ),
                  if (chatMessageState.chatMessages != null && chatMessageState.chatMessages!.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          "Directly Chat and work with\ntop freelancers, vendors and working professionals.",
                          textAlign: TextAlign.center,
                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                        ),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: chatMessageState.chatMessages?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (chatMessageState.chatMessages?[index].senderId == userData['user_id']) {
                          return _SentMessage(
                            message: chatMessageState.chatMessages?[index].messageText ?? "",
                          );
                        } else {
                          return _ReceivedMessage(
                            message: chatMessageState.chatMessages?[index].messageText ?? "",
                          );
                        }
                      },
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        border: Border(
                          top: BorderSide(color: Colors.black26),
                        ),
                      ),
                      child: Row(
                        children: [
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: const Icon(CupertinoIcons.photo),
                          // ),
                          Expanded(
                            child: TextField(
                              controller: sendMessage,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration.collapsed(
                                hintText: "Send a message...",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                            ),
                          ),
                          IconButton(
                            enableFeedback: true,
                            onPressed: () async {
                              DateTime now = DateTime.now();
                              String formattedTime = DateFormat('MM/d/yyyy, hh:mm:ss a').format(now);
                              final chatNotifier = ref.read(chatMessagesProvider(widget.chatUser.conversationId).notifier);
                              if (sendMessage.text.isNotEmpty) {
                                sendMsg(
                                  widget.chatUser.conversationId!,
                                  sendMessage.text,
                                  widget.chatUser.id!,
                                  userData['user_id']!,
                                  formattedTime,
                                );
                                var isMessageSend = await ref.read(
                                  sendChatMessagesProvider(
                                    conversationId: widget.chatUser.conversationId!,
                                    messageText: sendMessage.text,
                                    receiverId: widget.chatUser.id!,
                                    senderId: userData['user_id']!,
                                    typedAt: formattedTime,
                                  ).future,
                                );
                                if (isMessageSend == true) {
                                  if (widget.chatUser.isUserOnline != true) {
                                    chatNotifier.updateMessage(ChatMessageModel(
                                      messageText: sendMessage.text,
                                      conversationId: widget.chatUser.conversationId!,
                                      receiverId: widget.chatUser.id!,
                                      typedAt: formattedTime,
                                      senderId: userData['user_id']!,
                                    ));
                                    sendMessage.clear();
                                    ref.invalidate(getChatUsersListProvider(userId: ref.read(userDetailsProvider)['user_id']!));
                                    await ref.read(
                                      postNewNotificationProvider(
                                        requestBody: {
                                          "type": 'message received',
                                          "sender_id": userData['user_id'],
                                          "sender_name": userData['user_name'],
                                          "receiver_id": widget.chatUser.id,
                                          "notification": "New message received from ${userData['user_name']}.",
                                          "conversation_id": widget.chatUser.conversationId,
                                        },
                                      ).future,
                                    );
                                  }
                                }
                              }
                            },
                            icon: Icon(
                              CupertinoIcons.arrow_up_circle_fill,
                              size: 30 * ScaleSize.textScaleFactor(context),
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
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 14 * ScaleSize.textScaleFactor(context),
                    ),
                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 18.0, left: 50, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 14 * ScaleSize.textScaleFactor(context),
                    ),
                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 50.0, left: 18, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
