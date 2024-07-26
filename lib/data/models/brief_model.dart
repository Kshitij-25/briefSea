import 'package:briefsea/data/models/briefs_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'brief_model.freezed.dart';
part 'brief_model.g.dart';

@freezed
class BriefModel with _$BriefModel {
  factory BriefModel({
    @JsonKey(name: 'result') List<BriefsResult>? briefResult,
    @JsonKey(name: 'total_results') int? totalResults,
    @JsonKey(name: 'total_pages') int? totalPages,
    @JsonKey(name: 'page') String? page,
  }) = _BriefModel;

  factory BriefModel.fromJson(Map<String, dynamic> json) => _$BriefModelFromJson(json);
}
