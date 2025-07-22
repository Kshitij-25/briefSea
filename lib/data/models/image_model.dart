import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.freezed.dart';
part 'image_model.g.dart';

@freezed
class ImageModel with _$ImageModel {
  factory ImageModel({
    String? url,
  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);
}
