import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/notification_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/notification_model.dart';
import '../../data/repositories/notification_repository.dart';
import '../params/notification_params.dart';

class NotificationProvider {
  static final notificationRemoteDataSourceProvider = Provider<NotificationRemoteDataSource>((ref) {
    final apiClient = getItInstance<ApiClient>();
    return NotificationRemoteDataSourceImpl(apiClient);
  });

  static final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
    final notificationRemoteDataSource = ref.watch(notificationRemoteDataSourceProvider);
    return NotificationRepository(notificationRemoteDataSource);
  });

  static final postNewNotificationProvider = FutureProvider.family<void, PostNewNotificationParams>((ref, params) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final eitherNotificationOrError = await notificationRepository.postNewNotification(
      params.requestBody,
      params.isNewRegister,
    );
    return eitherNotificationOrError!.fold(
      (error) => throw error,
      (notification) async => notification,
    );
  });

  static final briefLikeNotificationProvider = FutureProvider.family<void, NotificationParams>((ref, params) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final eitherNotificationOrError = await notificationRepository.briefLikeNotification(
      likeId: params.likeId,
      threadId: params.threadId,
      receiverId: params.receiverId,
      briefText: params.briefText,
    );
    return eitherNotificationOrError!.fold(
      (error) => throw error,
      (notification) async => notification,
    );
  });

  static final commentLikeNotificationProvider = FutureProvider.family<void, NotificationParams>((ref, params) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final eitherNotificationOrError = await notificationRepository.commentLikeNotification(
      commentId: params.commentId,
      threadId: params.threadId,
      receiverId: params.receiverId,
      commentText: params.commentText,
      likeId: params.likeId,
    );
    return eitherNotificationOrError!.fold(
      (error) => throw error,
      (notification) async => notification,
    );
  });

  static final commentNotificationProvider = FutureProvider.family<void, NotificationParams>((ref, params) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final eitherNotificationOrError = await notificationRepository.commentNotification(
      threadId: params.threadId,
      receiverId: params.receiverId,
    );
    return eitherNotificationOrError!.fold(
      (error) => throw error,
      (notification) async => notification,
    );
  });

  static final replyNotificationProvider = FutureProvider.family<void, NotificationParams>((ref, params) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final eitherNotificationOrError = await notificationRepository.replyNotification(
      commentId: params.commentId,
      receiverId: params.receiverId,
      threadId: params.threadId,
    );
    return eitherNotificationOrError!.fold(
      (error) => throw error,
      (notification) async => notification,
    );
  });

  static final getAllNotificationsProvider = FutureProvider.autoDispose<List<NotificationModel>>((ref) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final eitherAllNotificationsOrError = await notificationRepository.getAllNotifications();
    return eitherAllNotificationsOrError!.fold(
      (error) => throw error,
      (allNotifications) => allNotifications,
    );
  });

  static final deleteAllNotificationsProvider = FutureProvider<bool>((ref) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final eitherAllNotificationsOrError = await notificationRepository.deleteAllNotifications();
    return eitherAllNotificationsOrError!.fold(
      (error) => throw error,
      (allNotifications) => allNotifications,
    );
  });

  static final deleteMessageNotificationProvider = FutureProvider.family<bool, String?>((ref, conversationId) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final eitherAllNotificationsOrError = await notificationRepository.deleteMessageNotification(conversationId);
    return eitherAllNotificationsOrError!.fold(
      (error) => throw error,
      (allNotifications) => allNotifications,
    );
  });

  static final deleteNotificationProvider = FutureProvider.family<bool, String?>((ref, notificationId) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final eitherAllNotificationsOrError = await notificationRepository.deleteNotification(notificationId);
    return eitherAllNotificationsOrError!.fold(
      (error) => throw error,
      (allNotifications) => allNotifications,
    );
  });

  static final updateNotificationViewStatusProvider = FutureProvider.family<void, List<String>?>((ref, notificationId) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    await notificationRepository.updateNotificationViewStatus(notificationId!);
  });

  static final updateNotificationTapStatusProvider = FutureProvider.family<void, String?>((ref, notificationId) async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    await notificationRepository.updateNotificationTapStatus(notificationId!);
  });
}
