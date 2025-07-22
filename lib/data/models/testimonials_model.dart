import 'package:freezed_annotation/freezed_annotation.dart';

part 'testimonials_model.freezed.dart';
part 'testimonials_model.g.dart';

@freezed
class TestimonialsModel with _$TestimonialsModel {
  factory TestimonialsModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'linkedinLink') String? linkedinLink,
    @JsonKey(name: 'testimonial') String? testimonial,
  }) = _TestimonialsModel;

  factory TestimonialsModel.fromJson(Map<String, dynamic> json) => _$TestimonialsModelFromJson(json);
}
