// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$likeRemoteDataSourceHash() =>
    r'33329036db7294c8e41475101f73da861e44c425';

/// See also [likeRemoteDataSource].
@ProviderFor(likeRemoteDataSource)
final likeRemoteDataSourceProvider =
    AutoDisposeProvider<LikeRemoteDataSource>.internal(
  likeRemoteDataSource,
  name: r'likeRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$likeRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LikeRemoteDataSourceRef = AutoDisposeProviderRef<LikeRemoteDataSource>;
String _$likeRepositoryHash() => r'2c821659147ea74133546fb9c2f2424e7de708d9';

/// See also [likeRepository].
@ProviderFor(likeRepository)
final likeRepositoryProvider = AutoDisposeProvider<LikeRepository>.internal(
  likeRepository,
  name: r'likeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$likeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LikeRepositoryRef = AutoDisposeProviderRef<LikeRepository>;
String _$postLikeHash() => r'c960e43d2789899b9d1792afd619ca36a93e384d';

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

/// See also [postLike].
@ProviderFor(postLike)
const postLikeProvider = PostLikeFamily();

/// See also [postLike].
class PostLikeFamily extends Family<AsyncValue<bool>> {
  /// See also [postLike].
  const PostLikeFamily();

  /// See also [postLike].
  PostLikeProvider call({
    required String? userId,
    required String? uName,
    String? replyId,
    required dynamic threadId,
    required dynamic type,
  }) {
    return PostLikeProvider(
      userId: userId,
      uName: uName,
      replyId: replyId,
      threadId: threadId,
      type: type,
    );
  }

  @override
  PostLikeProvider getProviderOverride(
    covariant PostLikeProvider provider,
  ) {
    return call(
      userId: provider.userId,
      uName: provider.uName,
      replyId: provider.replyId,
      threadId: provider.threadId,
      type: provider.type,
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
  String? get name => r'postLikeProvider';
}

/// See also [postLike].
class PostLikeProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [postLike].
  PostLikeProvider({
    required String? userId,
    required String? uName,
    String? replyId,
    required dynamic threadId,
    required dynamic type,
  }) : this._internal(
          (ref) => postLike(
            ref as PostLikeRef,
            userId: userId,
            uName: uName,
            replyId: replyId,
            threadId: threadId,
            type: type,
          ),
          from: postLikeProvider,
          name: r'postLikeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postLikeHash,
          dependencies: PostLikeFamily._dependencies,
          allTransitiveDependencies: PostLikeFamily._allTransitiveDependencies,
          userId: userId,
          uName: uName,
          replyId: replyId,
          threadId: threadId,
          type: type,
        );

  PostLikeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.uName,
    required this.replyId,
    required this.threadId,
    required this.type,
  }) : super.internal();

  final String? userId;
  final String? uName;
  final String? replyId;
  final dynamic threadId;
  final dynamic type;

  @override
  Override overrideWith(
    FutureOr<bool> Function(PostLikeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostLikeProvider._internal(
        (ref) => create(ref as PostLikeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        uName: uName,
        replyId: replyId,
        threadId: threadId,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _PostLikeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostLikeProvider &&
        other.userId == userId &&
        other.uName == uName &&
        other.replyId == replyId &&
        other.threadId == threadId &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, uName.hashCode);
    hash = _SystemHash.combine(hash, replyId.hashCode);
    hash = _SystemHash.combine(hash, threadId.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostLikeRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userId` of this provider.
  String? get userId;

  /// The parameter `uName` of this provider.
  String? get uName;

  /// The parameter `replyId` of this provider.
  String? get replyId;

  /// The parameter `threadId` of this provider.
  dynamic get threadId;

  /// The parameter `type` of this provider.
  dynamic get type;
}

class _PostLikeProviderElement extends AutoDisposeFutureProviderElement<bool>
    with PostLikeRef {
  _PostLikeProviderElement(super.provider);

  @override
  String? get userId => (origin as PostLikeProvider).userId;
  @override
  String? get uName => (origin as PostLikeProvider).uName;
  @override
  String? get replyId => (origin as PostLikeProvider).replyId;
  @override
  dynamic get threadId => (origin as PostLikeProvider).threadId;
  @override
  dynamic get type => (origin as PostLikeProvider).type;
}

String _$getALikeHash() => r'6899fd586019c7ff99a8e76d4a416ad9b4413cc3';

/// See also [getALike].
@ProviderFor(getALike)
const getALikeProvider = GetALikeFamily();

/// See also [getALike].
class GetALikeFamily extends Family<AsyncValue<LikeModel>> {
  /// See also [getALike].
  const GetALikeFamily();

  /// See also [getALike].
  GetALikeProvider call({
    dynamic threadId,
  }) {
    return GetALikeProvider(
      threadId: threadId,
    );
  }

  @override
  GetALikeProvider getProviderOverride(
    covariant GetALikeProvider provider,
  ) {
    return call(
      threadId: provider.threadId,
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
  String? get name => r'getALikeProvider';
}

/// See also [getALike].
class GetALikeProvider extends AutoDisposeFutureProvider<LikeModel> {
  /// See also [getALike].
  GetALikeProvider({
    dynamic threadId,
  }) : this._internal(
          (ref) => getALike(
            ref as GetALikeRef,
            threadId: threadId,
          ),
          from: getALikeProvider,
          name: r'getALikeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getALikeHash,
          dependencies: GetALikeFamily._dependencies,
          allTransitiveDependencies: GetALikeFamily._allTransitiveDependencies,
          threadId: threadId,
        );

  GetALikeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.threadId,
  }) : super.internal();

  final dynamic threadId;

  @override
  Override overrideWith(
    FutureOr<LikeModel> Function(GetALikeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetALikeProvider._internal(
        (ref) => create(ref as GetALikeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        threadId: threadId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LikeModel> createElement() {
    return _GetALikeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetALikeProvider && other.threadId == threadId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, threadId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetALikeRef on AutoDisposeFutureProviderRef<LikeModel> {
  /// The parameter `threadId` of this provider.
  dynamic get threadId;
}

class _GetALikeProviderElement
    extends AutoDisposeFutureProviderElement<LikeModel> with GetALikeRef {
  _GetALikeProviderElement(super.provider);

  @override
  dynamic get threadId => (origin as GetALikeProvider).threadId;
}

String _$deleteLikeHash() => r'2a646e42903c9353609689dc0050baf5e99b3388';

/// See also [deleteLike].
@ProviderFor(deleteLike)
const deleteLikeProvider = DeleteLikeFamily();

/// See also [deleteLike].
class DeleteLikeFamily extends Family<AsyncValue<bool>> {
  /// See also [deleteLike].
  const DeleteLikeFamily();

  /// See also [deleteLike].
  DeleteLikeProvider call({
    required dynamic userId,
    required dynamic uName,
    required dynamic type,
    dynamic threadId,
    dynamic replyId,
    required dynamic likeId,
  }) {
    return DeleteLikeProvider(
      userId: userId,
      uName: uName,
      type: type,
      threadId: threadId,
      replyId: replyId,
      likeId: likeId,
    );
  }

  @override
  DeleteLikeProvider getProviderOverride(
    covariant DeleteLikeProvider provider,
  ) {
    return call(
      userId: provider.userId,
      uName: provider.uName,
      type: provider.type,
      threadId: provider.threadId,
      replyId: provider.replyId,
      likeId: provider.likeId,
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
  String? get name => r'deleteLikeProvider';
}

/// See also [deleteLike].
class DeleteLikeProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deleteLike].
  DeleteLikeProvider({
    required dynamic userId,
    required dynamic uName,
    required dynamic type,
    dynamic threadId,
    dynamic replyId,
    required dynamic likeId,
  }) : this._internal(
          (ref) => deleteLike(
            ref as DeleteLikeRef,
            userId: userId,
            uName: uName,
            type: type,
            threadId: threadId,
            replyId: replyId,
            likeId: likeId,
          ),
          from: deleteLikeProvider,
          name: r'deleteLikeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteLikeHash,
          dependencies: DeleteLikeFamily._dependencies,
          allTransitiveDependencies:
              DeleteLikeFamily._allTransitiveDependencies,
          userId: userId,
          uName: uName,
          type: type,
          threadId: threadId,
          replyId: replyId,
          likeId: likeId,
        );

  DeleteLikeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.uName,
    required this.type,
    required this.threadId,
    required this.replyId,
    required this.likeId,
  }) : super.internal();

  final dynamic userId;
  final dynamic uName;
  final dynamic type;
  final dynamic threadId;
  final dynamic replyId;
  final dynamic likeId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeleteLikeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteLikeProvider._internal(
        (ref) => create(ref as DeleteLikeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        uName: uName,
        type: type,
        threadId: threadId,
        replyId: replyId,
        likeId: likeId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeleteLikeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteLikeProvider &&
        other.userId == userId &&
        other.uName == uName &&
        other.type == type &&
        other.threadId == threadId &&
        other.replyId == replyId &&
        other.likeId == likeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, uName.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, threadId.hashCode);
    hash = _SystemHash.combine(hash, replyId.hashCode);
    hash = _SystemHash.combine(hash, likeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteLikeRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userId` of this provider.
  dynamic get userId;

  /// The parameter `uName` of this provider.
  dynamic get uName;

  /// The parameter `type` of this provider.
  dynamic get type;

  /// The parameter `threadId` of this provider.
  dynamic get threadId;

  /// The parameter `replyId` of this provider.
  dynamic get replyId;

  /// The parameter `likeId` of this provider.
  dynamic get likeId;
}

class _DeleteLikeProviderElement extends AutoDisposeFutureProviderElement<bool>
    with DeleteLikeRef {
  _DeleteLikeProviderElement(super.provider);

  @override
  dynamic get userId => (origin as DeleteLikeProvider).userId;
  @override
  dynamic get uName => (origin as DeleteLikeProvider).uName;
  @override
  dynamic get type => (origin as DeleteLikeProvider).type;
  @override
  dynamic get threadId => (origin as DeleteLikeProvider).threadId;
  @override
  dynamic get replyId => (origin as DeleteLikeProvider).replyId;
  @override
  dynamic get likeId => (origin as DeleteLikeProvider).likeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
