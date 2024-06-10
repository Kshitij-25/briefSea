import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketProvider = Provider<IO.Socket>((ref) {
  final socket = IO.io(
      'http://your-socket-server-url',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // Disable auto connect
          .build());

  socket.connect(); // Connect manually

  return socket;
});
