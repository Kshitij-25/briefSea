// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return _CommentModel.fromJson(json);
}

/// @nodoc
mixin _$CommentModel {
  @JsonKey(name: "_id")
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "user_id")
  String? get userId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "thread_id")
  String? get threadId => throw _privateConstructorUsedError;
  @JsonKey(name: "comment")
  String? get commentText => throw _privateConstructorUsedError;
  int? get postedAt => throw _privateConstructorUsedError;
  int? get likesCount => throw _privateConstructorUsedError;
  int? get replyCount => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  bool get isCommentLiked => throw _privateConstructorUsedError;
  String? get commentLikeId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentModelCopyWith<CommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentModelCopyWith<$Res> {
  factory $CommentModelCopyWith(
          CommentModel value, $Res Function(CommentModel) then) =
      _$CommentModelCopyWithImpl<$Res, CommentModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String? id,
      @JsonKey(name: "user_id") String? userId,
      String? name,
      String? type,
      @JsonKey(name: "thread_id") String? threadId,
      @JsonKey(name: "comment") String? commentText,
      int? postedAt,
      int? likesCount,
      int? replyCount,
      String? createdAt,
      String? updatedAt,
      bool isCommentLiked,
      String? commentLikeId});
}

/// @nodoc
class _$CommentModelCopyWithImpl<$Res, $Val extends CommentModel>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._value, this._then);

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
    Object? threadId = freezed,
    Object? commentText = freezed,
    Object? postedAt = freezed,
    Object? likesCount = freezed,
    Object? replyCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isCommentLiked = null,
    Object? commentLikeId = freezed,
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
      threadId: freezed == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as String?,
      commentText: freezed == commentText
          ? _value.commentText
          : commentText // ignore: cast_nullable_to_non_nullable
              as String?,
      postedAt: freezed == postedAt
          ? _value.postedAt
          : postedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      likesCount: freezed == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      replyCount: freezed == replyCount
          ? _value.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isCommentLiked: null == isCommentLiked
          ? _value.isCommentLiked
          : isCommentLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      commentLikeId: freezed == commentLikeId
          ? _value.commentLikeId
          : commentLikeId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentModelImplCopyWith<$Res>
    implements $CommentModelCopyWith<$Res> {
  factory _$$CommentModelImplCopyWith(
          _$CommentModelImpl value, $Res Function(_$CommentModelImpl) then) =
      __$$CommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String? id,
      @JsonKey(name: "user_id") String? userId,
      String? name,
      String? type,
      @JsonKey(name: "thread_id") String? threadId,
      @JsonKey(name: "comment") String? commentText,
      int? postedAt,
      int? likesCount,
      int? replyCount,
      String? createdAt,
      String? updatedAt,
      bool isCommentLiked,
      String? commentLikeId});
}

/// @nodoc
class __$$CommentModelImplCopyWithImpl<$Res>
    extends _$CommentModelCopyWithImpl<$Res, _$CommentModelImpl>
    implements _$$CommentModelImplCopyWith<$Res> {
  __$$CommentModelImplCopyWithImpl(
      _$CommentModelImpl _value, $Res Function(_$CommentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? threadId = freezed,
    Object? commentText = freezed,
    Object? postedAt = freezed,
    Object? likesCount = freezed,
    Object? replyCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isCommentLiked = null,
    Object? commentLikeId = freezed,
  }) {
    return _then(_$CommentModelImpl(
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
      threadId: freezed == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as String?,
      commentText: freezed == commentText
          ? _value.commentText
          : commentText // ignore: cast_nullable_to_non_nullable
              as String?,
      postedAt: freezed == postedAt
          ? _value.postedAt
          : postedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      likesCount: freezed == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      replyCount: freezed == replyCount
          ? _value.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isCommentLiked: null == isCommentLiked
          ? _value.isCommentLiked
          : isCommentLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      commentLikeId: freezed == commentLikeId
          ? _value.commentLikeId
          : commentLikeId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentModelImpl implements _CommentModel {
  _$CommentModelImpl(
      {@JsonKey(name: "_id") this.id,
      @JsonKey(name: "user_id") this.userId,
      this.name,
      this.type,
      @JsonKey(name: "thread_id") this.threadId,
      @JsonKey(name: "comment") this.commentText,
      this.postedAt,
      this.likesCount,
      this.replyCount,
      this.createdAt,
      this.updatedAt,
      this.isCommentLiked = false,
      this.commentLikeId});

  factory _$CommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentModelImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String? id;
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
  @JsonKey(name: "comment")
  final String? commentText;
  @override
  final int? postedAt;
  @override
  final int? likesCount;
  @override
  final int? replyCount;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
  @override
  @JsonKey()
  final bool isCommentLiked;
  @override
  final String? commentLikeId;

  @override
  String toString() {
    return 'CommentModel(id: $id, userId: $userId, name: $name, type: $type, threadId: $threadId, commentText: $commentText, postedAt: $postedAt, likesCount: $likesCount, replyCount: $replyCount, createdAt: $createdAt, updatedAt: $updatedAt, isCommentLiked: $isCommentLiked, commentLikeId: $commentLikeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.commentText, commentText) ||
                other.commentText == commentText) &&
            (identical(other.postedAt, postedAt) ||
                other.postedAt == postedAt) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isCommentLiked, isCommentLiked) ||
                other.isCommentLiked == isCommentLiked) &&
            (identical(other.commentLikeId, commentLikeId) ||
                other.commentLikeId == commentLikeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      type,
      threadId,
      commentText,
      postedAt,
      likesCount,
      replyCount,
      createdAt,
      updatedAt,
      isCommentLiked,
      commentLikeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      __$$CommentModelImplCopyWithImpl<_$CommentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentModelImplToJson(
      this,
    );
  }
}

abstract class _CommentModel implements CommentModel {
  factory _CommentModel(
      {@JsonKey(name: "_id") final String? id,
      @JsonKey(name: "user_id") final String? userId,
      final String? name,
      final String? type,
      @JsonKey(name: "thread_id") final String? threadId,
      @JsonKey(name: "comment") final String? commentText,
      final int? postedAt,
      final int? likesCount,
      final int? replyCount,
      final String? createdAt,
      final String? updatedAt,
      final bool isCommentLiked,
      final String? commentLikeId}) = _$CommentModelImpl;

  factory _CommentModel.fromJson(Map<String, dynamic> json) =
      _$CommentModelImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String? get id;
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
  @JsonKey(name: "comment")
  String? get commentText;
  @override
  int? get postedAt;
  @override
  int? get likesCount;
  @override
  int? get replyCount;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;
  @override
  bool get isCommentLiked;
  @override
  String? get commentLikeId;
  @override
  @JsonKey(ignore: true)
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
