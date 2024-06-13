import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/chat_message_model.dart';

class ChatMessagesNotifier extends StateNotifier<List<ChatMessageModel>> {
  ChatMessagesNotifier() : super([]);

  void setMessages(List<ChatMessageModel> messages) {
    state = messages;
  }

  void addMessage(ChatMessageModel message) {
    state = [...state, message];
  }
}

final chatMessagesProvider = StateNotifierProvider<ChatMessagesNotifier, List<ChatMessageModel>>((ref) {
  return ChatMessagesNotifier();
});
