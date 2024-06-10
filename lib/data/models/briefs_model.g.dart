// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'briefs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BriefsModelImpl _$$BriefsModelImplFromJson(Map<String, dynamic> json) =>
    _$BriefsModelImpl(
      id: json['_id'] as String?,
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      postText: json['postText'] as String?,
      likesCount: (json['likesCount'] as num?)?.toInt(),
      replyCount: (json['replyCount'] as num?)?.toInt(),
      postedAt: (json['postedAt'] as num?)?.toInt(),
      imgSrc: json['imgSrc'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isPostLiked: json['isPostLiked'] as bool? ?? false,
      postLikeId: json['postLikeId'] as String?,
    );

Map<String, dynamic> _$$BriefsModelImplToJson(_$BriefsModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'type': instance.type,
      'category': instance.category,
      'postText': instance.postText,
      'likesCount': instance.likesCount,
      'replyCount': instance.replyCount,
      'postedAt': instance.postedAt,
      'imgSrc': instance.imgSrc,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isPostLiked': instance.isPostLiked,
      'postLikeId': instance.postLikeId,
    };
