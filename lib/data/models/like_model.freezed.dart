// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'like_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LikeModel _$LikeModelFromJson(Map<String, dynamic> json) {
  return _LikeModel.fromJson(json);
}

/// @nodoc
mixin _$LikeModel {
  @JsonKey(name: "_id")
  String? get likeId => throw _privateConstructorUsedError;
  @JsonKey(name: "user_id")
  String? get userId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "thread_id")
  String? get threadId => throw _privateConstructorUsedError;
  @JsonKey(name: "reply_id")
  String? get replyId => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this LikeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LikeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LikeModelCopyWith<LikeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LikeModelCopyWith<$Res> {
  factory $LikeModelCopyWith(LikeModel value, $Res Function(LikeModel) then) =
      _$LikeModelCopyWithImpl<$Res, LikeModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String? likeId,
      @JsonKey(name: "user_id") String? userId,
      String? name,
      String? type,
      @JsonKey(name: "thread_id") String? threadId,
      @JsonKey(name: "reply_id") String? replyId,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class _$LikeModelCopyWithImpl<$Res, $Val extends LikeModel>
    implements $LikeModelCopyWith<$Res> {
  _$LikeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LikeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? likeId = freezed,
    Object? userId = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? threadId = freezed,
    Object? replyId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      likeId: freezed == likeId
          ? _value.likeId
          : likeId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      threadId: freezed == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as String?,
      replyId: freezed == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LikeModelImplCopyWith<$Res>
    implements $LikeModelCopyWith<$Res> {
  factory _$$LikeModelImplCopyWith(
          _$LikeModelImpl value, $Res Function(_$LikeModelImpl) then) =
      __$$LikeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String? likeId,
      @JsonKey(name: "user_id") String? userId,
      String? name,
      String? type,
      @JsonKey(name: "thread_id") String? threadId,
      @JsonKey(name: "reply_id") String? replyId,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class __$$LikeModelImplCopyWithImpl<$Res>
    extends _$LikeModelCopyWithImpl<$Res, _$LikeModelImpl>
    implements _$$LikeModelImplCopyWith<$Res> {
  __$$LikeModelImplCopyWithImpl(
      _$LikeModelImpl _value, $Res Function(_$LikeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LikeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? likeId = freezed,
    Object? userId = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? threadId = freezed,
    Object? replyId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$LikeModelImpl(
      likeId: freezed == likeId
          ? _value.likeId
          : likeId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      threadId: freezed == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as String?,
      replyId: freezed == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LikeModelImpl implements _LikeModel {
  _$LikeModelImpl(
      {@JsonKey(name: "_id") this.likeId,
      @JsonKey(name: "user_id") this.userId,
      this.name,
      this.type,
      @JsonKey(name: "thread_id") this.threadId,
      @JsonKey(name: "reply_id") this.replyId,
      this.createdAt,
      this.updatedAt});

  factory _$LikeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LikeModelImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String? likeId;
  @override
  @JsonKey(name: "user_id")
  final String? userId;
  @override
  final String? name;
  @override
  final String? type;
  @override
  @JsonKey(name: "thread_id")
  final String? threadId;
  @override
  @JsonKey(name: "reply_id")
  final String? replyId;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'LikeModel(likeId: $likeId, userId: $userId, name: $name, type: $type, threadId: $threadId, replyId: $replyId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikeModelImpl &&
            (identical(other.likeId, likeId) || other.likeId == likeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, likeId, userId, name, type,
      threadId, replyId, createdAt, updatedAt);

  /// Create a copy of LikeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LikeModelImplCopyWith<_$LikeModelImpl> get copyWith =>
      __$$LikeModelImplCopyWithImpl<_$LikeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LikeModelImplToJson(
      this,
    );
  }
}

abstract class _LikeModel implements LikeModel {
  factory _LikeModel(
      {@JsonKey(name: "_id") final String? likeId,
      @JsonKey(name: "user_id") final String? userId,
      final String? name,
      final String? type,
      @JsonKey(name: "thread_id") final String? threadId,
      @JsonKey(name: "reply_id") final String? replyId,
      final String? createdAt,
      final String? updatedAt}) = _$LikeModelImpl;

  factory _LikeModel.fromJson(Map<String, dynamic> json) =
      _$LikeModelImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String? get likeId;
  @override
  @JsonKey(name: "user_id")
  String? get userId;
  @override
  String? get name;
  @override
  String? get type;
  @override
  @JsonKey(name: "thread_id")
  String? get threadId;
  @override
  @JsonKey(name: "reply_id")
  String? get replyId;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of LikeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LikeModelImplCopyWith<_$LikeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
