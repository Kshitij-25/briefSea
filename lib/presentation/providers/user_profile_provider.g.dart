// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileRemoteDataSourceHash() =>
    r'1cf5ea256cbffe443178ec982337d79388e49ce5';

/// See also [userProfileRemoteDataSource].
@ProviderFor(userProfileRemoteDataSource)
final userProfileRemoteDataSourceProvider =
    AutoDisposeProvider<UserProfileRemoteDataSource>.internal(
  userProfileRemoteDataSource,
  name: r'userProfileRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userProfileRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserProfileRemoteDataSourceRef
    = AutoDisposeProviderRef<UserProfileRemoteDataSource>;
String _$userProfileRepositoryHash() =>
    r'153b27dc3ce8b701d907831a159edc54b4cfe1b2';

/// See also [userProfileRepository].
@ProviderFor(userProfileRepository)
final userProfileRepositoryProvider =
    AutoDisposeProvider<UserProfileRepository>.internal(
  userProfileRepository,
  name: r'userProfileRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userProfileRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserProfileRepositoryRef
    = AutoDisposeProviderRef<UserProfileRepository>;
String _$getUserProfileHash() => r'2274ca6da651f35679fe9be5a804de9b1d3edbf3';

/// See also [getUserProfile].
@ProviderFor(getUserProfile)
final getUserProfileProvider =
    AutoDisposeFutureProvider<UserProfileModel>.internal(
  getUserProfile,
  name: r'getUserProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUserProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetUserProfileRef = AutoDisposeFutureProviderRef<UserProfileModel>;
String _$getOtherProfileHash() => r'ba671d8b4a4c905195a32ae58b2479fa7046d942';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getOtherProfile].
@ProviderFor(getOtherProfile)
const getOtherProfileProvider = GetOtherProfileFamily();

/// See also [getOtherProfile].
class GetOtherProfileFamily extends Family<AsyncValue<UserProfileModel>> {
  /// See also [getOtherProfile].
  const GetOtherProfileFamily();

  /// See also [getOtherProfile].
  GetOtherProfileProvider call({
    required String? otherUserId,
  }) {
    return GetOtherProfileProvider(
      otherUserId: otherUserId,
    );
  }

  @override
  GetOtherProfileProvider getProviderOverride(
    covariant GetOtherProfileProvider provider,
  ) {
    return call(
      otherUserId: provider.otherUserId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getOtherProfileProvider';
}

/// See also [getOtherProfile].
class GetOtherProfileProvider
    extends AutoDisposeFutureProvider<UserProfileModel> {
  /// See also [getOtherProfile].
  GetOtherProfileProvider({
    required String? otherUserId,
  }) : this._internal(
          (ref) => getOtherProfile(
            ref as GetOtherProfileRef,
            otherUserId: otherUserId,
          ),
          from: getOtherProfileProvider,
          name: r'getOtherProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getOtherProfileHash,
          dependencies: GetOtherProfileFamily._dependencies,
          allTransitiveDependencies:
              GetOtherProfileFamily._allTransitiveDependencies,
          otherUserId: otherUserId,
        );

  GetOtherProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.otherUserId,
  }) : super.internal();

  final String? otherUserId;

  @override
  Override overrideWith(
    FutureOr<UserProfileModel> Function(GetOtherProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetOtherProfileProvider._internal(
        (ref) => create(ref as GetOtherProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        otherUserId: otherUserId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserProfileModel> createElement() {
    return _GetOtherProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOtherProfileProvider && other.otherUserId == otherUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, otherUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetOtherProfileRef on AutoDisposeFutureProviderRef<UserProfileModel> {
  /// The parameter `otherUserId` of this provider.
  String? get otherUserId;
}

class _GetOtherProfileProviderElement
    extends AutoDisposeFutureProviderElement<UserProfileModel>
    with GetOtherProfileRef {
  _GetOtherProfileProviderElement(super.provider);

  @override
  String? get otherUserId => (origin as GetOtherProfileProvider).otherUserId;
}

String _$verifyProfileHash() => r'5323d2e00f9f63f56d1ee1e74407dcfcf08d6d06';

/// See also [verifyProfile].
@ProviderFor(verifyProfile)
const verifyProfileProvider = VerifyProfileFamily();

/// See also [verifyProfile].
class VerifyProfileFamily extends Family<AsyncValue<String>> {
  /// See also [verifyProfile].
  const VerifyProfileFamily();

  /// See also [verifyProfile].
  VerifyProfileProvider call({
    required String? userId,
    required String? uName,
    required int? countryCode,
    required int? contact,
    required String? jobTitle,
    required String? company,
    required List<String>? industry,
    required List<String>? expertise,
    required String? location,
    required String? avatarSrc,
    required String? bannerSrc,
    required String? jwtToken,
    required String? postingAs,
    required String? gender,
    required String? username,
  }) {
    return VerifyProfileProvider(
      userId: userId,
      uName: uName,
      countryCode: countryCode,
      contact: contact,
      jobTitle: jobTitle,
      company: company,
      industry: industry,
      expertise: expertise,
      location: location,
      avatarSrc: avatarSrc,
      bannerSrc: bannerSrc,
      jwtToken: jwtToken,
      postingAs: postingAs,
      gender: gender,
      username: username,
    );
  }

  @override
  VerifyProfileProvider getProviderOverride(
    covariant VerifyProfileProvider provider,
  ) {
    return call(
      userId: provider.userId,
      uName: provider.uName,
      countryCode: provider.countryCode,
      contact: provider.contact,
      jobTitle: provider.jobTitle,
      company: provider.company,
      industry: provider.industry,
      expertise: provider.expertise,
      location: provider.location,
      avatarSrc: provider.avatarSrc,
      bannerSrc: provider.bannerSrc,
      jwtToken: provider.jwtToken,
      postingAs: provider.postingAs,
      gender: provider.gender,
      username: provider.username,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'verifyProfileProvider';
}

/// See also [verifyProfile].
class VerifyProfileProvider extends AutoDisposeFutureProvider<String> {
  /// See also [verifyProfile].
  VerifyProfileProvider({
    required String? userId,
    required String? uName,
    required int? countryCode,
    required int? contact,
    required String? jobTitle,
    required String? company,
    required List<String>? industry,
    required List<String>? expertise,
    required String? location,
    required String? avatarSrc,
    required String? bannerSrc,
    required String? jwtToken,
    required String? postingAs,
    required String? gender,
    required String? username,
  }) : this._internal(
          (ref) => verifyProfile(
            ref as VerifyProfileRef,
            userId: userId,
            uName: uName,
            countryCode: countryCode,
            contact: contact,
            jobTitle: jobTitle,
            company: company,
            industry: industry,
            expertise: expertise,
            location: location,
            avatarSrc: avatarSrc,
            bannerSrc: bannerSrc,
            jwtToken: jwtToken,
            postingAs: postingAs,
            gender: gender,
            username: username,
          ),
          from: verifyProfileProvider,
          name: r'verifyProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$verifyProfileHash,
          dependencies: VerifyProfileFamily._dependencies,
          allTransitiveDependencies:
              VerifyProfileFamily._allTransitiveDependencies,
          userId: userId,
          uName: uName,
          countryCode: countryCode,
          contact: contact,
          jobTitle: jobTitle,
          company: company,
          industry: industry,
          expertise: expertise,
          location: location,
          avatarSrc: avatarSrc,
          bannerSrc: bannerSrc,
          jwtToken: jwtToken,
          postingAs: postingAs,
          gender: gender,
          username: username,
        );

  VerifyProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.uName,
    required this.countryCode,
    required this.contact,
    required this.jobTitle,
    required this.company,
    required this.industry,
    required this.expertise,
    required this.location,
    required this.avatarSrc,
    required this.bannerSrc,
    required this.jwtToken,
    required this.postingAs,
    required this.gender,
    required this.username,
  }) : super.internal();

  final String? userId;
  final String? uName;
  final int? countryCode;
  final int? contact;
  final String? jobTitle;
  final String? company;
  final List<String>? industry;
  final List<String>? expertise;
  final String? location;
  final String? avatarSrc;
  final String? bannerSrc;
  final String? jwtToken;
  final String? postingAs;
  final String? gender;
  final String? username;

  @override
  Override overrideWith(
    FutureOr<String> Function(VerifyProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VerifyProfileProvider._internal(
        (ref) => create(ref as VerifyProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        uName: uName,
        countryCode: countryCode,
        contact: contact,
        jobTitle: jobTitle,
        company: company,
        industry: industry,
        expertise: expertise,
        location: location,
        avatarSrc: avatarSrc,
        bannerSrc: bannerSrc,
        jwtToken: jwtToken,
        postingAs: postingAs,
        gender: gender,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _VerifyProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VerifyProfileProvider &&
        other.userId == userId &&
        other.uName == uName &&
        other.countryCode == countryCode &&
        other.contact == contact &&
        other.jobTitle == jobTitle &&
        other.company == company &&
        other.industry == industry &&
        other.expertise == expertise &&
        other.location == location &&
        other.avatarSrc == avatarSrc &&
        other.bannerSrc == bannerSrc &&
        other.jwtToken == jwtToken &&
        other.postingAs == postingAs &&
        other.gender == gender &&
        other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, uName.hashCode);
    hash = _SystemHash.combine(hash, countryCode.hashCode);
    hash = _SystemHash.combine(hash, contact.hashCode);
    hash = _SystemHash.combine(hash, jobTitle.hashCode);
    hash = _SystemHash.combine(hash, company.hashCode);
    hash = _SystemHash.combine(hash, industry.hashCode);
    hash = _SystemHash.combine(hash, expertise.hashCode);
    hash = _SystemHash.combine(hash, location.hashCode);
    hash = _SystemHash.combine(hash, avatarSrc.hashCode);
    hash = _SystemHash.combine(hash, bannerSrc.hashCode);
    hash = _SystemHash.combine(hash, jwtToken.hashCode);
    hash = _SystemHash.combine(hash, postingAs.hashCode);
    hash = _SystemHash.combine(hash, gender.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin VerifyProfileRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `userId` of this provider.
  String? get userId;

  /// The parameter `uName` of this provider.
  String? get uName;

  /// The parameter `countryCode` of this provider.
  int? get countryCode;

  /// The parameter `contact` of this provider.
  int? get contact;

  /// The parameter `jobTitle` of this provider.
  String? get jobTitle;

  /// The parameter `company` of this provider.
  String? get company;

  /// The parameter `industry` of this provider.
  List<String>? get industry;

  /// The parameter `expertise` of this provider.
  List<String>? get expertise;

  /// The parameter `location` of this provider.
  String? get location;

  /// The parameter `avatarSrc` of this provider.
  String? get avatarSrc;

  /// The parameter `bannerSrc` of this provider.
  String? get bannerSrc;

  /// The parameter `jwtToken` of this provider.
  String? get jwtToken;

  /// The parameter `postingAs` of this provider.
  String? get postingAs;

  /// The parameter `gender` of this provider.
  String? get gender;

  /// The parameter `username` of this provider.
  String? get username;
}

class _VerifyProfileProviderElement
    extends AutoDisposeFutureProviderElement<String> with VerifyProfileRef {
  _VerifyProfileProviderElement(super.provider);

  @override
  String? get userId => (origin as VerifyProfileProvider).userId;
  @override
  String? get uName => (origin as VerifyProfileProvider).uName;
  @override
  int? get countryCode => (origin as VerifyProfileProvider).countryCode;
  @override
  int? get contact => (origin as VerifyProfileProvider).contact;
  @override
  String? get jobTitle => (origin as VerifyProfileProvider).jobTitle;
  @override
  String? get company => (origin as VerifyProfileProvider).company;
  @override
  List<String>? get industry => (origin as VerifyProfileProvider).industry;
  @override
  List<String>? get expertise => (origin as VerifyProfileProvider).expertise;
  @override
  String? get location => (origin as VerifyProfileProvider).location;
  @override
  String? get avatarSrc => (origin as VerifyProfileProvider).avatarSrc;
  @override
  String? get bannerSrc => (origin as VerifyProfileProvider).bannerSrc;
  @override
  String? get jwtToken => (origin as VerifyProfileProvider).jwtToken;
  @override
  String? get postingAs => (origin as VerifyProfileProvider).postingAs;
  @override
  String? get gender => (origin as VerifyProfileProvider).gender;
  @override
  String? get username => (origin as VerifyProfileProvider).username;
}

String _$editProfileHash() => r'7df947431a2ab0d2138b7379d0c5a8d6b49dfb92';

/// See also [editProfile].
@ProviderFor(editProfile)
const editProfileProvider = EditProfileFamily();

/// See also [editProfile].
class EditProfileFamily extends Family<AsyncValue<EditProfileModel>> {
  /// See also [editProfile].
  const EditProfileFamily();

  /// See also [editProfile].
  EditProfileProvider call({
    required String? userId,
    required String? uName,
    required int? countryCode,
    required int? contact,
    required String? jobTitle,
    required String? company,
    required List<String>? industry,
    required List<String>? expertise,
    required String? location,
    required String? avatarSrc,
    required String? bannerSrc,
    required String? jwtToken,
    required String? postingAs,
    required String? gender,
    required String? createdAt,
    required String? updatedAt,
    required String? userName,
    required bool? viewAccess,
  }) {
    return EditProfileProvider(
      userId: userId,
      uName: uName,
      countryCode: countryCode,
      contact: contact,
      jobTitle: jobTitle,
      company: company,
      industry: industry,
      expertise: expertise,
      location: location,
      avatarSrc: avatarSrc,
      bannerSrc: bannerSrc,
      jwtToken: jwtToken,
      postingAs: postingAs,
      gender: gender,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userName: userName,
      viewAccess: viewAccess,
    );
  }

  @override
  EditProfileProvider getProviderOverride(
    covariant EditProfileProvider provider,
  ) {
    return call(
      userId: provider.userId,
      uName: provider.uName,
      countryCode: provider.countryCode,
      contact: provider.contact,
      jobTitle: provider.jobTitle,
      company: provider.company,
      industry: provider.industry,
      expertise: provider.expertise,
      location: provider.location,
      avatarSrc: provider.avatarSrc,
      bannerSrc: provider.bannerSrc,
      jwtToken: provider.jwtToken,
      postingAs: provider.postingAs,
      gender: provider.gender,
      createdAt: provider.createdAt,
      updatedAt: provider.updatedAt,
      userName: provider.userName,
      viewAccess: provider.viewAccess,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editProfileProvider';
}

/// See also [editProfile].
class EditProfileProvider extends AutoDisposeFutureProvider<EditProfileModel> {
  /// See also [editProfile].
  EditProfileProvider({
    required String? userId,
    required String? uName,
    required int? countryCode,
    required int? contact,
    required String? jobTitle,
    required String? company,
    required List<String>? industry,
    required List<String>? expertise,
    required String? location,
    required String? avatarSrc,
    required String? bannerSrc,
    required String? jwtToken,
    required String? postingAs,
    required String? gender,
    required String? createdAt,
    required String? updatedAt,
    required String? userName,
    required bool? viewAccess,
  }) : this._internal(
          (ref) => editProfile(
            ref as EditProfileRef,
            userId: userId,
            uName: uName,
            countryCode: countryCode,
            contact: contact,
            jobTitle: jobTitle,
            company: company,
            industry: industry,
            expertise: expertise,
            location: location,
            avatarSrc: avatarSrc,
            bannerSrc: bannerSrc,
            jwtToken: jwtToken,
            postingAs: postingAs,
            gender: gender,
            createdAt: createdAt,
            updatedAt: updatedAt,
            userName: userName,
            viewAccess: viewAccess,
          ),
          from: editProfileProvider,
          name: r'editProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editProfileHash,
          dependencies: EditProfileFamily._dependencies,
          allTransitiveDependencies:
              EditProfileFamily._allTransitiveDependencies,
          userId: userId,
          uName: uName,
          countryCode: countryCode,
          contact: contact,
          jobTitle: jobTitle,
          company: company,
          industry: industry,
          expertise: expertise,
          location: location,
          avatarSrc: avatarSrc,
          bannerSrc: bannerSrc,
          jwtToken: jwtToken,
          postingAs: postingAs,
          gender: gender,
          createdAt: createdAt,
          updatedAt: updatedAt,
          userName: userName,
          viewAccess: viewAccess,
        );

  EditProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.uName,
    required this.countryCode,
    required this.contact,
    required this.jobTitle,
    required this.company,
    required this.industry,
    required this.expertise,
    required this.location,
    required this.avatarSrc,
    required this.bannerSrc,
    required this.jwtToken,
    required this.postingAs,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.viewAccess,
  }) : super.internal();

  final String? userId;
  final String? uName;
  final int? countryCode;
  final int? contact;
  final String? jobTitle;
  final String? company;
  final List<String>? industry;
  final List<String>? expertise;
  final String? location;
  final String? avatarSrc;
  final String? bannerSrc;
  final String? jwtToken;
  final String? postingAs;
  final String? gender;
  final String? createdAt;
  final String? updatedAt;
  final String? userName;
  final bool? viewAccess;

  @override
  Override overrideWith(
    FutureOr<EditProfileModel> Function(EditProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditProfileProvider._internal(
        (ref) => create(ref as EditProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        uName: uName,
        countryCode: countryCode,
        contact: contact,
        jobTitle: jobTitle,
        company: company,
        industry: industry,
        expertise: expertise,
        location: location,
        avatarSrc: avatarSrc,
        bannerSrc: bannerSrc,
        jwtToken: jwtToken,
        postingAs: postingAs,
        gender: gender,
        createdAt: createdAt,
        updatedAt: updatedAt,
        userName: userName,
        viewAccess: viewAccess,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<EditProfileModel> createElement() {
    return _EditProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditProfileProvider &&
        other.userId == userId &&
        other.uName == uName &&
        other.countryCode == countryCode &&
        other.contact == contact &&
        other.jobTitle == jobTitle &&
        other.company == company &&
        other.industry == industry &&
        other.expertise == expertise &&
        other.location == location &&
        other.avatarSrc == avatarSrc &&
        other.bannerSrc == bannerSrc &&
        other.jwtToken == jwtToken &&
        other.postingAs == postingAs &&
        other.gender == gender &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.userName == userName &&
        other.viewAccess == viewAccess;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, uName.hashCode);
    hash = _SystemHash.combine(hash, countryCode.hashCode);
    hash = _SystemHash.combine(hash, contact.hashCode);
    hash = _SystemHash.combine(hash, jobTitle.hashCode);
    hash = _SystemHash.combine(hash, company.hashCode);
    hash = _SystemHash.combine(hash, industry.hashCode);
    hash = _SystemHash.combine(hash, expertise.hashCode);
    hash = _SystemHash.combine(hash, location.hashCode);
    hash = _SystemHash.combine(hash, avatarSrc.hashCode);
    hash = _SystemHash.combine(hash, bannerSrc.hashCode);
    hash = _SystemHash.combine(hash, jwtToken.hashCode);
    hash = _SystemHash.combine(hash, postingAs.hashCode);
    hash = _SystemHash.combine(hash, gender.hashCode);
    hash = _SystemHash.combine(hash, createdAt.hashCode);
    hash = _SystemHash.combine(hash, updatedAt.hashCode);
    hash = _SystemHash.combine(hash, userName.hashCode);
    hash = _SystemHash.combine(hash, viewAccess.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditProfileRef on AutoDisposeFutureProviderRef<EditProfileModel> {
  /// The parameter `userId` of this provider.
  String? get userId;

  /// The parameter `uName` of this provider.
  String? get uName;

  /// The parameter `countryCode` of this provider.
  int? get countryCode;

  /// The parameter `contact` of this provider.
  int? get contact;

  /// The parameter `jobTitle` of this provider.
  String? get jobTitle;

  /// The parameter `company` of this provider.
  String? get company;

  /// The parameter `industry` of this provider.
  List<String>? get industry;

  /// The parameter `expertise` of this provider.
  List<String>? get expertise;

  /// The parameter `location` of this provider.
  String? get location;

  /// The parameter `avatarSrc` of this provider.
  String? get avatarSrc;

  /// The parameter `bannerSrc` of this provider.
  String? get bannerSrc;

  /// The parameter `jwtToken` of this provider.
  String? get jwtToken;

  /// The parameter `postingAs` of this provider.
  String? get postingAs;

  /// The parameter `gender` of this provider.
  String? get gender;

  /// The parameter `createdAt` of this provider.
  String? get createdAt;

  /// The parameter `updatedAt` of this provider.
  String? get updatedAt;

  /// The parameter `userName` of this provider.
  String? get userName;

  /// The parameter `viewAccess` of this provider.
  bool? get viewAccess;
}

class _EditProfileProviderElement
    extends AutoDisposeFutureProviderElement<EditProfileModel>
    with EditProfileRef {
  _EditProfileProviderElement(super.provider);

  @override
  String? get userId => (origin as EditProfileProvider).userId;
  @override
  String? get uName => (origin as EditProfileProvider).uName;
  @override
  int? get countryCode => (origin as EditProfileProvider).countryCode;
  @override
  int? get contact => (origin as EditProfileProvider).contact;
  @override
  String? get jobTitle => (origin as EditProfileProvider).jobTitle;
  @override
  String? get company => (origin as EditProfileProvider).company;
  @override
  List<String>? get industry => (origin as EditProfileProvider).industry;
  @override
  List<String>? get expertise => (origin as EditProfileProvider).expertise;
  @override
  String? get location => (origin as EditProfileProvider).location;
  @override
  String? get avatarSrc => (origin as EditProfileProvider).avatarSrc;
  @override
  String? get bannerSrc => (origin as EditProfileProvider).bannerSrc;
  @override
  String? get jwtToken => (origin as EditProfileProvider).jwtToken;
  @override
  String? get postingAs => (origin as EditProfileProvider).postingAs;
  @override
  String? get gender => (origin as EditProfileProvider).gender;
  @override
  String? get createdAt => (origin as EditProfileProvider).createdAt;
  @override
  String? get updatedAt => (origin as EditProfileProvider).updatedAt;
  @override
  String? get userName => (origin as EditProfileProvider).userName;
  @override
  bool? get viewAccess => (origin as EditProfileProvider).viewAccess;
}

String _$uploadAvatarHash() => r'77d74af3c84698c8b1a0895e9a8230d3db34a264';

/// See also [uploadAvatar].
@ProviderFor(uploadAvatar)
const uploadAvatarProvider = UploadAvatarFamily();

/// See also [uploadAvatar].
class UploadAvatarFamily extends Family<AsyncValue<AvatarModel>> {
  /// See also [uploadAvatar].
  const UploadAvatarFamily();

  /// See also [uploadAvatar].
  UploadAvatarProvider call({
    required String? fileName,
    required String? fileType,
    required String? userId,
    required String? userType,
  }) {
    return UploadAvatarProvider(
      fileName: fileName,
      fileType: fileType,
      userId: userId,
      userType: userType,
    );
  }

  @override
  UploadAvatarProvider getProviderOverride(
    covariant UploadAvatarProvider provider,
  ) {
    return call(
      fileName: provider.fileName,
      fileType: provider.fileType,
      userId: provider.userId,
      userType: provider.userType,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'uploadAvatarProvider';
}

/// See also [uploadAvatar].
class UploadAvatarProvider extends AutoDisposeFutureProvider<AvatarModel> {
  /// See also [uploadAvatar].
  UploadAvatarProvider({
    required String? fileName,
    required String? fileType,
    required String? userId,
    required String? userType,
  }) : this._internal(
          (ref) => uploadAvatar(
            ref as UploadAvatarRef,
            fileName: fileName,
            fileType: fileType,
            userId: userId,
            userType: userType,
          ),
          from: uploadAvatarProvider,
          name: r'uploadAvatarProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$uploadAvatarHash,
          dependencies: UploadAvatarFamily._dependencies,
          allTransitiveDependencies:
              UploadAvatarFamily._allTransitiveDependencies,
          fileName: fileName,
          fileType: fileType,
          userId: userId,
          userType: userType,
        );

  UploadAvatarProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fileName,
    required this.fileType,
    required this.userId,
    required this.userType,
  }) : super.internal();

  final String? fileName;
  final String? fileType;
  final String? userId;
  final String? userType;

  @override
  Override overrideWith(
    FutureOr<AvatarModel> Function(UploadAvatarRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UploadAvatarProvider._internal(
        (ref) => create(ref as UploadAvatarRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fileName: fileName,
        fileType: fileType,
        userId: userId,
        userType: userType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AvatarModel> createElement() {
    return _UploadAvatarProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UploadAvatarProvider &&
        other.fileName == fileName &&
        other.fileType == fileType &&
        other.userId == userId &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fileName.hashCode);
    hash = _SystemHash.combine(hash, fileType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, userType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UploadAvatarRef on AutoDisposeFutureProviderRef<AvatarModel> {
  /// The parameter `fileName` of this provider.
  String? get fileName;

  /// The parameter `fileType` of this provider.
  String? get fileType;

  /// The parameter `userId` of this provider.
  String? get userId;

  /// The parameter `userType` of this provider.
  String? get userType;
}

class _UploadAvatarProviderElement
    extends AutoDisposeFutureProviderElement<AvatarModel> with UploadAvatarRef {
  _UploadAvatarProviderElement(super.provider);

  @override
  String? get fileName => (origin as UploadAvatarProvider).fileName;
  @override
  String? get fileType => (origin as UploadAvatarProvider).fileType;
  @override
  String? get userId => (origin as UploadAvatarProvider).userId;
  @override
  String? get userType => (origin as UploadAvatarProvider).userType;
}

String _$uploadBannerHash() => r'f0b453082b79d8f4bdb087e47c7cc698c77c6166';

/// See also [uploadBanner].
@ProviderFor(uploadBanner)
const uploadBannerProvider = UploadBannerFamily();

/// See also [uploadBanner].
class UploadBannerFamily extends Family<AsyncValue<BannerModel>> {
  /// See also [uploadBanner].
  const UploadBannerFamily();

  /// See also [uploadBanner].
  UploadBannerProvider call({
    required String? fileName,
    required String? fileType,
    required String? userId,
    required String? userType,
  }) {
    return UploadBannerProvider(
      fileName: fileName,
      fileType: fileType,
      userId: userId,
      userType: userType,
    );
  }

  @override
  UploadBannerProvider getProviderOverride(
    covariant UploadBannerProvider provider,
  ) {
    return call(
      fileName: provider.fileName,
      fileType: provider.fileType,
      userId: provider.userId,
      userType: provider.userType,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'uploadBannerProvider';
}

/// See also [uploadBanner].
class UploadBannerProvider extends AutoDisposeFutureProvider<BannerModel> {
  /// See also [uploadBanner].
  UploadBannerProvider({
    required String? fileName,
    required String? fileType,
    required String? userId,
    required String? userType,
  }) : this._internal(
          (ref) => uploadBanner(
            ref as UploadBannerRef,
            fileName: fileName,
            fileType: fileType,
            userId: userId,
            userType: userType,
          ),
          from: uploadBannerProvider,
          name: r'uploadBannerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$uploadBannerHash,
          dependencies: UploadBannerFamily._dependencies,
          allTransitiveDependencies:
              UploadBannerFamily._allTransitiveDependencies,
          fileName: fileName,
          fileType: fileType,
          userId: userId,
          userType: userType,
        );

  UploadBannerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fileName,
    required this.fileType,
    required this.userId,
    required this.userType,
  }) : super.internal();

  final String? fileName;
  final String? fileType;
  final String? userId;
  final String? userType;

  @override
  Override overrideWith(
    FutureOr<BannerModel> Function(UploadBannerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UploadBannerProvider._internal(
        (ref) => create(ref as UploadBannerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fileName: fileName,
        fileType: fileType,
        userId: userId,
        userType: userType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BannerModel> createElement() {
    return _UploadBannerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UploadBannerProvider &&
        other.fileName == fileName &&
        other.fileType == fileType &&
        other.userId == userId &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fileName.hashCode);
    hash = _SystemHash.combine(hash, fileType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, userType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UploadBannerRef on AutoDisposeFutureProviderRef<BannerModel> {
  /// The parameter `fileName` of this provider.
  String? get fileName;

  /// The parameter `fileType` of this provider.
  String? get fileType;

  /// The parameter `userId` of this provider.
  String? get userId;

  /// The parameter `userType` of this provider.
  String? get userType;
}

class _UploadBannerProviderElement
    extends AutoDisposeFutureProviderElement<BannerModel> with UploadBannerRef {
  _UploadBannerProviderElement(super.provider);

  @override
  String? get fileName => (origin as UploadBannerProvider).fileName;
  @override
  String? get fileType => (origin as UploadBannerProvider).fileType;
  @override
  String? get userId => (origin as UploadBannerProvider).userId;
  @override
  String? get userType => (origin as UploadBannerProvider).userType;
}

String _$uploadToAWSHash() => r'f0aa5e84388cc4e962bdcde68cf0cf19e853dd61';

/// See also [uploadToAWS].
@ProviderFor(uploadToAWS)
const uploadToAWSProvider = UploadToAWSFamily();

/// See also [uploadToAWS].
class UploadToAWSFamily extends Family<AsyncValue<bool>> {
  /// See also [uploadToAWS].
  const UploadToAWSFamily();

  /// See also [uploadToAWS].
  UploadToAWSProvider call({
    required String? url,
    required String? fileName,
    required File file,
    required String? fileType,
  }) {
    return UploadToAWSProvider(
      url: url,
      fileName: fileName,
      file: file,
      fileType: fileType,
    );
  }

  @override
  UploadToAWSProvider getProviderOverride(
    covariant UploadToAWSProvider provider,
  ) {
    return call(
      url: provider.url,
      fileName: provider.fileName,
      file: provider.file,
      fileType: provider.fileType,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'uploadToAWSProvider';
}

/// See also [uploadToAWS].
class UploadToAWSProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [uploadToAWS].
  UploadToAWSProvider({
    required String? url,
    required String? fileName,
    required File file,
    required String? fileType,
  }) : this._internal(
          (ref) => uploadToAWS(
            ref as UploadToAWSRef,
            url: url,
            fileName: fileName,
            file: file,
            fileType: fileType,
          ),
          from: uploadToAWSProvider,
          name: r'uploadToAWSProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$uploadToAWSHash,
          dependencies: UploadToAWSFamily._dependencies,
          allTransitiveDependencies:
              UploadToAWSFamily._allTransitiveDependencies,
          url: url,
          fileName: fileName,
          file: file,
          fileType: fileType,
        );

  UploadToAWSProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
    required this.fileName,
    required this.file,
    required this.fileType,
  }) : super.internal();

  final String? url;
  final String? fileName;
  final File file;
  final String? fileType;

  @override
  Override overrideWith(
    FutureOr<bool> Function(UploadToAWSRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UploadToAWSProvider._internal(
        (ref) => create(ref as UploadToAWSRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
        fileName: fileName,
        file: file,
        fileType: fileType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _UploadToAWSProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UploadToAWSProvider &&
        other.url == url &&
        other.fileName == fileName &&
        other.file == file &&
        other.fileType == fileType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);
    hash = _SystemHash.combine(hash, fileName.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);
    hash = _SystemHash.combine(hash, fileType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UploadToAWSRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `url` of this provider.
  String? get url;

  /// The parameter `fileName` of this provider.
  String? get fileName;

  /// The parameter `file` of this provider.
  File get file;

  /// The parameter `fileType` of this provider.
  String? get fileType;
}

class _UploadToAWSProviderElement extends AutoDisposeFutureProviderElement<bool>
    with UploadToAWSRef {
  _UploadToAWSProviderElement(super.provider);

  @override
  String? get url => (origin as UploadToAWSProvider).url;
  @override
  String? get fileName => (origin as UploadToAWSProvider).fileName;
  @override
  File get file => (origin as UploadToAWSProvider).file;
  @override
  String? get fileType => (origin as UploadToAWSProvider).fileType;
}

String _$getImageHash() => r'71708f180c20f69eacab5b4dae2b6a4f1927e391';

/// See also [getImage].
@ProviderFor(getImage)
const getImageProvider = GetImageFamily();

/// See also [getImage].
class GetImageFamily extends Family<AsyncValue<ImageModel>> {
  /// See also [getImage].
  const GetImageFamily();

  /// See also [getImage].
  GetImageProvider call({
    required String src,
  }) {
    return GetImageProvider(
      src: src,
    );
  }

  @override
  GetImageProvider getProviderOverride(
    covariant GetImageProvider provider,
  ) {
    return call(
      src: provider.src,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getImageProvider';
}

/// See also [getImage].
class GetImageProvider extends AutoDisposeFutureProvider<ImageModel> {
  /// See also [getImage].
  GetImageProvider({
    required String src,
  }) : this._internal(
          (ref) => getImage(
            ref as GetImageRef,
            src: src,
          ),
          from: getImageProvider,
          name: r'getImageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getImageHash,
          dependencies: GetImageFamily._dependencies,
          allTransitiveDependencies: GetImageFamily._allTransitiveDependencies,
          src: src,
        );

  GetImageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.src,
  }) : super.internal();

  final String src;

  @override
  Override overrideWith(
    FutureOr<ImageModel> Function(GetImageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetImageProvider._internal(
        (ref) => create(ref as GetImageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        src: src,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ImageModel> createElement() {
    return _GetImageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetImageProvider && other.src == src;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, src.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetImageRef on AutoDisposeFutureProviderRef<ImageModel> {
  /// The parameter `src` of this provider.
  String get src;
}

class _GetImageProviderElement
    extends AutoDisposeFutureProviderElement<ImageModel> with GetImageRef {
  _GetImageProviderElement(super.provider);

  @override
  String get src => (origin as GetImageProvider).src;
}

String _$deleteAccountHash() => r'686436cb51114e3fb11234664c2f8d28f8472dac';

/// See also [deleteAccount].
@ProviderFor(deleteAccount)
const deleteAccountProvider = DeleteAccountFamily();

/// See also [deleteAccount].
class DeleteAccountFamily extends Family<AsyncValue<bool>> {
  /// See also [deleteAccount].
  const DeleteAccountFamily();

  /// See also [deleteAccount].
  DeleteAccountProvider call({
    required String userId,
  }) {
    return DeleteAccountProvider(
      userId: userId,
    );
  }

  @override
  DeleteAccountProvider getProviderOverride(
    covariant DeleteAccountProvider provider,
  ) {
    return call(
      userId: provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteAccountProvider';
}

/// See also [deleteAccount].
class DeleteAccountProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deleteAccount].
  DeleteAccountProvider({
    required String userId,
  }) : this._internal(
          (ref) => deleteAccount(
            ref as DeleteAccountRef,
            userId: userId,
          ),
          from: deleteAccountProvider,
          name: r'deleteAccountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteAccountHash,
          dependencies: DeleteAccountFamily._dependencies,
          allTransitiveDependencies:
              DeleteAccountFamily._allTransitiveDependencies,
          userId: userId,
        );

  DeleteAccountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeleteAccountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteAccountProvider._internal(
        (ref) => create(ref as DeleteAccountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeleteAccountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteAccountProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteAccountRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _DeleteAccountProviderElement
    extends AutoDisposeFutureProviderElement<bool> with DeleteAccountRef {
  _DeleteAccountProviderElement(super.provider);

  @override
  String get userId => (origin as DeleteAccountProvider).userId;
}

String _$checkUserNameHash() => r'a6bfccc0e06311ef2f6e390f8ebbf0500e8043ba';

/// See also [checkUserName].
@ProviderFor(checkUserName)
const checkUserNameProvider = CheckUserNameFamily();

/// See also [checkUserName].
class CheckUserNameFamily extends Family<AsyncValue<bool>> {
  /// See also [checkUserName].
  const CheckUserNameFamily();

  /// See also [checkUserName].
  CheckUserNameProvider call({
    required String userName,
  }) {
    return CheckUserNameProvider(
      userName: userName,
    );
  }

  @override
  CheckUserNameProvider getProviderOverride(
    covariant CheckUserNameProvider provider,
  ) {
    return call(
      userName: provider.userName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'checkUserNameProvider';
}

/// See also [checkUserName].
class CheckUserNameProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [checkUserName].
  CheckUserNameProvider({
    required String userName,
  }) : this._internal(
          (ref) => checkUserName(
            ref as CheckUserNameRef,
            userName: userName,
          ),
          from: checkUserNameProvider,
          name: r'checkUserNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkUserNameHash,
          dependencies: CheckUserNameFamily._dependencies,
          allTransitiveDependencies:
              CheckUserNameFamily._allTransitiveDependencies,
          userName: userName,
        );

  CheckUserNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userName,
  }) : super.internal();

  final String userName;

  @override
  Override overrideWith(
    FutureOr<bool> Function(CheckUserNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckUserNameProvider._internal(
        (ref) => create(ref as CheckUserNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userName: userName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _CheckUserNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckUserNameProvider && other.userName == userName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CheckUserNameRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userName` of this provider.
  String get userName;
}

class _CheckUserNameProviderElement
    extends AutoDisposeFutureProviderElement<bool> with CheckUserNameRef {
  _CheckUserNameProviderElement(super.provider);

  @override
  String get userName => (origin as CheckUserNameProvider).userName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
