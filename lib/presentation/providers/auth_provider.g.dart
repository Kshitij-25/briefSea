// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRemoteDataSourceHash() =>
    r'a8a53b485a354f16c32efa2e0babf88c23b6cbc1';

/// See also [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider =
    AutoDisposeProvider<AuthRemoteDataSource>.internal(
  authRemoteDataSource,
  name: r'authRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRemoteDataSourceRef = AutoDisposeProviderRef<AuthRemoteDataSource>;
String _$authRepositoryHash() => r'a9bb4ad64c58d846d1d8646765198372f0283eb9';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$loginUserHash() => r'969592493b6b20196aef9a78d8e03fb8df7bf801';

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

/// See also [loginUser].
@ProviderFor(loginUser)
const loginUserProvider = LoginUserFamily();

/// See also [loginUser].
class LoginUserFamily extends Family<AsyncValue<LoginModel>> {
  /// See also [loginUser].
  const LoginUserFamily();

  /// See also [loginUser].
  LoginUserProvider call({
    required String email,
    required String password,
  }) {
    return LoginUserProvider(
      email: email,
      password: password,
    );
  }

  @override
  LoginUserProvider getProviderOverride(
    covariant LoginUserProvider provider,
  ) {
    return call(
      email: provider.email,
      password: provider.password,
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
  String? get name => r'loginUserProvider';
}

/// See also [loginUser].
class LoginUserProvider extends AutoDisposeFutureProvider<LoginModel> {
  /// See also [loginUser].
  LoginUserProvider({
    required String email,
    required String password,
  }) : this._internal(
          (ref) => loginUser(
            ref as LoginUserRef,
            email: email,
            password: password,
          ),
          from: loginUserProvider,
          name: r'loginUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loginUserHash,
          dependencies: LoginUserFamily._dependencies,
          allTransitiveDependencies: LoginUserFamily._allTransitiveDependencies,
          email: email,
          password: password,
        );

  LoginUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
    required this.password,
  }) : super.internal();

  final String email;
  final String password;

  @override
  Override overrideWith(
    FutureOr<LoginModel> Function(LoginUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoginUserProvider._internal(
        (ref) => create(ref as LoginUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
        password: password,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LoginModel> createElement() {
    return _LoginUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoginUserProvider &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, password.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LoginUserRef on AutoDisposeFutureProviderRef<LoginModel> {
  /// The parameter `email` of this provider.
  String get email;

  /// The parameter `password` of this provider.
  String get password;
}

class _LoginUserProviderElement
    extends AutoDisposeFutureProviderElement<LoginModel> with LoginUserRef {
  _LoginUserProviderElement(super.provider);

  @override
  String get email => (origin as LoginUserProvider).email;
  @override
  String get password => (origin as LoginUserProvider).password;
}

String _$registerUserHash() => r'f3672407e0bd0f2c9f2e721555f8c4424a6f6789';

/// See also [registerUser].
@ProviderFor(registerUser)
const registerUserProvider = RegisterUserFamily();

/// See also [registerUser].
class RegisterUserFamily extends Family<AsyncValue<bool>> {
  /// See also [registerUser].
  const RegisterUserFamily();

  /// See also [registerUser].
  RegisterUserProvider call({
    required String userName,
    required String email,
    required String password,
    required String type,
    required String subType,
  }) {
    return RegisterUserProvider(
      userName: userName,
      email: email,
      password: password,
      type: type,
      subType: subType,
    );
  }

  @override
  RegisterUserProvider getProviderOverride(
    covariant RegisterUserProvider provider,
  ) {
    return call(
      userName: provider.userName,
      email: provider.email,
      password: provider.password,
      type: provider.type,
      subType: provider.subType,
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
  String? get name => r'registerUserProvider';
}

/// See also [registerUser].
class RegisterUserProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [registerUser].
  RegisterUserProvider({
    required String userName,
    required String email,
    required String password,
    required String type,
    required String subType,
  }) : this._internal(
          (ref) => registerUser(
            ref as RegisterUserRef,
            userName: userName,
            email: email,
            password: password,
            type: type,
            subType: subType,
          ),
          from: registerUserProvider,
          name: r'registerUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$registerUserHash,
          dependencies: RegisterUserFamily._dependencies,
          allTransitiveDependencies:
              RegisterUserFamily._allTransitiveDependencies,
          userName: userName,
          email: email,
          password: password,
          type: type,
          subType: subType,
        );

  RegisterUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userName,
    required this.email,
    required this.password,
    required this.type,
    required this.subType,
  }) : super.internal();

  final String userName;
  final String email;
  final String password;
  final String type;
  final String subType;

  @override
  Override overrideWith(
    FutureOr<bool> Function(RegisterUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegisterUserProvider._internal(
        (ref) => create(ref as RegisterUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userName: userName,
        email: email,
        password: password,
        type: type,
        subType: subType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _RegisterUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterUserProvider &&
        other.userName == userName &&
        other.email == email &&
        other.password == password &&
        other.type == type &&
        other.subType == subType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userName.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, password.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, subType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RegisterUserRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userName` of this provider.
  String get userName;

  /// The parameter `email` of this provider.
  String get email;

  /// The parameter `password` of this provider.
  String get password;

  /// The parameter `type` of this provider.
  String get type;

  /// The parameter `subType` of this provider.
  String get subType;
}

class _RegisterUserProviderElement
    extends AutoDisposeFutureProviderElement<bool> with RegisterUserRef {
  _RegisterUserProviderElement(super.provider);

  @override
  String get userName => (origin as RegisterUserProvider).userName;
  @override
  String get email => (origin as RegisterUserProvider).email;
  @override
  String get password => (origin as RegisterUserProvider).password;
  @override
  String get type => (origin as RegisterUserProvider).type;
  @override
  String get subType => (origin as RegisterUserProvider).subType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
