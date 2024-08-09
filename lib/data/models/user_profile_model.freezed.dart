// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return _UserProfileModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'isVerified')
  bool? get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'countryCode')
  int? get countryCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact')
  int? get contact => throw _privateConstructorUsedError;
  @JsonKey(name: 'post')
  String? get post => throw _privateConstructorUsedError;
  @JsonKey(name: 'worksAt')
  String? get worksAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'industry')
  List<String>? get industry => throw _privateConstructorUsedError;
  @JsonKey(name: 'expertise')
  List<String>? get expertise => throw _privateConstructorUsedError;
  @JsonKey(name: 'location')
  String? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatarSrc')
  String? get avatarSrc => throw _privateConstructorUsedError;
  @JsonKey(name: 'bannerSrc')
  String? get bannerSrc => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'postingAs')
  String? get postingAs => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender')
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'viewAccess')
  bool? get viewAccess => throw _privateConstructorUsedError;
  @JsonKey(name: 'userName')
  String? get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'about')
  String? get aboutMe => throw _privateConstructorUsedError;
  @JsonKey(name: 'devExpertise')
  List<String>? get devExpertise => throw _privateConstructorUsedError;
  @JsonKey(name: 'markExpertise')
  List<String>? get markExpertise => throw _privateConstructorUsedError;
  @JsonKey(name: 'clients')
  List<ClientsModel>? get clients => throw _privateConstructorUsedError;
  @JsonKey(name: 'experience')
  List<ExperienceModel>? get experience => throw _privateConstructorUsedError;
  @JsonKey(name: 'linkedinLink')
  String? get linkedinLink => throw _privateConstructorUsedError;
  @JsonKey(name: 'portfolioLink')
  String? get portfolioLink => throw _privateConstructorUsedError;
  @JsonKey(name: 'services')
  List<String>? get services => throw _privateConstructorUsedError;
  @JsonKey(name: 'testimonials')
  List<TestimonialsModel>? get testimonials =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'expDuration')
  String? get expDuration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProfileModelCopyWith<UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileModelCopyWith<$Res> {
  factory $UserProfileModelCopyWith(
          UserProfileModel value, $Res Function(UserProfileModel) then) =
      _$UserProfileModelCopyWithImpl<$Res, UserProfileModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'isVerified') bool? isVerified,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'countryCode') int? countryCode,
      @JsonKey(name: 'contact') int? contact,
      @JsonKey(name: 'post') String? post,
      @JsonKey(name: 'worksAt') String? worksAt,
      @JsonKey(name: 'industry') List<String>? industry,
      @JsonKey(name: 'expertise') List<String>? expertise,
      @JsonKey(name: 'location') String? location,
      @JsonKey(name: 'avatarSrc') String? avatarSrc,
      @JsonKey(name: 'bannerSrc') String? bannerSrc,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'updatedAt') String? updatedAt,
      @JsonKey(name: 'postingAs') String? postingAs,
      @JsonKey(name: 'gender') String? gender,
      @JsonKey(name: 'viewAccess') bool? viewAccess,
      @JsonKey(name: 'userName') String? userName,
      @JsonKey(name: 'about') String? aboutMe,
      @JsonKey(name: 'devExpertise') List<String>? devExpertise,
      @JsonKey(name: 'markExpertise') List<String>? markExpertise,
      @JsonKey(name: 'clients') List<ClientsModel>? clients,
      @JsonKey(name: 'experience') List<ExperienceModel>? experience,
      @JsonKey(name: 'linkedinLink') String? linkedinLink,
      @JsonKey(name: 'portfolioLink') String? portfolioLink,
      @JsonKey(name: 'services') List<String>? services,
      @JsonKey(name: 'testimonials') List<TestimonialsModel>? testimonials,
      @JsonKey(name: 'expDuration') String? expDuration});
}

