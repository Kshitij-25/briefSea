import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  Set<String> onlineIds = {};

  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    onlineIds.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final socketService = ref.read(socketServiceProvider);

      socketService.socket.on('add-user', (data) {
        log("SOCKET SERVICE ADD-USER $data");
        // _updateUserOnlineStatus(data);
      });

      socketService.socket.on('active-user', (data) {
        log("SOCKET SERVICE ACTIVE-USER $data");
        _updateUserOnlineStatus(data);
      });
    });

    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  void _updateUserOnlineStatus(List usersData) {
    onlineIds.clear();
    final userIds = usersData.map((data) => data['user_id'] as String).toSet();

    setState(() {
      onlineIds.addAll(userIds);
      // onlineIds = userIds;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getChatUsersListProvider(userId: ref.read(userDetailsProvider)['user_id']!)).when(
          data: (chatUsers) {
            if (chatUsers.isEmpty) {
              return const Center(
                child: Text("No Chats"),
              );
            }
            // Filter chat users based on search query
            final filteredChatUsers = chatUsers.where((user) {
              final userName = user.name!.toLowerCase();
              final searchLower = searchQuery.toLowerCase();
              return userName.contains(searchLower);
            }).toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SearchBar(
                    controller: searchController,
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    leading: const Icon(
                      CupertinoIcons.search,
                      color: Colors.black,
                    ),
                    hintText: "Search...",
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredChatUsers.length,
                    itemBuilder: (context, index) {
                      final isOnline = onlineIds.contains(filteredChatUsers[index].id);
                      return CustomChatCards(
                        onTap: () {
                          context.push(
                            ChatScreen.routeName,
                            extra: filteredChatUsers[index],
                          );
                        },
                        chatUserModel: filteredChatUsers[index],
                        isUserOnline: isOnline,
                      );
                    },
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text('Error: $error'));
          },
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}
