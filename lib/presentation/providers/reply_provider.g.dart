// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$replyRemoteDataSourceHash() =>
    r'7873b5a87e60e43a9ea969df469eded4572a184f';

/// See also [replyRemoteDataSource].
@ProviderFor(replyRemoteDataSource)
final replyRemoteDataSourceProvider =
    AutoDisposeProvider<ReplyRemoteDataSource>.internal(
  replyRemoteDataSource,
  name: r'replyRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$replyRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReplyRemoteDataSourceRef
    = AutoDisposeProviderRef<ReplyRemoteDataSource>;
String _$replyRepositoryHash() => r'd98902cbec2dfea98755f7f75373c8679ce2d06b';

/// See also [replyRepository].
@ProviderFor(replyRepository)
final replyRepositoryProvider = AutoDisposeProvider<ReplyRepository>.internal(
  replyRepository,
  name: r'replyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$replyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReplyRepositoryRef = AutoDisposeProviderRef<ReplyRepository>;
String _$postReplyHash() => r'78dab2f9184fb56f2bb7f05b358c5e10326f39b3';

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

/// See also [postReply].
@ProviderFor(postReply)
const postReplyProvider = PostReplyFamily();

/// See also [postReply].
class PostReplyFamily extends Family<AsyncValue<bool>> {
  /// See also [postReply].
  const PostReplyFamily();

  /// See also [postReply].
  PostReplyProvider call({
    required String? userId,
    required String? threadId,
    required String? commentText,
    String? replyId,
  }) {
    return PostReplyProvider(
      userId: userId,
      threadId: threadId,
      commentText: commentText,
      replyId: replyId,
    );
  }

  @override
  PostReplyProvider getProviderOverride(
    covariant PostReplyProvider provider,
  ) {
    return call(
      userId: provider.userId,
      threadId: provider.threadId,
      commentText: provider.commentText,
      replyId: provider.replyId,
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
  String? get name => r'postReplyProvider';
}

/// See also [postReply].
class PostReplyProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [postReply].
  PostReplyProvider({
    required String? userId,
    required String? threadId,
    required String? commentText,
    String? replyId,
  }) : this._internal(
          (ref) => postReply(
            ref as PostReplyRef,
            userId: userId,
            threadId: threadId,
            commentText: commentText,
            replyId: replyId,
          ),
          from: postReplyProvider,
          name: r'postReplyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postReplyHash,
          dependencies: PostReplyFamily._dependencies,
          allTransitiveDependencies: PostReplyFamily._allTransitiveDependencies,
          userId: userId,
          threadId: threadId,
          commentText: commentText,
          replyId: replyId,
        );

  PostReplyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.threadId,
    required this.commentText,
    required this.replyId,
  }) : super.internal();

  final String? userId;
  final String? threadId;
  final String? commentText;
  final String? replyId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(PostReplyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostReplyProvider._internal(
        (ref) => create(ref as PostReplyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        threadId: threadId,
        commentText: commentText,
        replyId: replyId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _PostReplyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostReplyProvider &&
        other.userId == userId &&
        other.threadId == threadId &&
        other.commentText == commentText &&
        other.replyId == replyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, threadId.hashCode);
    hash = _SystemHash.combine(hash, commentText.hashCode);
    hash = _SystemHash.combine(hash, replyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostReplyRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userId` of this provider.
  String? get userId;

  /// The parameter `threadId` of this provider.
  String? get threadId;

  /// The parameter `commentText` of this provider.
  String? get commentText;

  /// The parameter `replyId` of this provider.
  String? get replyId;
}

class _PostReplyProviderElement extends AutoDisposeFutureProviderElement<bool>
    with PostReplyRef {
  _PostReplyProviderElement(super.provider);

  @override
  String? get userId => (origin as PostReplyProvider).userId;
  @override
  String? get threadId => (origin as PostReplyProvider).threadId;
  @override
  String? get commentText => (origin as PostReplyProvider).commentText;
  @override
  String? get replyId => (origin as PostReplyProvider).replyId;
}

String _$getCommentLikeHash() => r'38d6880cfcd8e0b85338a1096db00505f5aa4e6f';

/// See also [getCommentLike].
@ProviderFor(getCommentLike)
const getCommentLikeProvider = GetCommentLikeFamily();

/// See also [getCommentLike].
class GetCommentLikeFamily extends Family<AsyncValue<LikeModel>> {
  /// See also [getCommentLike].
  const GetCommentLikeFamily();

  /// See also [getCommentLike].
  GetCommentLikeProvider call({
    required String? replyId,
  }) {
    return GetCommentLikeProvider(
      replyId: replyId,
    );
  }

  @override
  GetCommentLikeProvider getProviderOverride(
    covariant GetCommentLikeProvider provider,
  ) {
    return call(
      replyId: provider.replyId,
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
  String? get name => r'getCommentLikeProvider';
}

/// See also [getCommentLike].
class GetCommentLikeProvider extends AutoDisposeFutureProvider<LikeModel> {
  /// See also [getCommentLike].
  GetCommentLikeProvider({
    required String? replyId,
  }) : this._internal(
          (ref) => getCommentLike(
            ref as GetCommentLikeRef,
            replyId: replyId,
          ),
          from: getCommentLikeProvider,
          name: r'getCommentLikeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCommentLikeHash,
          dependencies: GetCommentLikeFamily._dependencies,
          allTransitiveDependencies:
              GetCommentLikeFamily._allTransitiveDependencies,
          replyId: replyId,
        );

  GetCommentLikeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.replyId,
  }) : super.internal();

  final String? replyId;

  @override
  Override overrideWith(
    FutureOr<LikeModel> Function(GetCommentLikeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCommentLikeProvider._internal(
        (ref) => create(ref as GetCommentLikeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        replyId: replyId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LikeModel> createElement() {
    return _GetCommentLikeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCommentLikeProvider && other.replyId == replyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, replyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCommentLikeRef on AutoDisposeFutureProviderRef<LikeModel> {
  /// The parameter `replyId` of this provider.
  String? get replyId;
}

class _GetCommentLikeProviderElement
    extends AutoDisposeFutureProviderElement<LikeModel> with GetCommentLikeRef {
  _GetCommentLikeProviderElement(super.provider);

  @override
  String? get replyId => (origin as GetCommentLikeProvider).replyId;
}

String _$getAllCommentsHash() => r'ee789afbff77f5f3b03c93a75d95cbff6520602b';

/// See also [getAllComments].
@ProviderFor(getAllComments)
const getAllCommentsProvider = GetAllCommentsFamily();

/// See also [getAllComments].
class GetAllCommentsFamily extends Family<AsyncValue<List<CommentModel>>> {
  /// See also [getAllComments].
  const GetAllCommentsFamily();

  /// See also [getAllComments].
  GetAllCommentsProvider call({
    required String? threadId,
  }) {
    return GetAllCommentsProvider(
      threadId: threadId,
    );
  }

  @override
  GetAllCommentsProvider getProviderOverride(
    covariant GetAllCommentsProvider provider,
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
  String? get name => r'getAllCommentsProvider';
}

/// See also [getAllComments].
class GetAllCommentsProvider
    extends AutoDisposeFutureProvider<List<CommentModel>> {
  /// See also [getAllComments].
  GetAllCommentsProvider({
    required String? threadId,
  }) : this._internal(
          (ref) => getAllComments(
            ref as GetAllCommentsRef,
            threadId: threadId,
          ),
          from: getAllCommentsProvider,
          name: r'getAllCommentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAllCommentsHash,
          dependencies: GetAllCommentsFamily._dependencies,
          allTransitiveDependencies:
              GetAllCommentsFamily._allTransitiveDependencies,
          threadId: threadId,
        );

  GetAllCommentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.threadId,
  }) : super.internal();

  final String? threadId;

  @override
  Override overrideWith(
    FutureOr<List<CommentModel>> Function(GetAllCommentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAllCommentsProvider._internal(
        (ref) => create(ref as GetAllCommentsRef),
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
  AutoDisposeFutureProviderElement<List<CommentModel>> createElement() {
    return _GetAllCommentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAllCommentsProvider && other.threadId == threadId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, threadId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAllCommentsRef on AutoDisposeFutureProviderRef<List<CommentModel>> {
  /// The parameter `threadId` of this provider.
  String? get threadId;
}

class _GetAllCommentsProviderElement
    extends AutoDisposeFutureProviderElement<List<CommentModel>>
    with GetAllCommentsRef {
  _GetAllCommentsProviderElement(super.provider);

  @override
  String? get threadId => (origin as GetAllCommentsProvider).threadId;
}

String _$getAllReplyOnCommentHash() =>
    r'059cb31e324821881213447524baf09fc6ad780a';

/// See also [getAllReplyOnComment].
@ProviderFor(getAllReplyOnComment)
const getAllReplyOnCommentProvider = GetAllReplyOnCommentFamily();

/// See also [getAllReplyOnComment].
class GetAllReplyOnCommentFamily
    extends Family<AsyncValue<List<CommentModel>>> {
  /// See also [getAllReplyOnComment].
  const GetAllReplyOnCommentFamily();

  /// See also [getAllReplyOnComment].
  GetAllReplyOnCommentProvider call({
    required String? commentId,
  }) {
    return GetAllReplyOnCommentProvider(
      commentId: commentId,
    );
  }

  @override
  GetAllReplyOnCommentProvider getProviderOverride(
    covariant GetAllReplyOnCommentProvider provider,
  ) {
    return call(
      commentId: provider.commentId,
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
  String? get name => r'getAllReplyOnCommentProvider';
}

/// See also [getAllReplyOnComment].
class GetAllReplyOnCommentProvider
    extends AutoDisposeFutureProvider<List<CommentModel>> {
  /// See also [getAllReplyOnComment].
  GetAllReplyOnCommentProvider({
    required String? commentId,
  }) : this._internal(
          (ref) => getAllReplyOnComment(
            ref as GetAllReplyOnCommentRef,
            commentId: commentId,
          ),
          from: getAllReplyOnCommentProvider,
          name: r'getAllReplyOnCommentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAllReplyOnCommentHash,
          dependencies: GetAllReplyOnCommentFamily._dependencies,
          allTransitiveDependencies:
              GetAllReplyOnCommentFamily._allTransitiveDependencies,
          commentId: commentId,
        );

  GetAllReplyOnCommentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.commentId,
  }) : super.internal();

  final String? commentId;

  @override
  Override overrideWith(
    FutureOr<List<CommentModel>> Function(GetAllReplyOnCommentRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAllReplyOnCommentProvider._internal(
        (ref) => create(ref as GetAllReplyOnCommentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        commentId: commentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CommentModel>> createElement() {
    return _GetAllReplyOnCommentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAllReplyOnCommentProvider &&
        other.commentId == commentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, commentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAllReplyOnCommentRef
    on AutoDisposeFutureProviderRef<List<CommentModel>> {
  /// The parameter `commentId` of this provider.
  String? get commentId;
}

class _GetAllReplyOnCommentProviderElement
    extends AutoDisposeFutureProviderElement<List<CommentModel>>
    with GetAllReplyOnCommentRef {
  _GetAllReplyOnCommentProviderElement(super.provider);

  @override
  String? get commentId => (origin as GetAllReplyOnCommentProvider).commentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
