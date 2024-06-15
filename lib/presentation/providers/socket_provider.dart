import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/chat_message_model.dart';
import '../../data/services/socket_service.dart';
import 'messages_list_provider.dart';

// final socketProvider = Provider<IO.Socket>((ref) {
//   final socket = IO.io(
//       'https://www.api.briefsea.com',
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .disableAutoConnect() // Disable auto connect
//           .build());

//   socket.connect(); // Connect manually

//   socket.onConnect((_) {
//     log("SOCKET ONCONNET ${socket.connected} ==> ${socket.id}");
//   });

//   socket.emit(
//     'welcome',
//     {'room_id': socket.id},
//   );

//   socket.on('welcome', (data) {
//     socket.emit('add-user', {'user_id': data.user_id, 'room_id': data.room_id});
//   });

//   return socket;
// });

final socketServiceProvider = Provider((ref) => SocketService());

final socketEventListenerProvider = Provider.family<void, String>((ref, conversationId) {
  final socketService = ref.read(socketServiceProvider);
  final chatMessagesNotifier = ref.watch(chatMessagesProvider(conversationId).notifier);

  socketService.socket.on('receive-message', (data) {
    ChatMessageModel message = ChatMessageModel.fromJson(data);
    chatMessagesNotifier.updateMessage(message);
  });

  socketService.socket.on('active-user', (data) {
    log("ACTIVE USER  $data");
    // Handle active user updates if needed
  });
});

// final socketEventListenerProvider = Provider.autoDispose((ref) {
//   final socketService = ref.read(socketServiceProvider);

//   socketService.socket.on('receive-message', (data) {
//     ChatMessageModel message = ChatMessageModel.fromJson(data); // Assuming you have a method to parse JSON to ChatMessageModel
//     // ref.read(chatMessagesProvider.notifier).addMessage(message);
//   });

//   socketService.socket.on('active-user', (data) {
//     // Handle active user updates if needed
//   });

//   return socketService;
// });

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
