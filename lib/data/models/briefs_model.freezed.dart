// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'briefs_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BriefsModel _$BriefsModelFromJson(Map<String, dynamic> json) {
  return _BriefsModel.fromJson(json);
}

/// @nodoc
mixin _$BriefsModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get postText => throw _privateConstructorUsedError;
  int? get likesCount => throw _privateConstructorUsedError;
  int? get replyCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'postedAt')
  int? get postedAt => throw _privateConstructorUsedError;
  String? get imgSrc => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  bool get isPostLiked => throw _privateConstructorUsedError;
  String? get postLikeId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BriefsModelCopyWith<BriefsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BriefsModelCopyWith<$Res> {
  factory $BriefsModelCopyWith(
          BriefsModel value, $Res Function(BriefsModel) then) =
      _$BriefsModelCopyWithImpl<$Res, BriefsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'user_id') String? userId,
      String? name,
      String? type,
      String? category,
      String? postText,
      int? likesCount,
      int? replyCount,
      @JsonKey(name: 'postedAt') int? postedAt,
      String? imgSrc,
      String? createdAt,
      String? updatedAt,
      bool isPostLiked,
      String? postLikeId});
}

/// @nodoc
class _$BriefsModelCopyWithImpl<$Res, $Val extends BriefsModel>
    implements $BriefsModelCopyWith<$Res> {
  _$BriefsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? category = freezed,
    Object? postText = freezed,
    Object? likesCount = freezed,
    Object? replyCount = freezed,
    Object? postedAt = freezed,
    Object? imgSrc = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isPostLiked = null,
    Object? postLikeId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      postText: freezed == postText
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as String?,
      likesCount: freezed == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      replyCount: freezed == replyCount
          ? _value.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int?,
      postedAt: freezed == postedAt
          ? _value.postedAt
          : postedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      imgSrc: freezed == imgSrc
          ? _value.imgSrc
          : imgSrc // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isPostLiked: null == isPostLiked
          ? _value.isPostLiked
          : isPostLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      postLikeId: freezed == postLikeId
          ? _value.postLikeId
          : postLikeId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BriefsModelImplCopyWith<$Res>
    implements $BriefsModelCopyWith<$Res> {
  factory _$$BriefsModelImplCopyWith(
          _$BriefsModelImpl value, $Res Function(_$BriefsModelImpl) then) =
      __$$BriefsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'user_id') String? userId,
      String? name,
      String? type,
      String? category,
      String? postText,
      int? likesCount,
      int? replyCount,
      @JsonKey(name: 'postedAt') int? postedAt,
      String? imgSrc,
      String? createdAt,
      String? updatedAt,
      bool isPostLiked,
      String? postLikeId});
}

/// @nodoc
class __$$BriefsModelImplCopyWithImpl<$Res>
    extends _$BriefsModelCopyWithImpl<$Res, _$BriefsModelImpl>
    implements _$$BriefsModelImplCopyWith<$Res> {
  __$$BriefsModelImplCopyWithImpl(
      _$BriefsModelImpl _value, $Res Function(_$BriefsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? category = freezed,
    Object? postText = freezed,
    Object? likesCount = freezed,
    Object? replyCount = freezed,
    Object? postedAt = freezed,
    Object? imgSrc = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isPostLiked = null,
    Object? postLikeId = freezed,
  }) {
    return _then(_$BriefsModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      postText: freezed == postText
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as String?,
      likesCount: freezed == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      replyCount: freezed == replyCount
          ? _value.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int?,
      postedAt: freezed == postedAt
          ? _value.postedAt
          : postedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      imgSrc: freezed == imgSrc
          ? _value.imgSrc
          : imgSrc // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isPostLiked: null == isPostLiked
          ? _value.isPostLiked
          : isPostLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      postLikeId: freezed == postLikeId
          ? _value.postLikeId
          : postLikeId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BriefsModelImpl implements _BriefsModel {
  _$BriefsModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'user_id') this.userId,
      this.name,
      this.type,
      this.category,
      this.postText,
      this.likesCount,
      this.replyCount,
      @JsonKey(name: 'postedAt') this.postedAt,
      this.imgSrc,
      this.createdAt,
      this.updatedAt,
      this.isPostLiked = false,
      this.postLikeId});

  factory _$BriefsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BriefsModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  final String? name;
  @override
  final String? type;
  @override
  final String? category;
  @override
  final String? postText;
  @override
  final int? likesCount;
  @override
  final int? replyCount;
  @override
  @JsonKey(name: 'postedAt')
  final int? postedAt;
  @override
  final String? imgSrc;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
  @override
  @JsonKey()
  final bool isPostLiked;
  @override
  final String? postLikeId;

  @override
  String toString() {
    return 'BriefsModel(id: $id, userId: $userId, name: $name, type: $type, category: $category, postText: $postText, likesCount: $likesCount, replyCount: $replyCount, postedAt: $postedAt, imgSrc: $imgSrc, createdAt: $createdAt, updatedAt: $updatedAt, isPostLiked: $isPostLiked, postLikeId: $postLikeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BriefsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.postText, postText) ||
                other.postText == postText) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.postedAt, postedAt) ||
                other.postedAt == postedAt) &&
            (identical(other.imgSrc, imgSrc) || other.imgSrc == imgSrc) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isPostLiked, isPostLiked) ||
                other.isPostLiked == isPostLiked) &&
            (identical(other.postLikeId, postLikeId) ||
                other.postLikeId == postLikeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      type,
      category,
      postText,
      likesCount,
      replyCount,
      postedAt,
      imgSrc,
      createdAt,
      updatedAt,
      isPostLiked,
      postLikeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BriefsModelImplCopyWith<_$BriefsModelImpl> get copyWith =>
      __$$BriefsModelImplCopyWithImpl<_$BriefsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BriefsModelImplToJson(
      this,
    );
  }
}

abstract class _BriefsModel implements BriefsModel {
  factory _BriefsModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'user_id') final String? userId,
      final String? name,
      final String? type,
      final String? category,
      final String? postText,
      final int? likesCount,
      final int? replyCount,
      @JsonKey(name: 'postedAt') final int? postedAt,
      final String? imgSrc,
      final String? createdAt,
      final String? updatedAt,
      final bool isPostLiked,
      final String? postLikeId}) = _$BriefsModelImpl;

  factory _BriefsModel.fromJson(Map<String, dynamic> json) =
      _$BriefsModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  String? get name;
  @override
  String? get type;
  @override
  String? get category;
  @override
  String? get postText;
  @override
  int? get likesCount;
  @override
  int? get replyCount;
  @override
  @JsonKey(name: 'postedAt')
  int? get postedAt;
  @override
  String? get imgSrc;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;
  @override
  bool get isPostLiked;
  @override
  String? get postLikeId;
  @override
  @JsonKey(ignore: true)
  _$$BriefsModelImplCopyWith<_$BriefsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
