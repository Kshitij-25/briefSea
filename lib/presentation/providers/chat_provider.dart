import 'package:briefsea/data/data_sources/chat_remote_data_source.dart';
import 'package:briefsea/data/repositories/chat_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/core/api_client.dart';
import '../../data/di/get_it.dart';
import '../../data/models/chat_message_model.dart';
import '../../data/models/chat_user_model.dart';

part 'chat_provider.g.dart';

@riverpod
ChatRemoteDataSource chatRemoteDataSource(ChatRemoteDataSourceRef ref) {
  final apiClient = getItInstance<ApiClient>();
  return ChatRemoteDataSourceImpl(apiClient);
}

@riverpod
ChatRepository chatRepository(ChatRepositoryRef ref) {
  final chatRemoteDataSource = ref.read(chatRemoteDataSourceProvider);
  return ChatRepository(chatRemoteDataSource);
}

@riverpod
Future<List<ChatUserModel>> getChatUsersList(GetChatUsersListRef ref, {required String userId}) async {
  final chatRepository = ref.watch(chatRepositoryProvider);
  final eitherChatListOrError = await chatRepository.getChatUsersList(userId);
  return eitherChatListOrError.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (chatList) => chatList,
  );
}

@riverpod
Future<bool> createNewChat(CreateNewChatRef ref, {required String senderId, required String receiverId}) async {
  final chatRepository = ref.watch(chatRepositoryProvider);
  final eitherNewChatOrError = await chatRepository.createNewChat(senderId, receiverId);
  return eitherNewChatOrError.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (newChat) => newChat,
  );
}

@riverpod
Future<List<ChatMessageModel>> getChatMessages(GetChatMessagesRef ref, {required String conversationId}) async {
  final chatRepository = ref.watch(chatRepositoryProvider);
  final eitherGetMessagesOrError = await chatRepository.getChatMessages(conversationId);
  return eitherGetMessagesOrError.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (newChat) => newChat,
  );
}

@riverpod
Future<bool> sendChatMessages(SendChatMessagesRef ref,
    {required String senderId,
    required String receiverId,
    required String conversationId,
    required String messageText,
    required String typedAt}) async {
  final chatRepository = ref.watch(chatRepositoryProvider);
  final eitherSendMessageOrError = await chatRepository.sendChatMessage(
    senderId: senderId,
    receiverId: receiverId,
    conversationId: conversationId,
    messageText: messageText,
    typedAt: typedAt,
  );
  return eitherSendMessageOrError.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (newChat) => newChat,
  );
}
