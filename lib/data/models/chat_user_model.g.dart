// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatUserModelImpl _$$ChatUserModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatUserModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      conversationId: json['conversation_id'] as String?,
      isUserOnline: json['isUserOnline'] as bool? ?? false,
      lastMsg: json['lastMsg'] as String?,
    );

Map<String, dynamic> _$$ChatUserModelImplToJson(_$ChatUserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'conversation_id': instance.conversationId,
      'isUserOnline': instance.isUserOnline,
      'lastMsg': instance.lastMsg,
    };
