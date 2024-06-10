import 'package:freezed_annotation/freezed_annotation.dart';

part 'briefs_model.freezed.dart';
part 'briefs_model.g.dart';

@freezed
class BriefsModel with _$BriefsModel {
  factory BriefsModel({
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
  }) = _BriefsModel;

  factory BriefsModel.fromJson(Map<String, dynamic> json) => _$BriefsModelFromJson(json);
}
