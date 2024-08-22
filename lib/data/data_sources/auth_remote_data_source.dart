import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../common/app_utils/shared_prefs_helper.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel?> loginUser(String? email, String? password);
  Future<GoogleSignInAccount?> signInWithGoogle();
  Future<RegisterModel> registerUser(String? firstName, String? lastName, String? email, String? password, String? type, String? subType);
  Future<bool> forgetPassword(String? email);
  Future<LoginModel?> googleAuth({String? email, String? firstName, String? displayName, String? lastName, String? type, String? avatarUrl});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<LoginModel?> loginUser(String? email, String? password) async {
    try {
      final body = {'email': email, 'password': password};
      final response = await _apiClient.postReq(url: ApiConstants.loginUrl, body: body);

      if (response?.statusCode == 200) {
        final responseJson = response?.data;
        final loginMessage = responseJson['message'] ?? responseJson['msg'];
        final jwtToken = responseJson['token'];

        if (loginMessage == 'Login sucessfull' && jwtToken != null) {
          final accessTokenPayload = JwtDecoder.decode(jwtToken);

          // Save the payload to shared preferences
          SharedPreferencesHelper.saveString('jwtToken', jwtToken);
          SharedPreferencesHelper.saveString('user_id', accessTokenPayload['user_detail']['user_id']);
          SharedPreferencesHelper.saveString('userName', accessTokenPayload['user_detail']['userName']);
          SharedPreferencesHelper.saveString('firstName', accessTokenPayload['user_detail']['firstName']);
          SharedPreferencesHelper.saveString('user_name', accessTokenPayload['user_detail']['user_name']);
          SharedPreferencesHelper.saveString('lastName', accessTokenPayload['user_detail']['lastName']);
          SharedPreferencesHelper.saveString('email', accessTokenPayload['user_detail']['email']);
          SharedPreferencesHelper.saveString('type', accessTokenPayload['user_detail']['type']);

          return LoginModel.fromJson(responseJson);
        } else if (loginMessage == 'Email sent' || loginMessage == 'Login failed' || loginMessage == 'Invalid Email') {
          return LoginModel(message: loginMessage);
        } else {
          throw AppError(errorMessage: loginMessage);
        }
      } else {
        throw AppError(statusCode: response?.statusCode);
      }
    } catch (e) {
      log('Login User Error', error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      'email',
      'profile',
    ]);
    GoogleSignInAccount? signInAccount;

    try {
      signInAccount = await googleSignIn.signIn();
      if (signInAccount == null) {
        return null; // The user canceled the sign-in
      }
      return signInAccount;
    } catch (error) {
      log('Google Sign-In Error: $error');
      rethrow; // Rethrow the error for higher-level error handling
    }
  }

  @override
  Future<RegisterModel> registerUser(String? firstName, String? lastName, String? email, String? password, String? type, String? subType) async {
    try {
      final body = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'type': type,
        'subtype': subType,
      };

      final response = await _apiClient.postReq(url: ApiConstants.registerUrl, body: body);

      if (response?.statusCode == 201 || response?.statusCode == 200) {
        final responseJson = response?.data;
        log(responseJson.toString());
        return RegisterModel.fromJson(responseJson);
      } else {
        throw AppError(statusCode: response?.statusCode);
      }
    } catch (e) {
      log('Register User Error', error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> forgetPassword(String? email) async {
    try {
      final body = {'email': email};
      final response = await _apiClient.postReq(url: ApiConstants.forgetPassword, body: body);

      if (response?.statusCode == 200) {
        final responseJson = response?.data;
        log(responseJson.toString());
        return true;
      } else {
        throw AppError(statusCode: response?.statusCode);
      }
    } catch (e) {
      log('forgetPassword Error', error: e);
      throw AppError(errorMessage: e.toString());
    }
  }

  @override
  Future<LoginModel?> googleAuth({String? email, String? firstName, String? displayName, String? lastName, String? type, String? avatarUrl}) async {
    try {
      final body = {
        "firstName": firstName,
        "user_name": displayName,
        "email": email,
        "type": type,
        "lastName": lastName,
        "avatarSrc": avatarUrl,
        "subtype": "",
      };

      final response = await _apiClient.postReq(
        url: ApiConstants.googleAuth,
        body: body,
      );

      if (response?.statusCode == 200) {
        final responseJson = response?.data;
        final loginMessage = responseJson['message'] ?? responseJson['msg'];
        final jwtToken = responseJson['token'];

        if (loginMessage == 'Login sucessfull' && jwtToken != null) {
          final accessTokenPayload = JwtDecoder.decode(jwtToken);

          // Save the payload to shared preferences
          SharedPreferencesHelper.saveString('jwtToken', jwtToken);
          SharedPreferencesHelper.saveString('user_id', accessTokenPayload['user_detail']['user_id']);
          SharedPreferencesHelper.saveString('userName', accessTokenPayload['user_detail']['userName']);
          SharedPreferencesHelper.saveString('firstName', accessTokenPayload['user_detail']['firstName']);
          SharedPreferencesHelper.saveString('user_name', accessTokenPayload['user_detail']['user_name']);
          SharedPreferencesHelper.saveString('lastName', accessTokenPayload['user_detail']['lastName']);
          SharedPreferencesHelper.saveString('email', accessTokenPayload['user_detail']['email']);
          SharedPreferencesHelper.saveString('type', accessTokenPayload['user_detail']['type']);

          return LoginModel.fromJson(responseJson);
        } else if (loginMessage == 'Email sent' || loginMessage == 'Login failed' || loginMessage == 'Invalid Email') {
          return LoginModel(message: loginMessage);
        } else {
          throw AppError(errorMessage: loginMessage);
        }
      } else {
        throw AppError(statusCode: response?.statusCode);
      }
    } catch (e) {
      log('Register User Error', error: e);
      throw AppError(errorMessage: e.toString());
    }
  }
}
