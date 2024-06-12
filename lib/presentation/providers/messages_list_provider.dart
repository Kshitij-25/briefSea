// import 'package:briefsea/data/models/chat_message_model.dart';
// import 'package:briefsea/presentation/providers/chat_provider.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final chatMessagesListProvider = StateNotifierProvider<ChatMessagesListNotifier, List<ChatMessageModel>>((ref) {
//   final initialMessages = ref.watch(getChatMessagesProvider(...)); // Fetch initial messages from the API
//   return ChatMessagesListNotifier(initialMessages);
// });

// class ChatMessagesListNotifier extends StateNotifier<List<ChatMessageModel>> {
//   ChatMessagesListNotifier(super.initialMessages);

//   void addMessage(ChatMessageModel message) {
//     state = [...state, message];
//   }
// }