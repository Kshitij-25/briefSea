// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatUserModel _$ChatUserModelFromJson(Map<String, dynamic> json) {
  return _ChatUserModel.fromJson(json);
}

/// @nodoc
mixin _$ChatUserModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "conversation_id")
  String? get conversationId => throw _privateConstructorUsedError;
  String? get lastMsg => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  bool get isUserOnline => throw _privateConstructorUsedError;

  /// Serializes this ChatUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatUserModelCopyWith<ChatUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatUserModelCopyWith<$Res> {
  factory $ChatUserModelCopyWith(
          ChatUserModel value, $Res Function(ChatUserModel) then) =
      _$ChatUserModelCopyWithImpl<$Res, ChatUserModel>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? type,
      @JsonKey(name: "conversation_id") String? conversationId,
      String? lastMsg,
      String? avatar,
      String? updatedAt,
      bool isUserOnline});
}

/// @nodoc
class _$ChatUserModelCopyWithImpl<$Res, $Val extends ChatUserModel>
    implements $ChatUserModelCopyWith<$Res> {
  _$ChatUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? conversationId = freezed,
    Object? lastMsg = freezed,
    Object? avatar = freezed,
    Object? updatedAt = freezed,
    Object? isUserOnline = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMsg: freezed == lastMsg
          ? _value.lastMsg
          : lastMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isUserOnline: null == isUserOnline
          ? _value.isUserOnline
          : isUserOnline // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatUserModelImplCopyWith<$Res>
    implements $ChatUserModelCopyWith<$Res> {
  factory _$$ChatUserModelImplCopyWith(
          _$ChatUserModelImpl value, $Res Function(_$ChatUserModelImpl) then) =
      __$$ChatUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? type,
      @JsonKey(name: "conversation_id") String? conversationId,
      String? lastMsg,
      String? avatar,
      String? updatedAt,
      bool isUserOnline});
}

/// @nodoc
class __$$ChatUserModelImplCopyWithImpl<$Res>
    extends _$ChatUserModelCopyWithImpl<$Res, _$ChatUserModelImpl>
    implements _$$ChatUserModelImplCopyWith<$Res> {
  __$$ChatUserModelImplCopyWithImpl(
      _$ChatUserModelImpl _value, $Res Function(_$ChatUserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? conversationId = freezed,
    Object? lastMsg = freezed,
    Object? avatar = freezed,
    Object? updatedAt = freezed,
    Object? isUserOnline = null,
  }) {
    return _then(_$ChatUserModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMsg: freezed == lastMsg
          ? _value.lastMsg
          : lastMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isUserOnline: null == isUserOnline
          ? _value.isUserOnline
          : isUserOnline // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatUserModelImpl implements _ChatUserModel {
  _$ChatUserModelImpl(
      {this.id,
      this.name,
      this.type,
      @JsonKey(name: "conversation_id") this.conversationId,
      this.lastMsg,
      this.avatar,
      this.updatedAt,
      this.isUserOnline = false});

  factory _$ChatUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatUserModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? type;
  @override
  @JsonKey(name: "conversation_id")
  final String? conversationId;
  @override
  final String? lastMsg;
  @override
  final String? avatar;
  @override
  final String? updatedAt;
  @override
  @JsonKey()
  final bool isUserOnline;

  @override
  String toString() {
    return 'ChatUserModel(id: $id, name: $name, type: $type, conversationId: $conversationId, lastMsg: $lastMsg, avatar: $avatar, updatedAt: $updatedAt, isUserOnline: $isUserOnline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.lastMsg, lastMsg) || other.lastMsg == lastMsg) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isUserOnline, isUserOnline) ||
                other.isUserOnline == isUserOnline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, conversationId,
      lastMsg, avatar, updatedAt, isUserOnline);

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatUserModelImplCopyWith<_$ChatUserModelImpl> get copyWith =>
      __$$ChatUserModelImplCopyWithImpl<_$ChatUserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatUserModelImplToJson(
      this,
    );
  }
}

abstract class _ChatUserModel implements ChatUserModel {
  factory _ChatUserModel(
      {final String? id,
      final String? name,
      final String? type,
      @JsonKey(name: "conversation_id") final String? conversationId,
      final String? lastMsg,
      final String? avatar,
      final String? updatedAt,
      final bool isUserOnline}) = _$ChatUserModelImpl;

  factory _ChatUserModel.fromJson(Map<String, dynamic> json) =
      _$ChatUserModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get type;
  @override
  @JsonKey(name: "conversation_id")
  String? get conversationId;
  @override
  String? get lastMsg;
  @override
  String? get avatar;
  @override
  String? get updatedAt;
  @override
  bool get isUserOnline;

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatUserModelImplCopyWith<_$ChatUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
