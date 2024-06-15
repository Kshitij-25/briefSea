import 'package:dartz/dartz.dart';

import '../core/app_error.dart';
import '../data_sources/like_remote_data_source.dart';
import '../models/like_model.dart';

class LikeRepository {
  final LikeRemoteDataSource _likeRemoteDataSource;

  LikeRepository(this._likeRemoteDataSource);

  Future<Either<AppError, bool>>? postLike({
    String? userId,
    String? name,
    String? type,
    String? threadId,
    String? replyId,
  }) async {
    try {
      final isLiked = await _likeRemoteDataSource.postLike(
        userId: userId,
        name: name,
        type: type,
        threadId: threadId,
        replyId: replyId,
      );
      return Right(isLiked!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, LikeModel>>? getALike(String? threadId) async {
    try {
      final isLiked = await _likeRemoteDataSource.getALike(threadId);
      return Right(isLiked!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>>? deleteLike(String? threadId, String? likeId) async {
    try {
      final isLikeDeleted = await _likeRemoteDataSource.deleteLike(threadId, likeId);
      return Right(isLikeDeleted!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }
}
