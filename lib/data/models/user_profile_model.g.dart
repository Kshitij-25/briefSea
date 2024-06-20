// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileModelImpl _$$UserProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProfileModelImpl(
      id: json['_id'] as String?,
      isVerified: json['isVerified'] as bool?,
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      countryCode: (json['countryCode'] as num?)?.toInt(),
      contact: (json['contact'] as num?)?.toInt(),
      post: json['post'] as String?,
      worksAt: json['worksAt'] as String?,
      industry: (json['industry'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      expertise: (json['expertise'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      location: json['location'] as String?,
      avatarSrc: json['avatarSrc'] as String?,
      bannerSrc: json['bannerSrc'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      postingAs: json['postingAs'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$$UserProfileModelImplToJson(
        _$UserProfileModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'isVerified': instance.isVerified,
      'user_id': instance.userId,
      'name': instance.name,
      'countryCode': instance.countryCode,
      'contact': instance.contact,
      'post': instance.post,
      'worksAt': instance.worksAt,
      'industry': instance.industry,
      'expertise': instance.expertise,
      'location': instance.location,
      'avatarSrc': instance.avatarSrc,
      'bannerSrc': instance.bannerSrc,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'postingAs': instance.postingAs,
      'gender': instance.gender,
    };
