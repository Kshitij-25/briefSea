import 'package:dartz/dartz.dart';

import '../core/app_error.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepository(this._authRemoteDataSource);

  Future<Either<AppError, LoginModel>>? loginUser(String? email, String? password) async {
    try {
      final loginModel = await _authRemoteDataSource.loginUser(email, password);
      return Right(loginModel!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, RegisterModel>>? registerUser(
      String? firstName, String? lastName, String? email, String? password, String? type, String? subType) async {
    try {
      final isUserRegistered = await _authRemoteDataSource.registerUser(firstName, lastName, email, password, type, subType);
      return Right(isUserRegistered);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>>? forgetPassword(String? email) async {
    try {
      final forgetPass = await _authRemoteDataSource.forgetPassword(email);
      return Right(forgetPass);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }
}
