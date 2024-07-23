// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentModelImpl _$$CommentModelImplFromJson(Map<String, dynamic> json) =>
    _$CommentModelImpl(
      id: json['_id'] as String?,
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      threadId: json['thread_id'] as String?,
      commentText: json['comment'] as String?,
      postedAt: (json['postedAt'] as num?)?.toInt(),
      likesCount: (json['likesCount'] as num?)?.toInt(),
      replyCount: (json['replyCount'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isCommentLiked: json['isCommentLiked'] as bool? ?? false,
      commentLikeId: json['commentLikeId'] as String?,
      isVisible: json['isVisible'] as bool?,
      avatarSrc: json['avatarSrc'] as String?,
      likeObj: json['likeObj'] == null
          ? null
          : LikeObj.fromJson(json['likeObj'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CommentModelImplToJson(_$CommentModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'type': instance.type,
      'thread_id': instance.threadId,
      'comment': instance.commentText,
      'postedAt': instance.postedAt,
      'likesCount': instance.likesCount,
      'replyCount': instance.replyCount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isCommentLiked': instance.isCommentLiked,
      'commentLikeId': instance.commentLikeId,
      'isVisible': instance.isVisible,
      'avatarSrc': instance.avatarSrc,
      'likeObj': instance.likeObj,
    };
