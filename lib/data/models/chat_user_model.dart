import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_user_model.freezed.dart';
part 'chat_user_model.g.dart';

@freezed
class ChatUserModel with _$ChatUserModel {
  factory ChatUserModel({
    String? id,
    String? name,
    String? type,
    @JsonKey(name: "conversation_id") String? conversationId,
  }) = _ChatUserModel;

  factory ChatUserModel.fromJson(Map<String, dynamic> json) => _$ChatUserModelFromJson(json);
}
