import 'dart:io';

import 'package:briefsea/data/data_sources/auth_remote_data_source.dart';
import 'package:briefsea/data/models/login_model.dart';
import 'package:dartz/dartz.dart';

import '../core/app_error.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepository(this._authRemoteDataSource);

  Future<Either<AppError, LoginModel>>? loginUser(String? email, String? password) async {
    try {
      final loginModel = await _authRemoteDataSource.loginUser(email, password);
      return Right(loginModel!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, bool>>? registerUser(String? userName, String? email, String? password, String? type, String? subType) async {
    try {
      final isUserRegistered = await _authRemoteDataSource.registerUser(userName, email, password, type, subType);
      return Right(isUserRegistered);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
