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
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, List<CommentModel>>>? getAllComments(String? threadId) async {
    try {
      final commentModel = await _remoteDataSource.getAllComments(threadId);
      return Right(commentModel);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, LikeModel>>? getCommentLike(String? replyId) async {
    try {
      final commentLike = await _remoteDataSource.getCommentLike(replyId);
      return Right(commentLike!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, List<CommentModel>>>? getAllReplyOnComment(String? commentId) async {
    try {
      final repliesOnComment = await _remoteDataSource.getAllReplyOnComment(commentId);
      return Right(repliesOnComment);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>>? deleteComment(String? commentId) async {
    try {
      final deleteComment = await _remoteDataSource.deleteComment(commentId);
      return Right(deleteComment);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>>? editComment(String? commentId, String? commentText) async {
    try {
      final editComment = await _remoteDataSource.editComment(commentId, commentText);
      return Right(editComment);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }
}
