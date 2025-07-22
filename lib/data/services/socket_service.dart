import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  SocketService() {
    connectSocket(); // Ensure socket is connected when the service is created
  }

  void connectSocket() {
    socket = IO.io(
      'https://www.api.briefsea.com',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // for Flutter or Dart VM
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      log('connected');
    });

    // socket.on('welcome', (data) {
    //   socket.emit('add-user', {
    //     'user_id': data['user_id'],
    //     'room_id': data['room_id'],
    //   });
    // });

    // socket.on('active-user', (data) {
    //   // Handle active users list
    //   log('Active users: $data');
    // });

    // socket.on('receive-message', (data) {
    //   // Convert data to the message model
    //   final message = ChatMessageModel.fromJson(data);
    //   // Append the new message to the list of messages
    //   ref.read(chatMessagesProvider.notifier).addMessage(message);
    // });
  }

  void disconnect() {
    socket.disconnect();
  }

  // void sendMessage(Map<String, dynamic> messageData) {
  //   socket.emit('send-message', messageData);
  // }

  // void requestActiveUsers() {
  //   socket.emit('active-user', {});
  // }
}
