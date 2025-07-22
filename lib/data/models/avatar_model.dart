import 'package:freezed_annotation/freezed_annotation.dart';

part 'avatar_model.freezed.dart';
part 'avatar_model.g.dart';

@freezed
class AvatarModel with _$AvatarModel {
  factory AvatarModel({
    String? key,
    String? url,
  }) = _AvatarModel;

  factory AvatarModel.fromJson(Map<String, dynamic> json) => _$AvatarModelFromJson(json);
}
