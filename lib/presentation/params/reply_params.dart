class PostReplyParams {
  final String? userId;
  final String? threadId;
  final String? commentText;
  final String? replyId;

  PostReplyParams({
    required this.userId,
    required this.threadId,
    required this.commentText,
    this.replyId,
  });
}

class EditReplyParams {
  final String? commentText;
  final String? commentId;

  EditReplyParams({
    required this.commentText,
    this.commentId,
  });
}
