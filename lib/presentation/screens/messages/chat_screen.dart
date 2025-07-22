import 'dart:math' as math;
import 'dart:ui';

import 'package:briefsea/presentation/params/chat_params.dart';
import 'package:briefsea/presentation/params/notification_params.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../data/di/get_it.dart';
import '../../../data/models/chat_message_model.dart';
import '../../../data/models/chat_user_model.dart';
import '../../../data/services/notification_service.dart';
import '../../providers/auth_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/messages_list_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/reply_provider.dart';
import '../../providers/socket_provider.dart';
import '../../widgets/linkable_text.dart';
import '../profile/profile_screen.dart';

class ChatScreen extends StatefulHookConsumerWidget {
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
    final isEditMessage = useState(false);
    final initialMessage = useState('');
    final initialMessageId = useState('');

    final chatMessageState = ref.watch(chatMessagesProvider(widget.chatUser.conversationId));
    final userData = ref.watch(userDetailsProvider);
    final sendMsg = ref.read(sendMessageProvider);
    ref.read(socketEventListenerProvider(widget.chatUser.conversationId!));
    final textFieldFocusNode = ref.watch(textFieldFocusNodeProvider);

    // Scroll to the bottom when messages are updated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chatMessageState.chatMessages != null) {
        _scrollToBottom();
      }
    });

    math.Random random = math.Random(widget.chatUser.id?.hashCode);
    Color userColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: GestureDetector(
            onTap: () {
              context.push(
                ProfileScreen.routeName,
                extra: {
                  'isOtherProfile': true,
                  'otherUserId': widget.chatUser.id,
                },
              );
            },
            child: Text(
              widget.chatUser.name ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          // height: ScreenSize.height(context),
          // width: ScreenSize.width(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
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
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (chatMessageState.error != null)
                  Center(
                    child: Text(chatMessageState.error!),
                  ),
                if (chatMessageState.chatMessages != null && chatMessageState.chatMessages!.isEmpty)
                  // Expanded(
                  //   child: Center(
                  //     child: Text(
                  //       "Directly Chat and work with\ntop freelancers, vendors and working professionals.",
                  //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  //             color: Colors.black,
                  //           ),
                  //       textAlign: TextAlign.center,
                  //       textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 60 * ScaleSize.textScaleFactor(context),
                              backgroundColor: userColor,
                              backgroundImage: CachedNetworkImageProvider(
                                widget.chatUser.avatar ?? "",
                              ),
                            ),
                            SizedBox(
                              height: 10 * ScaleSize.textScaleFactor(context),
                            ),
                            Text(
                              widget.chatUser.name ?? "",
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(
                              height: 2 * ScaleSize.textScaleFactor(context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Using Briefsea as: ",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  "${widget.chatUser.type![0].toUpperCase() + widget.chatUser.type!.substring(1)}",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2 * ScaleSize.textScaleFactor(context),
                            ),
                            TextButton(
                              onPressed: () {
                                context.push(
                                  ProfileScreen.routeName,
                                  extra: {
                                    'isOtherProfile': true,
                                    'otherUserId': widget.chatUser.id,
                                  },
                                );
                              },
                              child: Text('View Profile'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                if (chatMessageState.chatMessages != null && !chatMessageState.chatMessages!.isEmpty)
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: chatMessageState.chatMessages?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (chatMessageState.chatMessages?[index].senderId == userData['user_id']) {
                          return _SentMessage(
                            chatMessageModel: chatMessageState.chatMessages?[index],
                            sendMessage: sendMessage,
                            isEditMessage: isEditMessage,
                            initialMessage: initialMessage,
                            initialMessageId: initialMessageId,
                          );
                        } else {
                          return _ReceivedMessage(
                            chatMessageModel: chatMessageState.chatMessages?[index],
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
                      color: Theme.of(context).colorScheme.surfaceContainerLowest,
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 0),
                            child: TextField(
                              controller: sendMessage,
                              focusNode: textFieldFocusNode,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration.collapsed(
                                hintText: "Send a message...",
                                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).hintColor),
                              ),
                              maxLines: 5,
                              minLines: 1,
                              keyboardType: TextInputType.multiline,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        IconButton(
                          enableFeedback: true,
                          onPressed: () async {
                            if (isEditMessage.value == true) {
                              if (initialMessage != sendMessage.text) {
                                // edit message
                              }
                            } else {
                              await _sendTextMessage(sendMsg, userData);
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
      ),
    );
  }

  Future<void> _sendTextMessage(
      Null sendMsg(String conversationId, String message, String receiverId, String senderId, String typedAt), Map<String, String> userData) async {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('MM/d/yyyy, hh:mm:ss a').format(now);
    final chatNotifier = ref.read(chatMessagesProvider(widget.chatUser.conversationId).notifier);
    if (sendMessage.text.trim().isNotEmpty) {
      sendMsg(
        widget.chatUser.conversationId!,
        sendMessage.text.trim(),
        widget.chatUser.id!,
        userData['user_id']!,
        formattedTime,
      );
      var isMessageSend = await ref.read(
        ChatProvider.sendChatMessagesProvider(
          SendChatMessagesParams(
            conversationId: widget.chatUser.conversationId!,
            messageText: sendMessage.text.trim(),
            receiverId: widget.chatUser.id!,
            senderId: userData['user_id']!,
            typedAt: formattedTime,
          ),
        ).future,
      );
      if (isMessageSend == true) {
        if (widget.chatUser.isUserOnline != true) {
          final notificationServices = getItInstance<NotificationServices>();
          chatNotifier.updateMessage(ChatMessageModel(
            messageText: sendMessage.text.trim(),
            conversationId: widget.chatUser.conversationId!,
            receiverId: widget.chatUser.id!,
            typedAt: formattedTime,
            senderId: userData['user_id']!,
          ));

          ref.invalidate(ChatProvider.getChatUsersListProvider(ref.read(userDetailsProvider)['user_id']!));
          var requestBody = {
            "type": 'message received',
            "sender_id": userData['user_id'],
            "sender_name": userData['user_name'],
            "receiver_id": widget.chatUser.id,
            "notification": "New message received from ${userData['user_name']}.",
            "conversation_id": widget.chatUser.conversationId,
          };
          await ref.read(
            NotificationProvider.postNewNotificationProvider(
              PostNewNotificationParams(requestBody: requestBody),
            ).future,
          );
          notificationServices.sendPushNotification(
            userToken: widget.chatUser.fcmToken!,
            body: sendMessage.text,
            title: userData['user_name']!,
          );
          sendMessage.clear();
        }
      }
    }
    sendMessage.clear();
    // ref.invalidate(chatMessagesProvider);
  }
}

class _SentMessage extends ConsumerWidget {
  const _SentMessage({
    required this.chatMessageModel,
    required this.sendMessage,
    required this.isEditMessage,
    required this.initialMessage,
    required this.initialMessageId,
  });

  final ChatMessageModel? chatMessageModel;
  final TextEditingController sendMessage;
  final ValueNotifier<bool> isEditMessage;
  final ValueNotifier<String> initialMessage;
  final ValueNotifier<String> initialMessageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.fromViewConstraints(
                      ViewConstraints(
                        maxWidth: ScreenSize.width(context) * 0.65,
                      ),
                    ),
                    child: LinkableText(
                      text: chatMessageModel?.messageText ?? "",
                      style1: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 14 * ScaleSize.textScaleFactor(context),
                          ),
                      style2: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 14 * ScaleSize.textScaleFactor(context),
                          ),
                      // textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      maxLines: 1000,
                      // softWrap: true,
                    ),
                  ),
                  SizedBox(
                    width: 10 * ScaleSize.textScaleFactor(context),
                  ),
                  if (isEditMessage.value == true)
                    Text(
                      'Edited',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 8 * ScaleSize.textScaleFactor(context),
                          ),
                      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                    ),
                  SizedBox(
                    width: 10 * ScaleSize.textScaleFactor(context),
                  ),
                  Text(
                    DateFormat('HH:mm').format(DateFormat('M/d/yyyy, h:mm:ss a').parse(chatMessageModel?.typedAt ?? '')),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 8 * ScaleSize.textScaleFactor(context),
                        ),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return InkWell(
      enableFeedback: true,
      onLongPress: () {
        _showMessageOptions(context, ref, isEditMessage, initialMessage, initialMessageId);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 50, top: 2, bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 30),
            messageTextGroup,
          ],
        ),
      ),
    );
  }

  void _showMessageOptions(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<bool> isEditMessage,
    ValueNotifier<String> initialMessage,
    ValueNotifier<String> initialMessageId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Message'),
                onTap: () {
                  Navigator.pop(context);
                  sendMessage.text = chatMessageModel?.messageText ?? "";
                  isEditMessage.value = true;
                  initialMessage.value = sendMessage.text;
                  initialMessageId.value = chatMessageModel?.id ?? "";
                  final focusNode = ref.read(textFieldFocusNodeProvider);
                  focusNode.requestFocus();
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.delete),
              //   title: const Text('Delete Message'),
              //   onTap: () async {
              //     Navigator.pop(context);
              //     await _deleteComment(context, ref);
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteComment(BuildContext context, WidgetRef ref) async {
    await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text(
            'Delete Message?',
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            'Are you sure you want to delete this message?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final isDeleted = ref.watch(
                  ChatProvider.deleteMessageProvider(chatMessageModel?.id).future,
                );
                if (isDeleted == true) {}
                context.pop();
              },
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ReceivedMessage extends ConsumerWidget {
  const _ReceivedMessage({
    required this.chatMessageModel,
  });

  final ChatMessageModel? chatMessageModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.fromViewConstraints(
                      ViewConstraints(
                        maxWidth: ScreenSize.width(context) * 0.65,
                      ),
                    ),
                    child: LinkableText(
                      text: chatMessageModel?.messageText ?? "",
                      style1: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                            fontSize: 14 * ScaleSize.textScaleFactor(context),
                          ),
                      style2: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                            fontSize: 14 * ScaleSize.textScaleFactor(context),
                          ),
                      maxLines: 1000,
                      // softWrap: true,
                      // textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                    ),
                  ),
                  SizedBox(
                    width: 10 * ScaleSize.textScaleFactor(context),
                  ),
                  Text(
                    DateFormat('HH:mm').format(DateFormat('M/d/yyyy, h:mm:ss a').parse(chatMessageModel?.typedAt ?? '')),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontSize: 8 * ScaleSize.textScaleFactor(context),
                        ),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return InkWell(
      enableFeedback: true,
      onLongPress: () {
        // _showMessageOptions(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 50.0, left: 18, top: 2, bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 30),
            messageTextGroup,
          ],
        ),
      ),
    );
  }

  void _showMessageOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete Message'),
                onTap: () {
                  // TODO: Implement delete message functionality
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
