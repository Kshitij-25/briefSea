class PostBriefParams {
  final String? userId;
  final String? uName;
  final String? type;
  final String? category;
  final String? postText;
  final String? imgSrc;
  final List<String>? isVisibleTo;

  PostBriefParams({
    required this.userId,
    required this.uName,
    required this.type,
    required this.category,
    required this.postText,
    this.imgSrc,
    required this.isVisibleTo,
  });
}

class UploadThreadImageParams {
  final String fileName;
  final String fileType;
  final String userId;
  final String userType;

  UploadThreadImageParams({
    required this.fileName,
    required this.fileType,
    required this.userId,
    required this.userType,
  });
}

class EditBriefParams {
  final String briefId;
  final bool isVisible;
  final String userId;
  final String uname;
  final String type;
  final String category;
  final String postText;
  final String imgSrc;
  final String avatarSrc;
  final String createdAt;
  final String updatedAt;
  final int likesCount;
  final int replyCount;
  final int postedAt;
  final List<String>? isVisibleTo;

  EditBriefParams({
    required this.briefId,
    required this.isVisible,
    required this.userId,
    required this.uname,
    required this.type,
    required this.category,
    required this.postText,
    required this.imgSrc,
    required this.avatarSrc,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.replyCount,
    required this.postedAt,
    required this.isVisibleTo,
  });
}
