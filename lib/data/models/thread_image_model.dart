import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread_image_model.freezed.dart';
part 'thread_image_model.g.dart';

@freezed
class ThreadImageModel with _$ThreadImageModel {
  factory ThreadImageModel({
    String? key,
    String? url,
  }) = _ThreadImageModel;

  factory ThreadImageModel.fromJson(Map<String, dynamic> json) => _$ThreadImageModelFromJson(json);
}
