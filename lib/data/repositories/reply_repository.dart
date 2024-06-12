import 'dart:io';

import 'package:dartz/dartz.dart';

import '../core/app_error.dart';
import '../data_sources/reply_remote_data_source.dart';
import '../models/comment_model.dart';
import '../models/like_model.dart';

class ReplyRepository {
  final ReplyRemoteDataSource _remoteDataSource;

  ReplyRepository(this._remoteDataSource);

  Future<Either<AppError, bool>>? postReply(String? userId, String? threadId, String? commentText, String? replyId) async {
    try {
      final userProfileModel = await _remoteDataSource.postReply(userId, threadId, commentText, replyId);
      return Right(userProfileModel);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, List<CommentModel>>>? getAllComments(String? threadId) async {
    try {
      final commentModel = await _remoteDataSource.getAllComments(threadId);
      return Right(commentModel);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, LikeModel>>? getCommentLike(String? replyId) async {
    try {
      final commentLike = await _remoteDataSource.getCommentLike(replyId);
      return Right(commentLike!);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, List<CommentModel>>>? getAllReplyOnComment(String? commentId) async {
    try {
      final repliesOnComment = await _remoteDataSource.getAllReplyOnComment(commentId);
      return Right(repliesOnComment);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
