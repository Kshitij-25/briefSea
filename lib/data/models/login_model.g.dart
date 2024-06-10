// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginModelImpl _$$LoginModelImplFromJson(Map<String, dynamic> json) =>
    _$LoginModelImpl(
      message: json['message'] as String?,
      token: json['token'] as String?,
      profile: json['profile'] as bool?,
    );

Map<String, dynamic> _$$LoginModelImplToJson(_$LoginModelImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'profile': instance.profile,
    };
