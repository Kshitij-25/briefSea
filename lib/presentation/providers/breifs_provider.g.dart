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
String _$getAllBriefsHash() => r'411c7c2d162276311763c6ac610de9059e5e6803';

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
String _$getUserBriefsHash() => r'5d61eeb20f9d7a19c511707cbe984acab9fd17a8';

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
String _$getSingleBriefHash() => r'3f38e059b31d89a5e79152ac8b692cd76ee03fc0';

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

/// See also [getSingleBrief].
@ProviderFor(getSingleBrief)
const getSingleBriefProvider = GetSingleBriefFamily();

/// See also [getSingleBrief].
class GetSingleBriefFamily extends Family<AsyncValue<BriefsModel?>> {
  /// See also [getSingleBrief].
  const GetSingleBriefFamily();

  /// See also [getSingleBrief].
  GetSingleBriefProvider call({
    required String? briefId,
  }) {
    return GetSingleBriefProvider(
      briefId: briefId,
    );
  }

  @override
  GetSingleBriefProvider getProviderOverride(
    covariant GetSingleBriefProvider provider,
  ) {
    return call(
      briefId: provider.briefId,
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
  String? get name => r'getSingleBriefProvider';
}

/// See also [getSingleBrief].
class GetSingleBriefProvider extends AutoDisposeFutureProvider<BriefsModel?> {
  /// See also [getSingleBrief].
  GetSingleBriefProvider({
    required String? briefId,
  }) : this._internal(
          (ref) => getSingleBrief(
            ref as GetSingleBriefRef,
            briefId: briefId,
          ),
          from: getSingleBriefProvider,
          name: r'getSingleBriefProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSingleBriefHash,
          dependencies: GetSingleBriefFamily._dependencies,
          allTransitiveDependencies:
              GetSingleBriefFamily._allTransitiveDependencies,
          briefId: briefId,
        );

  GetSingleBriefProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.briefId,
  }) : super.internal();

  final String? briefId;

