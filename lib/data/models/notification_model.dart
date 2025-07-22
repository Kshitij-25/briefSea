import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  factory NotificationModel({
    @JsonKey(name: "_id") String? notificationId,
    String? type,
    @JsonKey(name: "sender_id") String? senderId,
    @JsonKey(name: "sender_name") String? senderName,
    @JsonKey(name: "receiver_id") String? receiverId,
    String? notification,
    @JsonKey(name: "thread_id") String? threadId,
    @JsonKey(name: "conversation_id") String? conversationId,
    int? notifiedAt,
    String? createdAt,
    String? updatedAt,
    String? avatar,
    bool? isViewed,
    bool? isClicked,
    @JsonKey(name: "commentText") String? commentText,
    @JsonKey(name: "like_id") String? likeId,
    @JsonKey(name: "reply_id") String? replyId,
    @JsonKey(name: "briefText") String? briefText,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
}
