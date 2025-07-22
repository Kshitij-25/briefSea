import 'package:freezed_annotation/freezed_annotation.dart';

part 'clients_model.freezed.dart';
part 'clients_model.g.dart';

@freezed
class ClientsModel with _$ClientsModel {
  factory ClientsModel({
    @JsonKey(name: 'company') String? company,
    @JsonKey(name: 'link') String? link,
    @JsonKey(name: 'startDate') String? startDate,
    @JsonKey(name: 'endDate') String? endDate,
  }) = _ClientsModel;

  factory ClientsModel.fromJson(Map<String, dynamic> json) => _$ClientsModelFromJson(json);
}