  @override
  Override overrideWith(
    FutureOr<BriefsModel?> Function(GetSingleBriefRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSingleBriefProvider._internal(
        (ref) => create(ref as GetSingleBriefRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        briefId: briefId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BriefsModel?> createElement() {
    return _GetSingleBriefProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSingleBriefProvider && other.briefId == briefId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, briefId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSingleBriefRef on AutoDisposeFutureProviderRef<BriefsModel?> {
  /// The parameter `briefId` of this provider.
  String? get briefId;
}

class _GetSingleBriefProviderElement
    extends AutoDisposeFutureProviderElement<BriefsModel?>
    with GetSingleBriefRef {
  _GetSingleBriefProviderElement(super.provider);

  @override
  String? get briefId => (origin as GetSingleBriefProvider).briefId;
}

String _$postBriefHash() => r'6e59c734154a807cf7820703d8efdc1fb879c87d';

/// See also [postBrief].
@ProviderFor(postBrief)
const postBriefProvider = PostBriefFamily();

/// See also [postBrief].
class PostBriefFamily extends Family<AsyncValue<bool>> {
  /// See also [postBrief].
  const PostBriefFamily();

  /// See also [postBrief].
  PostBriefProvider call({
    required String? userId,
    required String? uName,
    required String? type,
    required String? category,
    required String? postText,
    String? imgSrc,
    required List<String>? isVisibleTo,
  }) {
    return PostBriefProvider(
      userId: userId,
      uName: uName,
      type: type,
      category: category,
      postText: postText,
      imgSrc: imgSrc,
      isVisibleTo: isVisibleTo,
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
      isVisibleTo: provider.isVisibleTo,
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
    required String? userId,
    required String? uName,
    required String? type,
    required String? category,
    required String? postText,
    String? imgSrc,
    required List<String>? isVisibleTo,
  }) : this._internal(
          (ref) => postBrief(
            ref as PostBriefRef,
            userId: userId,
            uName: uName,
            type: type,
            category: category,
            postText: postText,
            imgSrc: imgSrc,
            isVisibleTo: isVisibleTo,
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
          isVisibleTo: isVisibleTo,
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
    required this.isVisibleTo,
  }) : super.internal();

  final String? userId;
  final String? uName;
  final String? type;
  final String? category;
  final String? postText;
  final String? imgSrc;
  final List<String>? isVisibleTo;

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
        isVisibleTo: isVisibleTo,
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
        other.imgSrc == imgSrc &&
        other.isVisibleTo == isVisibleTo;
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
    hash = _SystemHash.combine(hash, isVisibleTo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostBriefRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userId` of this provider.
  String? get userId;

  /// The parameter `uName` of this provider.
  String? get uName;

  /// The parameter `type` of this provider.
  String? get type;

  /// The parameter `category` of this provider.
  String? get category;

  /// The parameter `postText` of this provider.
  String? get postText;

  /// The parameter `imgSrc` of this provider.
  String? get imgSrc;

  /// The parameter `isVisibleTo` of this provider.
  List<String>? get isVisibleTo;
}

class _PostBriefProviderElement extends AutoDisposeFutureProviderElement<bool>
    with PostBriefRef {
  _PostBriefProviderElement(super.provider);

  @override
  String? get userId => (origin as PostBriefProvider).userId;
  @override
  String? get uName => (origin as PostBriefProvider).uName;
  @override
  String? get type => (origin as PostBriefProvider).type;
  @override
  String? get category => (origin as PostBriefProvider).category;
  @override
  String? get postText => (origin as PostBriefProvider).postText;
  @override
  String? get imgSrc => (origin as PostBriefProvider).imgSrc;
  @override
  List<String>? get isVisibleTo => (origin as PostBriefProvider).isVisibleTo;
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

String _$deleteBriefHash() => r'6dcd800b987598b3893be19d76c8f0f49d28ce1e';

/// See also [deleteBrief].
@ProviderFor(deleteBrief)
const deleteBriefProvider = DeleteBriefFamily();

/// See also [deleteBrief].
class DeleteBriefFamily extends Family<AsyncValue<bool>> {
  /// See also [deleteBrief].
  const DeleteBriefFamily();

  /// See also [deleteBrief].
  DeleteBriefProvider call({
    required String? briefId,
  }) {
    return DeleteBriefProvider(
      briefId: briefId,
    );
  }

  @override
  DeleteBriefProvider getProviderOverride(
    covariant DeleteBriefProvider provider,
  ) {
    return call(
      briefId: provider.briefId,
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
  String? get name => r'deleteBriefProvider';
}

/// See also [deleteBrief].
class DeleteBriefProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deleteBrief].
  DeleteBriefProvider({
    required String? briefId,
  }) : this._internal(
          (ref) => deleteBrief(
            ref as DeleteBriefRef,
            briefId: briefId,
          ),
          from: deleteBriefProvider,
          name: r'deleteBriefProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteBriefHash,
          dependencies: DeleteBriefFamily._dependencies,
          allTransitiveDependencies:
              DeleteBriefFamily._allTransitiveDependencies,
          briefId: briefId,
        );

  DeleteBriefProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.briefId,
  }) : super.internal();

  final String? briefId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeleteBriefRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteBriefProvider._internal(
        (ref) => create(ref as DeleteBriefRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        briefId: briefId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeleteBriefProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteBriefProvider && other.briefId == briefId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, briefId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteBriefRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `briefId` of this provider.
  String? get briefId;
}

class _DeleteBriefProviderElement extends AutoDisposeFutureProviderElement<bool>
    with DeleteBriefRef {
  _DeleteBriefProviderElement(super.provider);

  @override
  String? get briefId => (origin as DeleteBriefProvider).briefId;
}

String _$editBriefHash() => r'67891b9790ea9287d4261dd2a3c724af3169c961';

/// See also [editBrief].
@ProviderFor(editBrief)
const editBriefProvider = EditBriefFamily();

/// See also [editBrief].
class EditBriefFamily extends Family<AsyncValue<bool>> {
  /// See also [editBrief].
  const EditBriefFamily();

  /// See also [editBrief].
  EditBriefProvider call({
    required String briefId,
    required bool isVisible,
    required String userId,
    required String uname,
    required String type,
    required String category,
    required String postText,
    required String imgSrc,
    required String avatarSrc,
    required String createdAt,
    required String updatedAt,
    required int likesCount,
    required int replyCount,
    required int postedAt,
    required List<String>? isVisibleTo,
  }) {
    return EditBriefProvider(
      briefId: briefId,
      isVisible: isVisible,
      userId: userId,
      uname: uname,
      type: type,
      category: category,
      postText: postText,
      imgSrc: imgSrc,
      avatarSrc: avatarSrc,
      createdAt: createdAt,
      updatedAt: updatedAt,
      likesCount: likesCount,
      replyCount: replyCount,
      postedAt: postedAt,
      isVisibleTo: isVisibleTo,
    );
  }

  @override
  EditBriefProvider getProviderOverride(
    covariant EditBriefProvider provider,
  ) {
    return call(
      briefId: provider.briefId,
      isVisible: provider.isVisible,
      userId: provider.userId,
      uname: provider.uname,
      type: provider.type,
      category: provider.category,
      postText: provider.postText,
      imgSrc: provider.imgSrc,
      avatarSrc: provider.avatarSrc,
      createdAt: provider.createdAt,
      updatedAt: provider.updatedAt,
      likesCount: provider.likesCount,
      replyCount: provider.replyCount,
      postedAt: provider.postedAt,
      isVisibleTo: provider.isVisibleTo,
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
  String? get name => r'editBriefProvider';
}

/// See also [editBrief].
class EditBriefProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [editBrief].
  EditBriefProvider({
    required String briefId,
    required bool isVisible,
    required String userId,
    required String uname,
    required String type,
    required String category,
    required String postText,
    required String imgSrc,
    required String avatarSrc,
    required String createdAt,
    required String updatedAt,
    required int likesCount,
    required int replyCount,
    required int postedAt,
    required List<String>? isVisibleTo,
  }) : this._internal(
          (ref) => editBrief(
            ref as EditBriefRef,
            briefId: briefId,
            isVisible: isVisible,
            userId: userId,
            uname: uname,
            type: type,
            category: category,
            postText: postText,
            imgSrc: imgSrc,
            avatarSrc: avatarSrc,
            createdAt: createdAt,
            updatedAt: updatedAt,
            likesCount: likesCount,
            replyCount: replyCount,
            postedAt: postedAt,
            isVisibleTo: isVisibleTo,
          ),
          from: editBriefProvider,
          name: r'editBriefProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editBriefHash,
          dependencies: EditBriefFamily._dependencies,
          allTransitiveDependencies: EditBriefFamily._allTransitiveDependencies,
          briefId: briefId,
          isVisible: isVisible,
          userId: userId,
          uname: uname,
          type: type,
          category: category,
          postText: postText,
          imgSrc: imgSrc,
          avatarSrc: avatarSrc,
          createdAt: createdAt,
          updatedAt: updatedAt,
          likesCount: likesCount,
          replyCount: replyCount,
          postedAt: postedAt,
          isVisibleTo: isVisibleTo,
        );

  EditBriefProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.briefId,
    required this.isVisible,
    required this.userId,
    required this.uname,
    required this.type,
    required this.category,
    required this.postText,
    required this.imgSrc,
    required this.avatarSrc,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.replyCount,
    required this.postedAt,
    required this.isVisibleTo,
  }) : super.internal();

  final String briefId;
  final bool isVisible;
  final String userId;
  final String uname;
  final String type;
  final String category;
  final String postText;
  final String imgSrc;
  final String avatarSrc;
  final String createdAt;
  final String updatedAt;
  final int likesCount;
  final int replyCount;
  final int postedAt;
  final List<String>? isVisibleTo;

  @override
  Override overrideWith(
    FutureOr<bool> Function(EditBriefRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditBriefProvider._internal(
        (ref) => create(ref as EditBriefRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        briefId: briefId,
        isVisible: isVisible,
        userId: userId,
        uname: uname,
        type: type,
        category: category,
        postText: postText,
        imgSrc: imgSrc,
        avatarSrc: avatarSrc,
        createdAt: createdAt,
        updatedAt: updatedAt,
        likesCount: likesCount,
        replyCount: replyCount,
        postedAt: postedAt,
        isVisibleTo: isVisibleTo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _EditBriefProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditBriefProvider &&
        other.briefId == briefId &&
        other.isVisible == isVisible &&
        other.userId == userId &&
        other.uname == uname &&
        other.type == type &&
        other.category == category &&
        other.postText == postText &&
        other.imgSrc == imgSrc &&
        other.avatarSrc == avatarSrc &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.likesCount == likesCount &&
        other.replyCount == replyCount &&
        other.postedAt == postedAt &&
        other.isVisibleTo == isVisibleTo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, briefId.hashCode);
    hash = _SystemHash.combine(hash, isVisible.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, uname.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);
    hash = _SystemHash.combine(hash, postText.hashCode);
    hash = _SystemHash.combine(hash, imgSrc.hashCode);
    hash = _SystemHash.combine(hash, avatarSrc.hashCode);
    hash = _SystemHash.combine(hash, createdAt.hashCode);
    hash = _SystemHash.combine(hash, updatedAt.hashCode);
    hash = _SystemHash.combine(hash, likesCount.hashCode);
    hash = _SystemHash.combine(hash, replyCount.hashCode);
    hash = _SystemHash.combine(hash, postedAt.hashCode);
    hash = _SystemHash.combine(hash, isVisibleTo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditBriefRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `briefId` of this provider.
  String get briefId;

  /// The parameter `isVisible` of this provider.
  bool get isVisible;

  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `uname` of this provider.
  String get uname;

  /// The parameter `type` of this provider.
  String get type;

  /// The parameter `category` of this provider.
  String get category;

  /// The parameter `postText` of this provider.
  String get postText;

  /// The parameter `imgSrc` of this provider.
  String get imgSrc;

  /// The parameter `avatarSrc` of this provider.
  String get avatarSrc;

  /// The parameter `createdAt` of this provider.
  String get createdAt;

  /// The parameter `updatedAt` of this provider.
  String get updatedAt;

  /// The parameter `likesCount` of this provider.
  int get likesCount;

  /// The parameter `replyCount` of this provider.
  int get replyCount;

  /// The parameter `postedAt` of this provider.
  int get postedAt;

  /// The parameter `isVisibleTo` of this provider.
  List<String>? get isVisibleTo;
}

class _EditBriefProviderElement extends AutoDisposeFutureProviderElement<bool>
    with EditBriefRef {
  _EditBriefProviderElement(super.provider);

  @override
  String get briefId => (origin as EditBriefProvider).briefId;
  @override
  bool get isVisible => (origin as EditBriefProvider).isVisible;
  @override
  String get userId => (origin as EditBriefProvider).userId;
  @override
  String get uname => (origin as EditBriefProvider).uname;
  @override
  String get type => (origin as EditBriefProvider).type;
  @override
  String get category => (origin as EditBriefProvider).category;
  @override
  String get postText => (origin as EditBriefProvider).postText;
  @override
  String get imgSrc => (origin as EditBriefProvider).imgSrc;
  @override
  String get avatarSrc => (origin as EditBriefProvider).avatarSrc;
  @override
  String get createdAt => (origin as EditBriefProvider).createdAt;
  @override
  String get updatedAt => (origin as EditBriefProvider).updatedAt;
  @override
  int get likesCount => (origin as EditBriefProvider).likesCount;
  @override
  int get replyCount => (origin as EditBriefProvider).replyCount;
  @override
  int get postedAt => (origin as EditBriefProvider).postedAt;
  @override
  List<String>? get isVisibleTo => (origin as EditBriefProvider).isVisibleTo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
