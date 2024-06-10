import 'dart:io';

import 'package:briefsea/data/core/app_error.dart';
import 'package:briefsea/data/data_sources/briefs_remote_data_source.dart';
import 'package:briefsea/data/models/briefs_model.dart';
import 'package:briefsea/data/models/thread_image_model.dart';
import 'package:dartz/dartz.dart';

class BreifsRepository {
  final BriefsRemoteDataSource _briefsRemoteDataSource;

  BreifsRepository(this._briefsRemoteDataSource);

  Future<Either<AppError, List<BriefsModel?>?>>? getAllBriefs() async {
    try {
      final allBriefs = await _briefsRemoteDataSource.getAllBriefs();
      return Right(allBriefs);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, List<BriefsModel?>?>>? getUserBriefs() async {
    try {
      final userBriefs = await _briefsRemoteDataSource.getUserBriefs();
      return Right(userBriefs);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, bool>>? postBrief(userId, name, type, category, postText, imgSrc) async {
    try {
      final userBriefs = await _briefsRemoteDataSource.postBrief(userId, name, type, category, postText, imgSrc);
      return Right(userBriefs);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, ThreadImageModel>>? uploadThreadImage(fileName, fileType, userId, userType) async {
    try {
      final avatarModel = await _briefsRemoteDataSource.uploadThreadImage(fileName, fileType, userId, userType);
      return Right(avatarModel!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
