import 'package:briefsea/data/models/like_obj.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'briefs_result.freezed.dart';
part 'briefs_result.g.dart';

@freezed
class BriefsResult with _$BriefsResult {
  factory BriefsResult({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'user_id') String? userId,
    String? name,
    String? type,
    String? category,
    String? postText,
    int? likesCount,
    int? replyCount,
    @JsonKey(name: 'postedAt') int? postedAt,
    String? imgSrc,
    String? createdAt,
    String? updatedAt,
    @Default(false) bool isPostLiked,
    String? postLikeId,
    bool? isVisible,
    String? avatarSrc,
    List<String>? isVisibleTo,
    @JsonKey(name: 'likeObj') LikeObj? likeObj,
    String? fcmToken,
    bool? isEdited,
  }) = _BriefsResult;

  factory BriefsResult.fromJson(Map<String, dynamic> json) => _$BriefsResultFromJson(json);
}
