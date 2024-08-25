import 'dart:convert';

import 'package:briefsea/common/app_utils/shared_prefs_helper.dart';
import 'package:briefsea/presentation/params/notification_params.dart';
import 'package:briefsea/presentation/screens/auth_screens/existing_login_screen.dart';
import 'package:briefsea/presentation/state_providers/verify_profile_industry_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
import '../../main.dart';
import '../screens/auth_screens/choose_account_type.dart';
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
            : GoRouter.of(context).goNamed(HomeScreen.routeName);
        state = LoginState.success;
      } else if (loginModel.message == 'Email sent') {
        state = LoginState.error;
        AppUtility(context).message("Verify your email first");
      } else if (loginModel.message == 'Login failed') {
        state = LoginState.error;
        AppUtility(context).error("Incorrect username or password");
      } else if (loginModel.message == 'Invalid Email') {
        state = LoginState.error;
        AppUtility(context).error("Invalid Email");
      } else {
        state = LoginState.error;
      }
    } catch (e) {
      state = LoginState.error;
    }
  }

  Future<void> loginWithGoogle({required BuildContext context, required WidgetRef ref, bool? isLogin}) async {
    state = LoginState.loading;
    try {
      // JWT parsing function
      Map<String, dynamic>? parseJwt(String token) {
        final List<String> parts = token.split('.');
        if (parts.length != 3) return null;

        final String payload = parts[1];
        final String normalized = base64Url.normalize(payload);
        final String resp = utf8.decode(base64Url.decode(normalized));

        final payloadMap = json.decode(resp);
        if (payloadMap is! Map<String, dynamic>) return null;

        return payloadMap;
      }

      final authRepository = await ref.read(authRepositoryProvider);
      final eitherSignInAccountOrError = await authRepository.signInWithGoogle();

      final signInAccount = eitherSignInAccountOrError!.fold(
        (error) {
          throw error;
        },
        (signInAccount) => signInAccount,
      );

      if (signInAccount == null) {
        state = LoginState.error;
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication = await signInAccount.authentication;

      // Parse JWT token
      Map<String, dynamic>? idMap = parseJwt(googleSignInAuthentication.idToken!);

      if (idMap == null) {
        state = LoginState.error;
        AppUtility(context).error("Failed to parse JWT token");
        return;
      }

      await SharedPreferencesHelper.saveString('displayName', signInAccount.displayName ?? '');
      await SharedPreferencesHelper.saveString('firstName', idMap["given_name"] ?? '');
      await SharedPreferencesHelper.saveString('lastName', idMap["family_name"] ?? '');
      await SharedPreferencesHelper.saveString('email', signInAccount.email);
      await SharedPreferencesHelper.saveString('avatarUrl', signInAccount.photoUrl ?? '');

      if (isLogin == true) {
        await isUserRegistered(email: signInAccount.email, ref: ref, context: context);
      }
      state = LoginState.success;
    } catch (e) {
      state = LoginState.error;
    }
  }

  Future<void> isUserRegistered({String? email, WidgetRef? ref, BuildContext? context}) async {
    state = LoginState.loading;
    try {
      final authRepository = await ref!.read(authRepositoryProvider);
      final eitherIsUserRegisteredOrError = await authRepository.isUserRegistered(email);

      final isUserRegistered = eitherIsUserRegisteredOrError.fold(
        (error) => throw error,
        (isUserRegistered) => isUserRegistered,
      );

      if (isUserRegistered != true) {
        state = LoginState.success;
        GoRouter.of(context!).pushNamed(ChooseAccountType.routeName);
      } else {
        await chooseAccountType(
          context: context!,
          ref: ref,
          isUserRegistered: true,
        );
        state = LoginState.success;
      }
    } catch (e) {
      state = LoginState.error;
    }
  }

  Future<void> chooseAccountType({
    required BuildContext context,
    required WidgetRef ref,
    bool? isUserRegistered,
  }) async {
    state = LoginState.loading;
    try {
      final accountType = ref.watch(selectAccountTypeProvider).selectedType;

      final displayName = await SharedPreferencesHelper.getString('displayName');
      final firstName = await SharedPreferencesHelper.getString('firstName');
      final lastName = await SharedPreferencesHelper.getString('lastName');
      final email = await SharedPreferencesHelper.getString('email');
      final avatarUrl = await SharedPreferencesHelper.getString('avatarUrl');
      await SharedPreferencesHelper.saveString('accountType', accountType ?? '');

      final authRepository = await ref.read(authRepositoryProvider);

      final eitherSignInAccountOrError = await authRepository.googleAuth(
        displayName: displayName!,
        firstName: firstName!,
        lastName: lastName!,
        email: email!,
        avatarUrl: avatarUrl!,
        type: accountType,
      );

      final loginModel = eitherSignInAccountOrError!.fold(
        (error) => throw error,
        (loginModel) => loginModel,
      );

      if (loginModel!.message == 'Login sucessfull') {
        await SharedPreferencesHelper.saveBoolean('isLogin', true);
        await SharedPreferencesHelper.saveBoolean('profile', loginModel.profile!);
        if (isUserRegistered == false) {
          var requestBody = {
            "type": 'user account',
            "sender_id": 'briefseaAdmin9712',
            "sender_name": 'Briefsea',
            "receiver_id": prefs!.getString('user_id'),
            "notification": "Welcome to Briefsea.Hire the best freelancers, vendors and professionals for your tech and marketing projects."
          };
          await ref.read(
            NotificationProvider.postNewNotificationProvider(
              PostNewNotificationParams(requestBody: requestBody),
            ).future,
          );
        }
        GoRouter.of(context).goNamed(HomeScreen.routeName);
        state = LoginState.success;
      } else if (loginModel.message == 'Email sent') {
        state = LoginState.error;
        AppUtility(context).message("Verify your email first");
      } else if (loginModel.message == 'Login failed') {
        state = LoginState.error;
        AppUtility(context).error("Incorrect username or password");
      } else if (loginModel.message == 'Invalid Email') {
        state = LoginState.error;
        AppUtility(context).error("Invalid Email");
      } else {
        state = LoginState.error;
      }
      state = LoginState.success;
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
        var requestBody = {
          "type": 'user account',
          "sender_id": 'briefseaAdmin9712',
          "sender_name": 'Briefsea',
          "receiver_id": isRegistered.userId,
          "notification": "Welcome to Briefsea.Hire the best freelancers, vendors and professionals for your tech and marketing projects."
        };
        await ref.read(
          NotificationProvider.postNewNotificationProvider(
            PostNewNotificationParams(requestBody: requestBody),
          ).future,
        );
        GoRouter.of(context).pushReplacementNamed(ExistingLoginScreen.routeName);

        state = RegisterState.success;
        // Handle successful registration (e.g., navigate to a different screen)
      } else if (isRegistered.message == "User already exists") {
        state = RegisterState.error;
        AppUtility(context).error("User already exists");
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
