import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_model.freezed.dart';
part 'edit_profile_model.g.dart';

@freezed
class EditProfileModel with _$EditProfileModel {
  factory EditProfileModel({
    bool? acknowledged,
    int? matchedCount,
    int? modifiedCount,
    int? upsertedCount,
  }) = _EditProfileModel;

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => _$EditProfileModelFromJson(json);
}
