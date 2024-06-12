import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
class ChatMessageModel with _$ChatMessageModel {
  factory ChatMessageModel({
    @JsonKey(name: "_id") String? id,
    @JsonKey(name: "conversation_id") String? conversationId,
    @JsonKey(name: "sender_id") String? senderId,
    @JsonKey(name: "receiver_id") String? receiverId,
    @JsonKey(name: "message") String? messageText,
    String? typedAt,
    String? createdAt,
    String? updatedAt,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);
}
