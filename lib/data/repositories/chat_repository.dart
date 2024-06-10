import 'dart:io';

import 'package:briefsea/data/data_sources/chat_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import '../core/app_error.dart';
import '../models/chat_user_model.dart';

class ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;

  ChatRepository(this._chatRemoteDataSource);

  Future<Either<AppError, List<ChatUserModel>>> getChatUsersList(userId) async {
    try {
      final allChatUsers = await _chatRemoteDataSource.getChatUsersList(userId);
      return Right(allChatUsers);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, bool>> createNewChat(dynamic senderId, dynamic receiverId) async {
    try {
      final newChat = await _chatRemoteDataSource.createNewChat(senderId, receiverId);
      return Right(newChat);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
