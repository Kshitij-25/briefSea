import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/app_utility.dart';
import '../../common/enums/login_register_enum.dart';
import '../../data/core/api_client.dart';
import '../../data/data_sources/auth_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/login_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../main.dart';
import '../screens/auth_screens/verify_profile_screen.dart';
import '../screens/home_screen.dart';

part 'auth_provider.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final apiClient = getItInstance<ApiClient>();
  return AuthRemoteDataSourceImpl(apiClient);
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final authRemoteDataSource = ref.read(authRemoteDataSourceProvider);
  return AuthRepository(authRemoteDataSource);
}

@riverpod
Future<LoginModel> loginUser(LoginUserRef ref, {required String email, required String password}) async {
  final authRepository = ref.read(authRepositoryProvider);
  final eitherLoggedInOrError = await authRepository.loginUser(email, password);
  return eitherLoggedInOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (loggedIn) => loggedIn,
  );
}

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState.idle);

  Future<void> loginUser(String email, String password, WidgetRef ref, context) async {
    state = LoginState.loading;
    try {
      final loginModel = await ref.read(
        loginUserProvider(email: email, password: password).future,
      );
      if (loginModel.message == 'Login sucessfull') {
        var isLoginSuccess = true;
        await prefs!.setBool('isLogin', isLoginSuccess);
        await prefs!.setBool('profile', loginModel.profile!);
        // Navigate based on profile status
        loginModel.profile == false ? GoRouter.of(context).go(VerifyProfileScreen.routeName) : GoRouter.of(context).go(HomeScreen.routeName);
        state = LoginState.success;
      } else if (loginModel.message == 'Email sent') {
        state = LoginState.error;
        AppUtility(context).message("Verify your email first");
      } else {
        state = LoginState.error;
      }
    } catch (e) {
      state = LoginState.error;
    }
  }
}

@riverpod
Future<bool> registerUser(RegisterUserRef ref,
    {required String userName, required String email, required String password, required String type, required String subType}) async {
  final authRepository = ref.read(authRepositoryProvider);
  final eitherRegisteredOrError = await authRepository.registerUser(userName, email, password, type, subType);
  return eitherRegisteredOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (registered) => registered,
  );
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier() : super(RegisterState.idle);

  Future<void> registerUser(String? userName, String? email, String? password, String? type, String? subType, WidgetRef ref, context) async {
    state = RegisterState.loading;
    try {
      final isRegistered = await ref.read(
        registerUserProvider(
          userName: userName!,
          email: email!,
          password: password!,
          type: type!,
          subType: subType!,
        ).future,
      );

      if (isRegistered == true) {
        AppUtility(context).message("Registered Successfully. Check email to Verify Profile and Login.");
        GoRouter.of(context).pop();

        state = RegisterState.success;
        // Handle successful registration (e.g., navigate to a different screen)
      } else {
        state = RegisterState.error;
      }
    } catch (e) {
      state = RegisterState.error;
    }
  }
}

final registerNotifierProvider = StateNotifierProvider<RegisterNotifier, RegisterState>(
  (ref) => RegisterNotifier(),
);

class UserDetailsNotifier extends StateNotifier<Map<String, String>> {
  UserDetailsNotifier() : super({}) {
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    state = {
      'jwtToken': prefs!.getString('jwtToken') ?? '',
      'user_id': prefs!.getString('user_id') ?? '',
      'user_name': prefs!.getString('user_name') ?? '',
      'email': prefs!.getString('email') ?? '',
      'type': prefs!.getString('type') ?? '',
      'subtype': prefs!.getString('subtype') ?? '',
    };
  }
}

final userDetailsProvider = StateNotifierProvider<UserDetailsNotifier, Map<String, String>>((ref) {
  return UserDetailsNotifier();
});
