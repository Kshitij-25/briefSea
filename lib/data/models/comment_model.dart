import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
class CommentModel with _$CommentModel {
  factory CommentModel({
    @JsonKey(name: "_id") String? id,
    @JsonKey(name: "user_id") String? userId,
    String? name,
    String? type,
    @JsonKey(name: "thread_id") String? threadId,
    @JsonKey(name: "comment") String? commentText,
    int? postedAt,
    int? likesCount,
    int? replyCount,
    String? createdAt,
    String? updatedAt,
    @Default(false) bool isCommentLiked,
    String? commentLikeId,
    bool? isVisible,
    String? avatarSrc,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
}
