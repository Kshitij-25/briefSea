import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'isVerified') bool? isVerified,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'countryCode') int? countryCode,
    @JsonKey(name: 'contact') int? contact,
    @JsonKey(name: 'post') String? post,
    @JsonKey(name: 'worksAt') String? worksAt,
    @JsonKey(name: 'industry') List<String>? industry,
    @JsonKey(name: 'expertise') List<String>? expertise,
    @JsonKey(name: 'location') String? location,
    @JsonKey(name: 'avatarSrc') String? avatarSrc,
    @JsonKey(name: 'bannerSrc') String? bannerSrc,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'updatedAt') String? updatedAt,
    @JsonKey(name: 'postingAs') String? postingAs,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'viewAccess') bool? viewAccess,
    @JsonKey(name: 'userName') String? userName,
    @JsonKey(name: 'about') String? aboutMe,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);
}
