class CreateNewChatParams {
  final String senderId;
  final String receiverId;

  CreateNewChatParams({
    required this.senderId,
    required this.receiverId,
  });
}

class SendChatMessagesParams {
  final String senderId;
  final String receiverId;
  final String conversationId;
  final String messageText;
  final String typedAt;

  SendChatMessagesParams({
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.messageText,
    required this.typedAt,
  });
}

class GetDMUserParams {
  final String senderId;
  final String receiverId;

  GetDMUserParams({
    required this.senderId,
    required this.receiverId,
  });
}

class EditMessageParams {
  final String conversationId;
  final String messageText;

  EditMessageParams({
    required this.conversationId,
    required this.messageText,
  });
}
