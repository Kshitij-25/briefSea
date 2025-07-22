class PostNewNotificationParams {
  final Map<String, dynamic> requestBody;
  final bool isNewRegister;

  PostNewNotificationParams({
    required this.requestBody,
    this.isNewRegister = false,
  });
}

class NotificationParams {
  final String? id;
  final bool? isViewed;
  final bool? isClicked;
  final String? type;
  final String? senderId;
  final String? senderName;
  final String? receiverId;
  final String? notification;
  final String? briefText;
  final String? commentText;
  final String? profileId;
  final String? threadId;
  final String? likeId;
  final String? commentId;
  final String? replyId;
  final String? conversationId;

  NotificationParams({
    this.id,
    this.isViewed,
    this.isClicked,
    this.type,
    this.senderId,
    this.senderName,
    this.receiverId,
    this.notification,
    this.briefText,
    this.commentText,
    this.profileId,
    this.threadId,
    this.likeId,
    this.commentId,
    this.replyId,
    this.conversationId,
  });
}
