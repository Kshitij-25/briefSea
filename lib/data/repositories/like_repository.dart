import 'dart:io';

import 'package:briefsea/data/models/like_model.dart';
import 'package:dartz/dartz.dart';

import '../core/app_error.dart';
import '../data_sources/like_remote_data_source.dart';

class LikeRepository {
  final LikeRemoteDataSource _likeRemoteDataSource;

  LikeRepository(this._likeRemoteDataSource);

  Future<Either<AppError, bool>>? postLike({userId, name, type, threadId, replyId}) async {
    try {
      final isLiked = await _likeRemoteDataSource.postLike(userId, name, type, threadId, replyId);
      return Right(isLiked!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, LikeModel>>? getALike(threadId) async {
    try {
      final isLiked = await _likeRemoteDataSource.getALike(threadId);
      return Right(isLiked!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, bool>>? deleteLike(userId, name, type, threadId, replyId, likeId) async {
    try {
      final isLikeDeleted = await _likeRemoteDataSource.deleteLike(userId, name, type, threadId, replyId, likeId);
      return Right(isLikeDeleted!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
