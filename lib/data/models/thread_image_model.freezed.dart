// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thread_image_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ThreadImageModel _$ThreadImageModelFromJson(Map<String, dynamic> json) {
  return _ThreadImageModel.fromJson(json);
}

/// @nodoc
mixin _$ThreadImageModel {
  String? get key => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThreadImageModelCopyWith<ThreadImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreadImageModelCopyWith<$Res> {
  factory $ThreadImageModelCopyWith(
          ThreadImageModel value, $Res Function(ThreadImageModel) then) =
      _$ThreadImageModelCopyWithImpl<$Res, ThreadImageModel>;
  @useResult
  $Res call({String? key, String? url});
}

/// @nodoc
class _$ThreadImageModelCopyWithImpl<$Res, $Val extends ThreadImageModel>
    implements $ThreadImageModelCopyWith<$Res> {
  _$ThreadImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThreadImageModelImplCopyWith<$Res>
    implements $ThreadImageModelCopyWith<$Res> {
  factory _$$ThreadImageModelImplCopyWith(_$ThreadImageModelImpl value,
          $Res Function(_$ThreadImageModelImpl) then) =
      __$$ThreadImageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? key, String? url});
}

/// @nodoc
class __$$ThreadImageModelImplCopyWithImpl<$Res>
    extends _$ThreadImageModelCopyWithImpl<$Res, _$ThreadImageModelImpl>
    implements _$$ThreadImageModelImplCopyWith<$Res> {
  __$$ThreadImageModelImplCopyWithImpl(_$ThreadImageModelImpl _value,
      $Res Function(_$ThreadImageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? url = freezed,
  }) {
    return _then(_$ThreadImageModelImpl(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreadImageModelImpl implements _ThreadImageModel {
  _$ThreadImageModelImpl({this.key, this.url});

  factory _$ThreadImageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreadImageModelImplFromJson(json);

  @override
  final String? key;
  @override
  final String? url;

  @override
  String toString() {
    return 'ThreadImageModel(key: $key, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreadImageModelImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreadImageModelImplCopyWith<_$ThreadImageModelImpl> get copyWith =>
      __$$ThreadImageModelImplCopyWithImpl<_$ThreadImageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreadImageModelImplToJson(
      this,
    );
  }
}

abstract class _ThreadImageModel implements ThreadImageModel {
  factory _ThreadImageModel({final String? key, final String? url}) =
      _$ThreadImageModelImpl;

  factory _ThreadImageModel.fromJson(Map<String, dynamic> json) =
      _$ThreadImageModelImpl.fromJson;

  @override
  String? get key;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$ThreadImageModelImplCopyWith<_$ThreadImageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
