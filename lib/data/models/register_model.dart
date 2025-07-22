import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_model.freezed.dart';
part 'register_model.g.dart';

@freezed
class RegisterModel with _$RegisterModel {
  factory RegisterModel({
    String? message,
    @JsonKey(name: 'user_id') String? userId,
  }) = _RegisterModel;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => _$RegisterModelFromJson(json);
}
