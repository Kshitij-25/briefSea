// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breifs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$briefsRemoteDataSourceHash() =>
    r'522b2e66bff460bd25e0adbd7d24237bf2ab88b1';

/// See also [briefsRemoteDataSource].
@ProviderFor(briefsRemoteDataSource)
final briefsRemoteDataSourceProvider =
    AutoDisposeProvider<BriefsRemoteDataSource>.internal(
  briefsRemoteDataSource,
  name: r'briefsRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$briefsRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BriefsRemoteDataSourceRef
    = AutoDisposeProviderRef<BriefsRemoteDataSource>;
String _$briefsRepositoryHash() => r'9be591ace2729f4ae8c50fe13449150868e6788b';

/// See also [briefsRepository].
@ProviderFor(briefsRepository)
final briefsRepositoryProvider = AutoDisposeProvider<BreifsRepository>.internal(
  briefsRepository,
  name: r'briefsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$briefsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BriefsRepositoryRef = AutoDisposeProviderRef<BreifsRepository>;
String _$getAllBriefsHash() => r'2267c95441f21faf5485b678176cccb32e9eb745';

/// See also [getAllBriefs].
@ProviderFor(getAllBriefs)
final getAllBriefsProvider =
    AutoDisposeFutureProvider<List<BriefsModel?>?>.internal(
  getAllBriefs,
  name: r'getAllBriefsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllBriefsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllBriefsRef = AutoDisposeFutureProviderRef<List<BriefsModel?>?>;
String _$getUserBriefsHash() => r'b421872a57d5c5a9b07c11ad54f881efddafd2ed';

/// See also [getUserBriefs].
@ProviderFor(getUserBriefs)
final getUserBriefsProvider =
    AutoDisposeFutureProvider<List<BriefsModel?>?>.internal(
  getUserBriefs,
  name: r'getUserBriefsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUserBriefsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetUserBriefsRef = AutoDisposeFutureProviderRef<List<BriefsModel?>?>;
String _$postBriefHash() => r'1f8b510541164c810b40cfbb61583a36be67c74e';

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

/// See also [postBrief].
@ProviderFor(postBrief)
const postBriefProvider = PostBriefFamily();

/// See also [postBrief].
class PostBriefFamily extends Family<AsyncValue<bool>> {
  /// See also [postBrief].
  const PostBriefFamily();

  /// See also [postBrief].
  PostBriefProvider call({
    dynamic userId,
    dynamic uName,
    dynamic type,
    dynamic category,
    dynamic postText,
    dynamic imgSrc,
  }) {
    return PostBriefProvider(
      userId: userId,
      uName: uName,
      type: type,
      category: category,
      postText: postText,
      imgSrc: imgSrc,
    );
  }

  @override
  PostBriefProvider getProviderOverride(
    covariant PostBriefProvider provider,
  ) {
    return call(
      userId: provider.userId,
      uName: provider.uName,
      type: provider.type,
      category: provider.category,
      postText: provider.postText,
      imgSrc: provider.imgSrc,
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
  String? get name => r'postBriefProvider';
}

/// See also [postBrief].
class PostBriefProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [postBrief].
  PostBriefProvider({
    dynamic userId,
    dynamic uName,
    dynamic type,
    dynamic category,
    dynamic postText,
    dynamic imgSrc,
  }) : this._internal(
          (ref) => postBrief(
            ref as PostBriefRef,
            userId: userId,
            uName: uName,
            type: type,
            category: category,
            postText: postText,
            imgSrc: imgSrc,
          ),
          from: postBriefProvider,
          name: r'postBriefProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postBriefHash,
          dependencies: PostBriefFamily._dependencies,
          allTransitiveDependencies: PostBriefFamily._allTransitiveDependencies,
          userId: userId,
          uName: uName,
          type: type,
          category: category,
          postText: postText,
          imgSrc: imgSrc,
        );

  PostBriefProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.uName,
    required this.type,
    required this.category,
    required this.postText,
    required this.imgSrc,
  }) : super.internal();

  final dynamic userId;
  final dynamic uName;
  final dynamic type;
  final dynamic category;
  final dynamic postText;
  final dynamic imgSrc;

  @override
  Override overrideWith(
    FutureOr<bool> Function(PostBriefRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostBriefProvider._internal(
        (ref) => create(ref as PostBriefRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        uName: uName,
        type: type,
        category: category,
        postText: postText,
        imgSrc: imgSrc,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _PostBriefProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostBriefProvider &&
        other.userId == userId &&
        other.uName == uName &&
        other.type == type &&
        other.category == category &&
        other.postText == postText &&
        other.imgSrc == imgSrc;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, uName.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);
    hash = _SystemHash.combine(hash, postText.hashCode);
    hash = _SystemHash.combine(hash, imgSrc.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostBriefRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userId` of this provider.
  dynamic get userId;

  /// The parameter `uName` of this provider.
  dynamic get uName;

  /// The parameter `type` of this provider.
  dynamic get type;

  /// The parameter `category` of this provider.
  dynamic get category;

  /// The parameter `postText` of this provider.
  dynamic get postText;

  /// The parameter `imgSrc` of this provider.
  dynamic get imgSrc;
}

class _PostBriefProviderElement extends AutoDisposeFutureProviderElement<bool>
    with PostBriefRef {
  _PostBriefProviderElement(super.provider);

  @override
  dynamic get userId => (origin as PostBriefProvider).userId;
  @override
  dynamic get uName => (origin as PostBriefProvider).uName;
  @override
  dynamic get type => (origin as PostBriefProvider).type;
  @override
  dynamic get category => (origin as PostBriefProvider).category;
  @override
  dynamic get postText => (origin as PostBriefProvider).postText;
  @override
  dynamic get imgSrc => (origin as PostBriefProvider).imgSrc;
}

String _$uploadThreadImageHash() => r'e93d537f39cf32f3017d5538ad054e11bcf83302';

/// See also [uploadThreadImage].
@ProviderFor(uploadThreadImage)
const uploadThreadImageProvider = UploadThreadImageFamily();

/// See also [uploadThreadImage].
class UploadThreadImageFamily extends Family<AsyncValue<ThreadImageModel>> {
  /// See also [uploadThreadImage].
  const UploadThreadImageFamily();

  /// See also [uploadThreadImage].
  UploadThreadImageProvider call({
    required dynamic fileName,
    required dynamic fileType,
    required dynamic userId,
    required dynamic userType,
  }) {
    return UploadThreadImageProvider(
      fileName: fileName,
      fileType: fileType,
      userId: userId,
      userType: userType,
    );
  }

  @override
  UploadThreadImageProvider getProviderOverride(
    covariant UploadThreadImageProvider provider,
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
  String? get name => r'uploadThreadImageProvider';
}

/// See also [uploadThreadImage].
class UploadThreadImageProvider
    extends AutoDisposeFutureProvider<ThreadImageModel> {
  /// See also [uploadThreadImage].
  UploadThreadImageProvider({
    required dynamic fileName,
    required dynamic fileType,
    required dynamic userId,
    required dynamic userType,
  }) : this._internal(
          (ref) => uploadThreadImage(
            ref as UploadThreadImageRef,
            fileName: fileName,
            fileType: fileType,
            userId: userId,
            userType: userType,
          ),
          from: uploadThreadImageProvider,
          name: r'uploadThreadImageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$uploadThreadImageHash,
          dependencies: UploadThreadImageFamily._dependencies,
          allTransitiveDependencies:
              UploadThreadImageFamily._allTransitiveDependencies,
          fileName: fileName,
          fileType: fileType,
          userId: userId,
          userType: userType,
        );

  UploadThreadImageProvider._internal(
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

  final dynamic fileName;
  final dynamic fileType;
  final dynamic userId;
  final dynamic userType;

  @override
  Override overrideWith(
    FutureOr<ThreadImageModel> Function(UploadThreadImageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UploadThreadImageProvider._internal(
        (ref) => create(ref as UploadThreadImageRef),
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
  AutoDisposeFutureProviderElement<ThreadImageModel> createElement() {
    return _UploadThreadImageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UploadThreadImageProvider &&
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

mixin UploadThreadImageRef on AutoDisposeFutureProviderRef<ThreadImageModel> {
  /// The parameter `fileName` of this provider.
  dynamic get fileName;

  /// The parameter `fileType` of this provider.
  dynamic get fileType;

  /// The parameter `userId` of this provider.
  dynamic get userId;

  /// The parameter `userType` of this provider.
  dynamic get userType;
}

class _UploadThreadImageProviderElement
    extends AutoDisposeFutureProviderElement<ThreadImageModel>
    with UploadThreadImageRef {
  _UploadThreadImageProviderElement(super.provider);

  @override
  dynamic get fileName => (origin as UploadThreadImageProvider).fileName;
  @override
  dynamic get fileType => (origin as UploadThreadImageProvider).fileType;
  @override
  dynamic get userId => (origin as UploadThreadImageProvider).userId;
  @override
  dynamic get userType => (origin as UploadThreadImageProvider).userType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
