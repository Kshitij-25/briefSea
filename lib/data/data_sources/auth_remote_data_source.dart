import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../common/app_utils/shared_prefs_helper.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel?>? loginUser(String? email, String? password);
  Future<dynamic> loginWithGoogle();
  Future<RegisterModel> registerUser(String? firstName, String? lastName, String? email, String? password, String? type, String? subType);
  Future<void> logout();
  Future<bool> forgetPassword(String? email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient? _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LoginModel?>? loginUser(String? email, String? password) async {
    try {
      var body = {
        'email': email,
        'password': password,
      };

      Response? response = await _apiClient?.postReq(
        url: ApiConstants.loginUrl,
        body: body,
      );
      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          final responseJson = response.data;
          log(responseJson.toString());

          var loginMessage = responseJson['message'] ?? responseJson['msg'];
          var jwtToken = responseJson['token'];

          if (loginMessage == 'Login sucessfull' && jwtToken != null) {
            Map<String, dynamic> accessTokenPayload = JwtDecoder.decode(jwtToken);

            // Save the payload to shared preferences
            SharedPreferencesHelper.saveString('jwtToken', jwtToken);
            SharedPreferencesHelper.saveString('user_id', accessTokenPayload['user_detail']['user_id']) ?? '';
            SharedPreferencesHelper.saveString('userName', accessTokenPayload['user_detail']['userName'] ?? '');
            SharedPreferencesHelper.saveString('firstName', accessTokenPayload['user_detail']['firstName'] ?? '');
            SharedPreferencesHelper.saveString('user_name', accessTokenPayload['user_detail']['user_name'] ?? '');
            SharedPreferencesHelper.saveString('lastName', accessTokenPayload['user_detail']['lastName'] ?? '');
            SharedPreferencesHelper.saveString('email', accessTokenPayload['user_detail']['email'] ?? '');
            SharedPreferencesHelper.saveString('type', accessTokenPayload['user_detail']['type'] ?? '');
            // await prefs?.setString('subtype', accessTokenPayload['user_detail']['subtype']);

            return LoginModel.fromJson(responseJson);
          } else if (loginMessage == "Email sent") {
            return LoginModel(message: loginMessage);
          } else if (loginMessage == "Login failed") {
            return LoginModel(message: loginMessage);
          } else if (loginMessage == "Invalid Email") {
            return LoginModel(message: loginMessage);
          } else {
            throw AppError(errorMessage: loginMessage);
          }
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      }
    } catch (e) {
      log("Login User Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
    throw AppError(errorMessage: "Unknown error occurred during login");
  }

  @override
  Future loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<RegisterModel> registerUser(String? firstName, String? lastName, String? email, String? password, String? type, String? subType) async {
    try {
      var body = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'type': type,
        'subtype': subType,
      };

      Response? response = await _apiClient?.postReq(
        url: ApiConstants.registerUrl,
        body: body,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 201) {
          final responseJson = response.data;
          log(responseJson.toString());
          return RegisterModel.fromJson(responseJson);
        } else if (response.statusCode == 200) {
          final responseJson = response.data;
          log(responseJson.toString());
          return RegisterModel.fromJson(responseJson);
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      }
    } catch (e) {
      log("Register User Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
    throw AppError(errorMessage: "Unknown error occurred during registration");
  }

  @override
  Future<bool> forgetPassword(String? email) async {
    try {
      var body = {
        'email': email,
      };

      Response? response = await _apiClient?.postReq(
        url: ApiConstants.forgetPassword,
        body: body,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200) {
          final responseJson = response.data;
          log(responseJson.toString());
          return true;
          //   return RegisterModel.fromJson(responseJson);
          // } else if (response.statusCode == 200) {
          //   final responseJson = response.data;
          //   log(responseJson.toString());
          //   return RegisterModel.fromJson(responseJson);
        } else {
          throw AppError(statusCode: response.statusCode);
        }
      }
    } catch (e) {
      log("forgetPassword Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
    throw AppError(errorMessage: "Unknown error occurred");
  }
}
