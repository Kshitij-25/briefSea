// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikeModelImpl _$$LikeModelImplFromJson(Map<String, dynamic> json) =>
    _$LikeModelImpl(
      likeId: json['_id'] as String?,
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      threadId: json['thread_id'] as String?,
      replyId: json['reply_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$LikeModelImplToJson(_$LikeModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.likeId,
      'user_id': instance.userId,
      'name': instance.name,
      'type': instance.type,
      'thread_id': instance.threadId,
      'reply_id': instance.replyId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
