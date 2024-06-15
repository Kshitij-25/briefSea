import 'package:dartz/dartz.dart';

import '../core/app_error.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/login_model.dart';

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

  Future<Either<AppError, bool>>? registerUser(String? userName, String? email, String? password, String? type, String? subType) async {
    try {
      final isUserRegistered = await _authRemoteDataSource.registerUser(userName, email, password, type, subType);
      return Right(isUserRegistered);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }
}
