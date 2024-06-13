import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/models/chat_user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/socket_provider.dart';
import '../../screens/messages/chat_screen.dart';
import '../../widgets/custom_chat_cards.dart';

class InboxScreen extends ConsumerStatefulWidget {
  const InboxScreen({super.key});

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends ConsumerState<InboxScreen> {
  late List<ChatUserModel> _chatUsers = [];

  @override
  void initState() {
    super.initState();
    final socketService = ref.read(socketServiceProvider);

// Initialize the chat users list
    _initializeChatUsers();

    socketService.socket.on('add-user', (data) {
      log("SOCKET SERVICE ADD-USER $data");
      _updateUserOnlineStatus(data);
    });
    socketService.socket.on('active-user', (data) {
      log("SOCKET SERVICE ADD-USER $data");
    });
  }

  Future<void> _initializeChatUsers() async {
    final userData = ref.read(userDetailsProvider);
    final chatUsersFuture = await ref.read(getChatUsersListProvider(userId: userData['user_id']!).future);

    final chatUsers = chatUsersFuture;
    setState(() {
      _chatUsers = chatUsers;
    });
  }

  void _updateUserOnlineStatus(List<Map<String, dynamic>> usersData) {
    final userIds = usersData.map((data) => data['user_id'] as String).toSet();

    setState(() {
      _chatUsers = _chatUsers.map((chatUser) {
        if (userIds.contains(chatUser.id)) {
          log("${chatUser.name}====>${chatUser.isUserOnline}");
          return chatUser.copyWith(isUserOnline: true);
        }
        return chatUser;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userData = ref.watch(userDetailsProvider);
    // final chatUsers = ref.watch(getChatUsersListProvider(userId: userData['user_id']!));
    // final socket = ref.watch(socketProvider);

    // socket.on('active-user', (data) {
    //   log("ACTIVE USER DATA$data");
    // });
    return _chatUsers.isEmpty
        ? const Center(child: CircularProgressIndicator.adaptive())
        : ListView.builder(
            itemCount: _chatUsers.length,
            itemBuilder: (context, index) {
              return CustomChatCards(
                onTap: () {
                  context.push(
                    ChatScreen.routeName,
                    extra: _chatUsers[index],
                  );
                },
                chatName: _chatUsers[index].name,
                chatMessage: _chatUsers[index].type,
                isUserOnline: _chatUsers[index].isUserOnline,
              );
            },
          );

    // return chatUsers.when(
    //   data: (users) {
    //     return ListView.builder(
    //       itemCount: users.length,
    //       itemBuilder: (context, index) {
    //         return CustomChatCards(
    //           onTap: () {
    //             context.push(
    //               ChatScreen.routeName,
    //               extra: users[index],
    //             );
    //           },
    //           chatName: users[index].name,
    //           chatMessage: users[index].type,
    //         );
    //       },
    //     );
    //   },
    //   error: (error, stackTrace) {
    //     return Center(child: Text('Error: $error'));
    //   },
    //   loading: () => const Center(
    //     child: CircularProgressIndicator.adaptive(),
    //   ),
    // );
  }
}