/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res, $Val extends UserProfileModel>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? isVerified = freezed,
    Object? userId = freezed,
    Object? name = freezed,
    Object? countryCode = freezed,
    Object? contact = freezed,
    Object? post = freezed,
    Object? worksAt = freezed,
    Object? industry = freezed,
    Object? expertise = freezed,
    Object? location = freezed,
    Object? avatarSrc = freezed,
    Object? bannerSrc = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? postingAs = freezed,
    Object? gender = freezed,
    Object? viewAccess = freezed,
    Object? userName = freezed,
    Object? aboutMe = freezed,
    Object? devExpertise = freezed,
    Object? markExpertise = freezed,
    Object? clients = freezed,
    Object? experience = freezed,
    Object? linkedinLink = freezed,
    Object? portfolioLink = freezed,
    Object? services = freezed,
    Object? testimonials = freezed,
    Object? expDuration = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as int?,
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as int?,
      post: freezed == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as String?,
      worksAt: freezed == worksAt
          ? _value.worksAt
          : worksAt // ignore: cast_nullable_to_non_nullable
              as String?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      expertise: freezed == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarSrc: freezed == avatarSrc
          ? _value.avatarSrc
          : avatarSrc // ignore: cast_nullable_to_non_nullable
              as String?,
      bannerSrc: freezed == bannerSrc
          ? _value.bannerSrc
          : bannerSrc // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      postingAs: freezed == postingAs
          ? _value.postingAs
          : postingAs // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      viewAccess: freezed == viewAccess
          ? _value.viewAccess
          : viewAccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      aboutMe: freezed == aboutMe
          ? _value.aboutMe
          : aboutMe // ignore: cast_nullable_to_non_nullable
              as String?,
      devExpertise: freezed == devExpertise
          ? _value.devExpertise
          : devExpertise // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      markExpertise: freezed == markExpertise
          ? _value.markExpertise
          : markExpertise // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      clients: freezed == clients
          ? _value.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<ClientsModel>?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as List<ExperienceModel>?,
      linkedinLink: freezed == linkedinLink
          ? _value.linkedinLink
          : linkedinLink // ignore: cast_nullable_to_non_nullable
              as String?,
      portfolioLink: freezed == portfolioLink
          ? _value.portfolioLink
          : portfolioLink // ignore: cast_nullable_to_non_nullable
              as String?,
      services: freezed == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      testimonials: freezed == testimonials
          ? _value.testimonials
          : testimonials // ignore: cast_nullable_to_non_nullable
              as List<TestimonialsModel>?,
      expDuration: freezed == expDuration
          ? _value.expDuration
          : expDuration // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileModelImplCopyWith<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  factory _$$UserProfileModelImplCopyWith(_$UserProfileModelImpl value,
          $Res Function(_$UserProfileModelImpl) then) =
      __$$UserProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'isVerified') bool? isVerified,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'countryCode') int? countryCode,
      @JsonKey(name: 'contact') int? contact,
      @JsonKey(name: 'post') String? post,
      @JsonKey(name: 'worksAt') String? worksAt,
      @JsonKey(name: 'industry') List<String>? industry,
      @JsonKey(name: 'expertise') List<String>? expertise,
      @JsonKey(name: 'location') String? location,
      @JsonKey(name: 'avatarSrc') String? avatarSrc,
      @JsonKey(name: 'bannerSrc') String? bannerSrc,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'updatedAt') String? updatedAt,
      @JsonKey(name: 'postingAs') String? postingAs,
      @JsonKey(name: 'gender') String? gender,
      @JsonKey(name: 'viewAccess') bool? viewAccess,
      @JsonKey(name: 'userName') String? userName,
      @JsonKey(name: 'about') String? aboutMe,
      @JsonKey(name: 'devExpertise') List<String>? devExpertise,
      @JsonKey(name: 'markExpertise') List<String>? markExpertise,
      @JsonKey(name: 'clients') List<ClientsModel>? clients,
      @JsonKey(name: 'experience') List<ExperienceModel>? experience,
      @JsonKey(name: 'linkedinLink') String? linkedinLink,
      @JsonKey(name: 'portfolioLink') String? portfolioLink,
      @JsonKey(name: 'services') List<String>? services,
      @JsonKey(name: 'testimonials') List<TestimonialsModel>? testimonials,
      @JsonKey(name: 'expDuration') String? expDuration});
}

