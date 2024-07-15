import 'package:briefsea/presentation/providers/chat_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/chat_message_model.dart';

class ChatMessagesNotifier extends StateNotifier<ChatMessageState> {
  Ref ref;
  String? conversationId;
  ChatMessagesNotifier(this.ref, this.conversationId) : super(ChatMessageState()) {
    getChatHistory();
    // ref.read(socketEventListenerProvider(conversationId!));
  }

  Future<void> getChatHistory() async {
    setLoading(true);
    final chatRepository = ref.read(chatRepositoryProvider);
    final eitherGetMessagesOrError = await chatRepository.getChatMessages(conversationId);
    eitherGetMessagesOrError.fold(
      (error) {
        print('Error fetching messages: $error');
        setLoading(false);
        setError(error.errorMessage);
        throw error; // Throw the error for Riverpod to handle
      },
      (newChat) {
        print('Fetched messages: $newChat');
        setLoading(false);
        setError(null);
        addMessage(newChat);
      },
    );
  }

  void addMessage(List<ChatMessageModel> message) {
    state = state.copyWith(
      chatMessages: [...?state.chatMessages, ...message],
    );
  }

  void updateMessage(ChatMessageModel message) {
    state = state.copyWith(
      chatMessages: [...?state.chatMessages, message],
    );
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  // void addMessage(ChatMessageModel message) {
  //   print('Adding message: $message');
  //   state = [...state, message];
  // }
}

final chatMessagesProvider =
    StateNotifierProvider.family.autoDispose<ChatMessagesNotifier, ChatMessageState, String?>((ref, String? contversationId) {
  return ChatMessagesNotifier(ref, contversationId);
});

class ChatMessageState {
  final List<ChatMessageModel>? chatMessages;
  final bool isLoading;
  final String? error;

  ChatMessageState({
    this.chatMessages,
    this.isLoading = false,
    this.error,
  });

  ChatMessageState copyWith({
    List<ChatMessageModel>? chatMessages,
    bool? isLoading,
    String? error,
  }) {
    return ChatMessageState(
      chatMessages: chatMessages ?? this.chatMessages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
