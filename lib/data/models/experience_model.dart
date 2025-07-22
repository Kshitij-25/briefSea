import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience_model.freezed.dart';
part 'experience_model.g.dart';

@freezed
class ExperienceModel with _$ExperienceModel {
  factory ExperienceModel({
    @JsonKey(name: 'post') String? post,
    @JsonKey(name: 'worksAt') String? worksAt,
    @JsonKey(name: 'startDate') String? startDate,
    @JsonKey(name: 'endDate') String? endDate,
    @JsonKey(name: 'teamSize') String? teamSize,
  }) = _ExperienceModel;

  factory ExperienceModel.fromJson(Map<String, dynamic> json) => _$ExperienceModelFromJson(json);
}