/// @nodoc
class __$$UserProfileModelImplCopyWithImpl<$Res>
    extends _$UserProfileModelCopyWithImpl<$Res, _$UserProfileModelImpl>
    implements _$$UserProfileModelImplCopyWith<$Res> {
  __$$UserProfileModelImplCopyWithImpl(_$UserProfileModelImpl _value,
      $Res Function(_$UserProfileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? isVerified = freezed,
    Object? userId = freezed,
    Object? name = freezed,
    Object? countryCode = freezed,
    Object? contact = freezed,
    Object? post = freezed,
    Object? worksAt = freezed,
    Object? industry = freezed,
    Object? expertise = freezed,
    Object? location = freezed,
    Object? avatarSrc = freezed,
    Object? bannerSrc = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? postingAs = freezed,
    Object? gender = freezed,
    Object? viewAccess = freezed,
    Object? userName = freezed,
    Object? aboutMe = freezed,
    Object? devExpertise = freezed,
    Object? markExpertise = freezed,
    Object? clients = freezed,
    Object? experience = freezed,
    Object? linkedinLink = freezed,
    Object? portfolioLink = freezed,
    Object? services = freezed,
    Object? testimonials = freezed,
    Object? expDuration = freezed,
  }) {
    return _then(_$UserProfileModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as int?,
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as int?,
      post: freezed == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as String?,
      worksAt: freezed == worksAt
          ? _value.worksAt
          : worksAt // ignore: cast_nullable_to_non_nullable
              as String?,
      industry: freezed == industry
          ? _value._industry
          : industry // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      expertise: freezed == expertise
          ? _value._expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarSrc: freezed == avatarSrc
          ? _value.avatarSrc
          : avatarSrc // ignore: cast_nullable_to_non_nullable
              as String?,
      bannerSrc: freezed == bannerSrc
          ? _value.bannerSrc
          : bannerSrc // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      postingAs: freezed == postingAs
          ? _value.postingAs
          : postingAs // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      viewAccess: freezed == viewAccess
          ? _value.viewAccess
          : viewAccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      aboutMe: freezed == aboutMe
          ? _value.aboutMe
          : aboutMe // ignore: cast_nullable_to_non_nullable
              as String?,
      devExpertise: freezed == devExpertise
          ? _value._devExpertise
          : devExpertise // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      markExpertise: freezed == markExpertise
          ? _value._markExpertise
          : markExpertise // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      clients: freezed == clients
          ? _value._clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<ClientsModel>?,
      experience: freezed == experience
          ? _value._experience
          : experience // ignore: cast_nullable_to_non_nullable
              as List<ExperienceModel>?,
      linkedinLink: freezed == linkedinLink
          ? _value.linkedinLink
          : linkedinLink // ignore: cast_nullable_to_non_nullable
              as String?,
      portfolioLink: freezed == portfolioLink
          ? _value.portfolioLink
          : portfolioLink // ignore: cast_nullable_to_non_nullable
              as String?,
      services: freezed == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      testimonials: freezed == testimonials
          ? _value._testimonials
          : testimonials // ignore: cast_nullable_to_non_nullable
              as List<TestimonialsModel>?,
      expDuration: freezed == expDuration
          ? _value.expDuration
          : expDuration // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileModelImpl implements _UserProfileModel {
  _$UserProfileModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'isVerified') this.isVerified,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'countryCode') this.countryCode,
      @JsonKey(name: 'contact') this.contact,
      @JsonKey(name: 'post') this.post,
      @JsonKey(name: 'worksAt') this.worksAt,
      @JsonKey(name: 'industry') final List<String>? industry,
      @JsonKey(name: 'expertise') final List<String>? expertise,
      @JsonKey(name: 'location') this.location,
      @JsonKey(name: 'avatarSrc') this.avatarSrc,
      @JsonKey(name: 'bannerSrc') this.bannerSrc,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'updatedAt') this.updatedAt,
      @JsonKey(name: 'postingAs') this.postingAs,
      @JsonKey(name: 'gender') this.gender,
      @JsonKey(name: 'viewAccess') this.viewAccess,
      @JsonKey(name: 'userName') this.userName,
      @JsonKey(name: 'about') this.aboutMe,
      @JsonKey(name: 'devExpertise') final List<String>? devExpertise,
      @JsonKey(name: 'markExpertise') final List<String>? markExpertise,
      @JsonKey(name: 'clients') final List<ClientsModel>? clients,
      @JsonKey(name: 'experience') final List<ExperienceModel>? experience,
      @JsonKey(name: 'linkedinLink') this.linkedinLink,
      @JsonKey(name: 'portfolioLink') this.portfolioLink,
      @JsonKey(name: 'services') final List<String>? services,
      @JsonKey(name: 'testimonials')
      final List<TestimonialsModel>? testimonials,
      @JsonKey(name: 'expDuration') this.expDuration})
      : _industry = industry,
        _expertise = expertise,
        _devExpertise = devExpertise,
        _markExpertise = markExpertise,
        _clients = clients,
        _experience = experience,
        _services = services,
        _testimonials = testimonials;

  factory _$UserProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'isVerified')
  final bool? isVerified;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'countryCode')
  final int? countryCode;
  @override
  @JsonKey(name: 'contact')
  final int? contact;
  @override
  @JsonKey(name: 'post')
  final String? post;
  @override
  @JsonKey(name: 'worksAt')
  final String? worksAt;
  final List<String>? _industry;
  @override
  @JsonKey(name: 'industry')
  List<String>? get industry {
    final value = _industry;
    if (value == null) return null;
    if (_industry is EqualUnmodifiableListView) return _industry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _expertise;
  @override
  @JsonKey(name: 'expertise')
  List<String>? get expertise {
    final value = _expertise;
    if (value == null) return null;
    if (_expertise is EqualUnmodifiableListView) return _expertise;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'location')
  final String? location;
  @override
  @JsonKey(name: 'avatarSrc')
  final String? avatarSrc;
  @override
  @JsonKey(name: 'bannerSrc')
  final String? bannerSrc;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @override
  @JsonKey(name: 'postingAs')
  final String? postingAs;
  @override
  @JsonKey(name: 'gender')
  final String? gender;
  @override
  @JsonKey(name: 'viewAccess')
  final bool? viewAccess;
  @override
  @JsonKey(name: 'userName')
  final String? userName;
  @override
  @JsonKey(name: 'about')
  final String? aboutMe;
  final List<String>? _devExpertise;
  @override
  @JsonKey(name: 'devExpertise')
  List<String>? get devExpertise {
    final value = _devExpertise;
    if (value == null) return null;
    if (_devExpertise is EqualUnmodifiableListView) return _devExpertise;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _markExpertise;
  @override
  @JsonKey(name: 'markExpertise')
  List<String>? get markExpertise {
    final value = _markExpertise;
    if (value == null) return null;
    if (_markExpertise is EqualUnmodifiableListView) return _markExpertise;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ClientsModel>? _clients;
  @override
  @JsonKey(name: 'clients')
  List<ClientsModel>? get clients {
    final value = _clients;
    if (value == null) return null;
    if (_clients is EqualUnmodifiableListView) return _clients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExperienceModel>? _experience;
  @override
  @JsonKey(name: 'experience')
  List<ExperienceModel>? get experience {
    final value = _experience;
    if (value == null) return null;
    if (_experience is EqualUnmodifiableListView) return _experience;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'linkedinLink')
  final String? linkedinLink;
  @override
  @JsonKey(name: 'portfolioLink')
  final String? portfolioLink;
  final List<String>? _services;
  @override
  @JsonKey(name: 'services')
  List<String>? get services {
    final value = _services;
    if (value == null) return null;
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TestimonialsModel>? _testimonials;
  @override
  @JsonKey(name: 'testimonials')
  List<TestimonialsModel>? get testimonials {
    final value = _testimonials;
    if (value == null) return null;
    if (_testimonials is EqualUnmodifiableListView) return _testimonials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'expDuration')
  final String? expDuration;

  @override
  String toString() {
    return 'UserProfileModel(id: $id, isVerified: $isVerified, userId: $userId, name: $name, countryCode: $countryCode, contact: $contact, post: $post, worksAt: $worksAt, industry: $industry, expertise: $expertise, location: $location, avatarSrc: $avatarSrc, bannerSrc: $bannerSrc, createdAt: $createdAt, updatedAt: $updatedAt, postingAs: $postingAs, gender: $gender, viewAccess: $viewAccess, userName: $userName, aboutMe: $aboutMe, devExpertise: $devExpertise, markExpertise: $markExpertise, clients: $clients, experience: $experience, linkedinLink: $linkedinLink, portfolioLink: $portfolioLink, services: $services, testimonials: $testimonials, expDuration: $expDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.post, post) || other.post == post) &&
            (identical(other.worksAt, worksAt) || other.worksAt == worksAt) &&
            const DeepCollectionEquality().equals(other._industry, _industry) &&
            const DeepCollectionEquality()
                .equals(other._expertise, _expertise) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.avatarSrc, avatarSrc) ||
                other.avatarSrc == avatarSrc) &&
            (identical(other.bannerSrc, bannerSrc) ||
                other.bannerSrc == bannerSrc) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.postingAs, postingAs) ||
                other.postingAs == postingAs) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.viewAccess, viewAccess) ||
                other.viewAccess == viewAccess) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.aboutMe, aboutMe) || other.aboutMe == aboutMe) &&
            const DeepCollectionEquality()
                .equals(other._devExpertise, _devExpertise) &&
            const DeepCollectionEquality()
                .equals(other._markExpertise, _markExpertise) &&
            const DeepCollectionEquality().equals(other._clients, _clients) &&
            const DeepCollectionEquality()
                .equals(other._experience, _experience) &&
            (identical(other.linkedinLink, linkedinLink) ||
                other.linkedinLink == linkedinLink) &&
            (identical(other.portfolioLink, portfolioLink) ||
                other.portfolioLink == portfolioLink) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            const DeepCollectionEquality()
                .equals(other._testimonials, _testimonials) &&
            (identical(other.expDuration, expDuration) ||
                other.expDuration == expDuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        isVerified,
        userId,
        name,
        countryCode,
        contact,
        post,
        worksAt,
        const DeepCollectionEquality().hash(_industry),
        const DeepCollectionEquality().hash(_expertise),
        location,
        avatarSrc,
        bannerSrc,
        createdAt,
        updatedAt,
        postingAs,
        gender,
        viewAccess,
        userName,
        aboutMe,
        const DeepCollectionEquality().hash(_devExpertise),
        const DeepCollectionEquality().hash(_markExpertise),
        const DeepCollectionEquality().hash(_clients),
        const DeepCollectionEquality().hash(_experience),
        linkedinLink,
        portfolioLink,
        const DeepCollectionEquality().hash(_services),
        const DeepCollectionEquality().hash(_testimonials),
        expDuration
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      __$$UserProfileModelImplCopyWithImpl<_$UserProfileModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileModelImplToJson(
      this,
    );
  }
}

