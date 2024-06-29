import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';

import '../core/app_error.dart';
import '../data_sources/briefs_remote_data_source.dart';
import '../models/briefs_model.dart';
import '../models/thread_image_model.dart';

class BreifsRepository {
  final BriefsRemoteDataSource _briefsRemoteDataSource;

  BreifsRepository(this._briefsRemoteDataSource);

  Future<Either<AppError, List<BriefsModel?>?>>? getAllBriefs() async {
    try {
      final allBriefs = await _briefsRemoteDataSource.getAllBriefs();
      return Right(allBriefs);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, List<BriefsModel?>?>>? getUserBriefs() async {
    try {
      final userBriefs = await _briefsRemoteDataSource.getUserBriefs();
      return Right(userBriefs);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, BriefsModel?>>? getSingleBrief(String? briefId) async {
    try {
      final singleBrief = await _briefsRemoteDataSource.getSingleBrief(briefId);
      return Right(singleBrief);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>>? postBrief({
    String? userId,
    String? name,
    String? type,
    String? category,
    String? postText,
    String? imgSrc,
  }) async {
    try {
      final userBriefs = await _briefsRemoteDataSource.postBrief(
        userId: userId,
        name: name,
        type: type,
        category: category,
        postText: postText,
        imgSrc: imgSrc,
      );
      return Right(userBriefs);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, ThreadImageModel>>? uploadThreadImage(String? fileName, MediaType fileType, String? userId, String? userType) async {
    try {
      final avatarModel = await _briefsRemoteDataSource.uploadThreadImage(fileName, fileType, userId, userType);
      return Right(avatarModel!);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>>? deleteBrief({String? briefId}) async {
    try {
      final isDeleted = await _briefsRemoteDataSource.deleteBrief(briefId: briefId);
      return Right(isDeleted);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>>? editBrief({String? briefId, bool? isVisible}) async {
    try {
      final editedBrief = await _briefsRemoteDataSource.editBrief(briefId: briefId, isVisible: isVisible);
      return Right(editedBrief);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }
}
