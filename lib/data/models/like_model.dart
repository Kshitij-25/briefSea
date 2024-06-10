import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_model.freezed.dart';
part 'like_model.g.dart';

@freezed
class LikeModel with _$LikeModel {
  factory LikeModel({
    @JsonKey(name: "_id") String? likeId,
    @JsonKey(name: "user_id") String? userId,
    String? name,
    String? type,
    @JsonKey(name: "thread_id") String? threadId,
    String? createdAt,
    String? updatedAt,
  }) = _LikeModel;

  factory LikeModel.fromJson(Map<String, dynamic> json) => _$LikeModelFromJson(json);
}
