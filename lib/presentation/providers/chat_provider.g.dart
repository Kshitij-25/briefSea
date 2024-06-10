// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRemoteDataSourceHash() =>
    r'd77f5966c787970d5d8b4475602216b17c4dca3f';

/// See also [chatRemoteDataSource].
@ProviderFor(chatRemoteDataSource)
final chatRemoteDataSourceProvider =
    AutoDisposeProvider<ChatRemoteDataSource>.internal(
  chatRemoteDataSource,
  name: r'chatRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatRemoteDataSourceRef = AutoDisposeProviderRef<ChatRemoteDataSource>;
String _$chatRepositoryHash() => r'94cee7b92c99275ca4563dbce6ccd109760f4f87';

/// See also [chatRepository].
@ProviderFor(chatRepository)
final chatRepositoryProvider = AutoDisposeProvider<ChatRepository>.internal(
  chatRepository,
  name: r'chatRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatRepositoryRef = AutoDisposeProviderRef<ChatRepository>;
String _$getChatUsersListHash() => r'1d4c2a9436fda00ebad142b20f0e557b77bbdcd8';

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

/// See also [getChatUsersList].
@ProviderFor(getChatUsersList)
const getChatUsersListProvider = GetChatUsersListFamily();

/// See also [getChatUsersList].
class GetChatUsersListFamily extends Family<AsyncValue<List<ChatUserModel>>> {
  /// See also [getChatUsersList].
  const GetChatUsersListFamily();

  /// See also [getChatUsersList].
  GetChatUsersListProvider call({
    required String userId,
  }) {
    return GetChatUsersListProvider(
      userId: userId,
    );
  }

  @override
  GetChatUsersListProvider getProviderOverride(
    covariant GetChatUsersListProvider provider,
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
  String? get name => r'getChatUsersListProvider';
}

/// See also [getChatUsersList].
class GetChatUsersListProvider
    extends AutoDisposeFutureProvider<List<ChatUserModel>> {
  /// See also [getChatUsersList].
  GetChatUsersListProvider({
    required String userId,
  }) : this._internal(
          (ref) => getChatUsersList(
            ref as GetChatUsersListRef,
            userId: userId,
          ),
          from: getChatUsersListProvider,
          name: r'getChatUsersListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getChatUsersListHash,
          dependencies: GetChatUsersListFamily._dependencies,
          allTransitiveDependencies:
              GetChatUsersListFamily._allTransitiveDependencies,
          userId: userId,
        );

  GetChatUsersListProvider._internal(
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
    FutureOr<List<ChatUserModel>> Function(GetChatUsersListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetChatUsersListProvider._internal(
        (ref) => create(ref as GetChatUsersListRef),
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
  AutoDisposeFutureProviderElement<List<ChatUserModel>> createElement() {
    return _GetChatUsersListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetChatUsersListProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetChatUsersListRef on AutoDisposeFutureProviderRef<List<ChatUserModel>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _GetChatUsersListProviderElement
    extends AutoDisposeFutureProviderElement<List<ChatUserModel>>
    with GetChatUsersListRef {
  _GetChatUsersListProviderElement(super.provider);

  @override
  String get userId => (origin as GetChatUsersListProvider).userId;
}

String _$createNewChatHash() => r'90582e54e8c85a0cee575063fc2c35172e857e47';

/// See also [createNewChat].
@ProviderFor(createNewChat)
const createNewChatProvider = CreateNewChatFamily();

/// See also [createNewChat].
class CreateNewChatFamily extends Family<AsyncValue<bool>> {
  /// See also [createNewChat].
  const CreateNewChatFamily();

  /// See also [createNewChat].
  CreateNewChatProvider call({
    required String senderId,
    required String receiverId,
  }) {
    return CreateNewChatProvider(
      senderId: senderId,
      receiverId: receiverId,
    );
  }

  @override
  CreateNewChatProvider getProviderOverride(
    covariant CreateNewChatProvider provider,
  ) {
    return call(
      senderId: provider.senderId,
      receiverId: provider.receiverId,
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
  String? get name => r'createNewChatProvider';
}

/// See also [createNewChat].
class CreateNewChatProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [createNewChat].
  CreateNewChatProvider({
    required String senderId,
    required String receiverId,
  }) : this._internal(
          (ref) => createNewChat(
            ref as CreateNewChatRef,
            senderId: senderId,
            receiverId: receiverId,
          ),
          from: createNewChatProvider,
          name: r'createNewChatProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createNewChatHash,
          dependencies: CreateNewChatFamily._dependencies,
          allTransitiveDependencies:
              CreateNewChatFamily._allTransitiveDependencies,
          senderId: senderId,
          receiverId: receiverId,
        );

  CreateNewChatProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.senderId,
    required this.receiverId,
  }) : super.internal();

  final String senderId;
  final String receiverId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(CreateNewChatRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateNewChatProvider._internal(
        (ref) => create(ref as CreateNewChatRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        senderId: senderId,
        receiverId: receiverId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _CreateNewChatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateNewChatProvider &&
        other.senderId == senderId &&
        other.receiverId == receiverId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, senderId.hashCode);
    hash = _SystemHash.combine(hash, receiverId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateNewChatRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `senderId` of this provider.
  String get senderId;

  /// The parameter `receiverId` of this provider.
  String get receiverId;
}

class _CreateNewChatProviderElement
    extends AutoDisposeFutureProviderElement<bool> with CreateNewChatRef {
  _CreateNewChatProviderElement(super.provider);

  @override
  String get senderId => (origin as CreateNewChatProvider).senderId;
  @override
  String get receiverId => (origin as CreateNewChatProvider).receiverId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
