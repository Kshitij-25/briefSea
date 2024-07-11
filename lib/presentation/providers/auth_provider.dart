import 'package:briefsea/common/app_utils/shared_prefs_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/app_utils/app_utility.dart';
import '../../common/enums/enums.dart';
import '../../data/core/api_client.dart';
import '../../data/data_sources/auth_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/login_model.dart';
import '../../data/models/register_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../screens/home_screen.dart';
import '../screens/profile/verify_profile_screen.dart';
import 'notification_provider.dart';

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
        await SharedPreferencesHelper.saveBoolean('isLogin', isLoginSuccess);
        await SharedPreferencesHelper.saveBoolean('profile', loginModel.profile!);
        // Navigate based on profile status
        loginModel.profile == false
            ? GoRouter.of(context).pushNamed(VerifyProfileScreen.routeName)
            : GoRouter.of(context).pushReplacementNamed(HomeScreen.routeName);
        state = LoginState.success;
      } else if (loginModel.message == 'Email sent') {
        state = LoginState.error;
        AppUtility(context).message("Verify your email first");
      } else if (loginModel.message == 'Login failed') {
        state = LoginState.error;
        AppUtility(context).message("Incorrect username or password");
      } else if (loginModel.message == 'Invalid Email') {
        state = LoginState.error;
        AppUtility(context).message("Invalid Email");
      } else {
        state = LoginState.error;
      }
    } catch (e) {
      state = LoginState.error;
    }
  }
}

@riverpod
Future<RegisterModel> registerUser(
  RegisterUserRef ref, {
  required String firstName,
  required String lastName,
  required String email,
  required String password,
  required String type,
  required String subType,
}) async {
  final authRepository = ref.read(authRepositoryProvider);
  final eitherRegisteredOrError = await authRepository.registerUser(firstName, lastName, email, password, type, subType);
  return eitherRegisteredOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (registered) => registered,
  );
}

@riverpod
Future<bool> forgetPassword(ForgetPasswordRef ref, {required String email}) async {
  final authRepository = ref.read(authRepositoryProvider);
  final eitherForgetPassOrError = await authRepository.forgetPassword(email);
  return eitherForgetPassOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (forgetPassword) => forgetPassword,
  );
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier() : super(RegisterState.idle);

  Future<void> registerUser({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? type,
    String? subType,
    required WidgetRef ref,
    required context,
  }) async {
    state = RegisterState.loading;
    try {
      final isRegistered = await ref.read(
        registerUserProvider(
          firstName: firstName!,
          lastName: lastName!,
          email: email!,
          password: password!,
          type: type!,
          subType: subType!,
        ).future,
      );

      if (isRegistered.message == "User registered") {
        AppUtility(context).message("Registered Successfully. Check email to Verify Profile and Login.");
        await ref.read(
          postNewNotificationProvider(
            requestBody: {
              "type": 'user account',
              "sender_id": 'briefseaAdmin9712',
              "sender_name": 'Briefsea',
              "receiver_id": isRegistered.userId,
              "notification": "Welcome to Briefsea.Hire the best freelancers, vendors and professionals for your tech and marketing projects."
            },
          ).future,
        );
        GoRouter.of(context).pop();

        state = RegisterState.success;
        // Handle successful registration (e.g., navigate to a different screen)
      } else if (isRegistered.message == "User already exists") {
        state = RegisterState.error;
        AppUtility(context).message("User already exists");
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
      'jwtToken': await SharedPreferencesHelper.getString('jwtToken') ?? '',
      'user_id': await SharedPreferencesHelper.getString('user_id') ?? '',
      'user_name': await SharedPreferencesHelper.getString('user_name') ?? '',
      'firstName': await SharedPreferencesHelper.getString('firstName') ?? '',
      'lastName': await SharedPreferencesHelper.getString('lastName') ?? '',
      'name': await SharedPreferencesHelper.getString('userName') ?? '',
      'email': await SharedPreferencesHelper.getString('email') ?? '',
      'type': await SharedPreferencesHelper.getString('type') ?? '',
      'subtype': await SharedPreferencesHelper.getString('subtype') ?? '',
    };
  }
}

final userDetailsProvider = StateNotifierProvider.autoDispose<UserDetailsNotifier, Map<String, String>>((ref) {
  return UserDetailsNotifier();
});
