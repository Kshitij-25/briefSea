import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_obj.freezed.dart';
part 'like_obj.g.dart';

@freezed
class LikeObj with _$LikeObj {
  factory LikeObj({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'thread_id') String? threadId,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'updatedAt') String? updatedAt,
  }) = _LikeObj;

  factory LikeObj.fromJson(Map<String, dynamic> json) => _$LikeObjFromJson(json);
}
