class PostLikeParams {
  final String? userId;
  final String? uName;
  final String? replyId;
  final String? threadId;
  final String? type;

  PostLikeParams({
    required this.userId,
    required this.uName,
    this.replyId,
    required this.threadId,
    required this.type,
  });
}

class DeleteLikeParams {
  final String? threadId;
  final String? likeId;

  DeleteLikeParams({
    required this.threadId,
    required this.likeId,
  });
}
