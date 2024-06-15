import 'package:briefsea/data/data_sources/notification_remote_data_source.dart';
import 'package:briefsea/data/models/notification_model.dart';
import 'package:dartz/dartz.dart';

import '../core/app_error.dart';

class NotificationRepository {
  final NotificationRemoteDataSource _notificationRemoteDataSource;

  NotificationRepository(this._notificationRemoteDataSource);

  Future<Either<AppError, void>>? postNewNotification(Map<String, dynamic> requestBody, bool isNewRegister) async {
    try {
      final postNotification = await _notificationRemoteDataSource.postNewNotification(requestBody, isNewRegister);
      return Right(postNotification);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, List<NotificationModel>>>? getAllNotifications() async {
    try {
      final allNotifications = await _notificationRemoteDataSource.getAllNotifications();
      return Right(allNotifications);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>>? deleteAllNotifications() async {
    try {
      final allNotifications = await _notificationRemoteDataSource.deleteAllNotifications();
      return Right(allNotifications);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>>? deleteMessageNotification(String? conversationId) async {
    try {
      final allNotifications = await _notificationRemoteDataSource.deleteMessageNotification(conversationId);
      return Right(allNotifications);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }

  Future<Either<AppError, bool>>? deleteNotification(String? notificationId) async {
    try {
      final allNotifications = await _notificationRemoteDataSource.deleteNotification(notificationId);
      return Right(allNotifications);
    } on AppError catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(AppError(errorMessage: e.toString()));
    }
  }
}
