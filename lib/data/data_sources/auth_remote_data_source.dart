import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../main.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel?>? loginUser(String? email, String? password);
  Future<dynamic> loginWithGoogle();
  Future<bool> registerUser(String? userName, String? email, String? password, String? type, String? subType);
  Future<void> logout();
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

      Response? response = await _apiClient!.postReq(
        url: ApiConstants.loginUrl,
        body: body,
      );
      if (response!.statusCode == 200) {
        var responseJson = response.data;
        if (responseJson != null) {
          log(responseJson.toString());
          var loginMessage = responseJson['message'];
          var jwtToken = responseJson['token'];
          if (loginMessage == 'Login sucessfull') {
            Map<String, dynamic> accessTokenPayload = JwtDecoder.decode(jwtToken);

            // Save the payload to shared preferences
            await prefs!.setString('jwtToken', jwtToken);
            await prefs!.setString('user_id', accessTokenPayload['user_detail']['user_id']);
            await prefs!.setString('user_name', accessTokenPayload['user_detail']['user_name']);
            await prefs!.setString('email', accessTokenPayload['user_detail']['email']);
            await prefs!.setString('type', accessTokenPayload['user_detail']['type']);
            await prefs!.setString('subtype', accessTokenPayload['user_detail']['subtype']);

            return LoginModel.fromJson(responseJson);
          } else if (loginMessage == "Email sent") {
            return LoginModel(message: loginMessage);
          }
        }
      }
    } catch (e) {
      log("Login User Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
    throw AppError();
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
  Future<bool> registerUser(
    String? userName,
    String? email,
    String? password,
    String? type,
    String? subType,
  ) async {
    try {
      var body = {
        'user_name': userName,
        'email': email,
        'password': password,
        'type': type,
        'subtype': subType,
      };

      Response? response = await _apiClient!.postReq(
        url: ApiConstants.registerUrl,
        body: body,
      );

      var responseJson = response!.data;
      if (responseJson != null) {
        log(responseJson.toString());
        var registerMessage = responseJson['message'];
        if (registerMessage == 'User registered') {
          RegisterModel.fromJson(responseJson);
          return true;
        }
      }
    } catch (e) {
      log("Register User Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
    throw AppError();
  }
}