abstract class _UserProfileModel implements UserProfileModel {
  factory _UserProfileModel(
          {@JsonKey(name: '_id') final String? id,
          @JsonKey(name: 'isVerified') final bool? isVerified,
          @JsonKey(name: 'user_id') final String? userId,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'countryCode') final int? countryCode,
          @JsonKey(name: 'contact') final int? contact,
          @JsonKey(name: 'post') final String? post,
          @JsonKey(name: 'worksAt') final String? worksAt,
          @JsonKey(name: 'industry') final List<String>? industry,
          @JsonKey(name: 'expertise') final List<String>? expertise,
          @JsonKey(name: 'location') final String? location,
          @JsonKey(name: 'avatarSrc') final String? avatarSrc,
          @JsonKey(name: 'bannerSrc') final String? bannerSrc,
          @JsonKey(name: 'createdAt') final String? createdAt,
          @JsonKey(name: 'updatedAt') final String? updatedAt,
          @JsonKey(name: 'postingAs') final String? postingAs,
          @JsonKey(name: 'gender') final String? gender,
          @JsonKey(name: 'viewAccess') final bool? viewAccess,
          @JsonKey(name: 'userName') final String? userName,
          @JsonKey(name: 'about') final String? aboutMe,
          @JsonKey(name: 'devExpertise') final List<String>? devExpertise,
          @JsonKey(name: 'markExpertise') final List<String>? markExpertise,
          @JsonKey(name: 'clients') final List<ClientsModel>? clients,
          @JsonKey(name: 'experience') final List<ExperienceModel>? experience,
          @JsonKey(name: 'linkedinLink') final String? linkedinLink,
          @JsonKey(name: 'portfolioLink') final String? portfolioLink,
          @JsonKey(name: 'services') final List<String>? services,
          @JsonKey(name: 'testimonials')
          final List<TestimonialsModel>? testimonials,
          @JsonKey(name: 'expDuration') final String? expDuration}) =
      _$UserProfileModelImpl;

  factory _UserProfileModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'isVerified')
  bool? get isVerified;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'countryCode')
  int? get countryCode;
  @override
  @JsonKey(name: 'contact')
  int? get contact;
  @override
  @JsonKey(name: 'post')
  String? get post;
  @override
  @JsonKey(name: 'worksAt')
  String? get worksAt;
  @override
  @JsonKey(name: 'industry')
  List<String>? get industry;
  @override
  @JsonKey(name: 'expertise')
  List<String>? get expertise;
  @override
  @JsonKey(name: 'location')
  String? get location;
  @override
  @JsonKey(name: 'avatarSrc')
  String? get avatarSrc;
  @override
  @JsonKey(name: 'bannerSrc')
  String? get bannerSrc;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  String? get updatedAt;
  @override
  @JsonKey(name: 'postingAs')
  String? get postingAs;
  @override
  @JsonKey(name: 'gender')
  String? get gender;
  @override
  @JsonKey(name: 'viewAccess')
  bool? get viewAccess;
  @override
  @JsonKey(name: 'userName')
  String? get userName;
  @override
  @JsonKey(name: 'about')
  String? get aboutMe;
  @override
  @JsonKey(name: 'devExpertise')
  List<String>? get devExpertise;
  @override
  @JsonKey(name: 'markExpertise')
  List<String>? get markExpertise;
  @override
  @JsonKey(name: 'clients')
  List<ClientsModel>? get clients;
  @override
  @JsonKey(name: 'experience')
  List<ExperienceModel>? get experience;
  @override
  @JsonKey(name: 'linkedinLink')
  String? get linkedinLink;
  @override
  @JsonKey(name: 'portfolioLink')
  String? get portfolioLink;
  @override
  @JsonKey(name: 'services')
  List<String>? get services;
  @override
  @JsonKey(name: 'testimonials')
  List<TestimonialsModel>? get testimonials;
  @override
  @JsonKey(name: 'expDuration')
  String? get expDuration;
  @override
  @JsonKey(ignore: true)
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
