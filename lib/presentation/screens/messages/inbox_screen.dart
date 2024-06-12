import 'package:briefsea/presentation/providers/chat_provider.dart';
import 'package:briefsea/presentation/screens/messages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/custom_chat_cards.dart';

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDetailsProvider);
    final chatUsers = ref.watch(getChatUsersListProvider(userId: userData['user_id']!));

    return chatUsers.when(
      data: (users) {
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return CustomChatCards(
              onTap: () {
                context.push(
                  ChatScreen.routeName,
                  extra: users[index],
                );
              },
              chatName: users[index].name,
              chatMessage: users[index].type,
            );
          },
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
