import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/chat_message_model.dart';
import '../../data/services/socket_service.dart';
import 'messages_list_provider.dart';

final socketServiceProvider = Provider((ref) => SocketService());

final socketEventListenerProvider = Provider.family<void, String>((ref, conversationId) {
  final socketService = ref.read(socketServiceProvider);
  final chatMessagesNotifier = ref.read(chatMessagesProvider(conversationId).notifier);

  socketService.socket.on('receive-message', (data) {
    ChatMessageModel message = ChatMessageModel.fromJson(data);
    chatMessagesNotifier.updateMessage(message);
  });

  socketService.socket.on('active-user', (data) {
    log("ACTIVE USER  $data");
    // Handle active user updates if needed
  });
});

final sendMessageProvider = Provider.autoDispose((ref) {
  final socketService = ref.read(socketServiceProvider);

  return (String conversationId, String message, String receiverId, String senderId, String typedAt) {
    socketService.socket.emit('send-message', {
      'conversation_id': conversationId,
      'message': message,
      'receiver_id': receiverId,
      'sender_id': senderId,
      'typedAt': typedAt,
    });
  };
});
