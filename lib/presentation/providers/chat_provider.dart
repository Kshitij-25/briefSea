import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/chat_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/chat_user_model.dart';
import '../../data/repositories/chat_repository.dart';
import '../params/chat_params.dart';

class ChatProvider {
  static final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
    final apiClient = getItInstance<ApiClient>();
    return ChatRemoteDataSourceImpl(apiClient);
  });

  static final chatRepositoryProvider = Provider<ChatRepository>((ref) {
    final chatRemoteDataSource = ref.watch(chatRemoteDataSourceProvider);
    return ChatRepository(chatRemoteDataSource);
  });

  static final getChatUsersListProvider = FutureProvider.family.autoDispose<List<ChatUserModel>, String>((ref, userId) async {
    final chatRepository = ref.watch(chatRepositoryProvider);
    final eitherChatListOrError = await chatRepository.getChatUsersList(userId);
    return eitherChatListOrError.fold(
      (error) => throw error,
      (chatList) => chatList,
    );
  });

  static final createNewChatProvider = FutureProvider.family<bool, CreateNewChatParams>((ref, params) async {
    final chatRepository = ref.watch(chatRepositoryProvider);
    final eitherNewChatOrError = await chatRepository.createNewChat(params.senderId, params.receiverId);
    return eitherNewChatOrError.fold(
      (error) => throw error,
      (newChat) => newChat,
    );
  });

  static final getChatMessagesProvider = FutureProvider.family<void, String>((ref, conversationId) async {
    final chatRepository = ref.watch(chatRepositoryProvider);
    final eitherGetMessagesOrError = await chatRepository.getChatMessages(conversationId);
    eitherGetMessagesOrError.fold(
      (error) => throw error,
      (newChat) => print('Fetched messages: $newChat'),
    );
  });

  static final sendChatMessagesProvider = FutureProvider.family<bool, SendChatMessagesParams>((ref, params) async {
    final chatRepository = ref.watch(chatRepositoryProvider);
    final eitherSendMessageOrError = await chatRepository.sendChatMessage(
      senderId: params.senderId,
      receiverId: params.receiverId,
      conversationId: params.conversationId,
      messageText: params.messageText,
      typedAt: params.typedAt,
    );
    return eitherSendMessageOrError.fold(
      (error) => throw error,
      (newChat) => newChat,
    );
  });

  static final getDMUserProvider = FutureProvider.family<ChatUserModel, GetDMUserParams>((ref, params) async {
    final chatRepository = ref.watch(chatRepositoryProvider);
    final eitherDMUserOrError = await chatRepository.getDMUser(params.senderId, params.receiverId);
    return eitherDMUserOrError.fold(
      (error) => throw error,
      (user) => user,
    );
  });

  static final editMessageProvider = FutureProvider.family<bool, EditMessageParams>((ref, params) async {
    final chatRepository = ref.watch(chatRepositoryProvider);
    final eitherSendMessageOrError = await chatRepository.editMessage(
      conversationId: params.conversationId,
      messageText: params.messageText,
    );
    return eitherSendMessageOrError.fold(
      (error) => throw error,
      (newChat) => newChat,
    );
  });

  static final deleteMessageProvider = FutureProvider.family<bool, String?>((ref, messageId) async {
    final chatRepository = ref.watch(chatRepositoryProvider);
    final eitherDMUserOrError = await chatRepository.deleteMessage(messageId: messageId);
    return eitherDMUserOrError.fold(
      (error) => throw error,
      (user) => user,
    );
  });
}
