import 'dart:io';

import 'package:briefsea/data/data_sources/reply_remote_data_source.dart';
import 'package:briefsea/data/models/comment_model.dart';
import 'package:briefsea/data/models/like_model.dart';
import 'package:dartz/dartz.dart';

import '../core/app_error.dart';

class ReplyRepository {
  final ReplyRemoteDataSource _remoteDataSource;

  ReplyRepository(this._remoteDataSource);

  Future<Either<AppError, bool>>? postReply(userId, threadId, commentText) async {
    try {
      final userProfileModel = await _remoteDataSource.postReply(userId, threadId, commentText);
      return Right(userProfileModel);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, List<CommentModel>>>? getAllComments(threadId) async {
    try {
      final commentModel = await _remoteDataSource.getAllComments(threadId);
      return Right(commentModel);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, LikeModel>>? getCommentLike(replyId) async {
    try {
      final commentLike = await _remoteDataSource.getCommentLike(replyId);
      return Right(commentLike!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
