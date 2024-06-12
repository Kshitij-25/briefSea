import 'dart:io';

import 'package:dartz/dartz.dart';

import '../core/app_error.dart';
import '../data_sources/chat_remote_data_source.dart';
import '../models/chat_message_model.dart';
import '../models/chat_user_model.dart';

class ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;

  ChatRepository(this._chatRemoteDataSource);

  Future<Either<AppError, List<ChatUserModel>>> getChatUsersList(String? userId) async {
    try {
      final allChatUsers = await _chatRemoteDataSource.getChatUsersList(userId);
      return Right(allChatUsers);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, bool>> createNewChat(String? senderId, String? receiverId) async {
    try {
      final newChat = await _chatRemoteDataSource.createNewChat(senderId, receiverId);
      return Right(newChat);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, List<ChatMessageModel>>> getChatMessages(String? conversationId) async {
    try {
      final chatMessages = await _chatRemoteDataSource.getChatMessages(conversationId);
      return Right(chatMessages);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  Future<Either<AppError, bool>> sendChatMessage(
      {String? senderId, String? receiverId, String? conversationId, String? messageText, String? typedAt}) async {
    try {
      final sendMessage = await _chatRemoteDataSource.sendChatMessage(
        senderId: senderId,
        receiverId: receiverId,
        conversationId: conversationId,
        messageText: messageText,
        typedAt: typedAt,
      );
      return Right(sendMessage);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
