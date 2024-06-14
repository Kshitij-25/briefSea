import 'package:briefsea/data/models/notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/notification_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/repositories/notification_repository.dart';

part 'notification_provider.g.dart';

@riverpod
NotificationRemoteDataSource notificationRemoteDataSource(NotificationRemoteDataSourceRef ref) {
  final apiClient = getItInstance<ApiClient>();
  return NotificationRemoteDataSourceImpl(apiClient);
}

@riverpod
NotificationRepository notificationRepository(NotificationRepositoryRef ref) {
  final notificationRemoteDataSource = ref.watch(notificationRemoteDataSourceProvider);
  return NotificationRepository(notificationRemoteDataSource);
}

@riverpod
Future<void> postNewNotification(PostNewNotificationRef ref, {required Map<String, dynamic> requestBody, bool isNewRegister = false}) async {
  final notificationRepository = ref.watch(notificationRepositoryProvider);
  final eitherNotifcationOrError = await notificationRepository.postNewNotification(requestBody, isNewRegister);
  return eitherNotifcationOrError!.fold((error) => throw error, (notification) async {
    // final updatedBriefs = await Future.wait(briefs!.map((brief) async {
    //   final likedModel = await ref.watch(getALikeProvider(threadId: brief!.id).future);
    //   return brief.copyWith(
    //     isPostLiked: likedModel.likeId != null,
    //     postLikeId: likedModel.likeId,
    //   );
    // }).toList());
    return notification;
  });
}

@riverpod
Future<List<NotificationModel>> getAllNotifications(GetAllNotificationsRef ref) async {
  final notificationRepository = ref.watch(notificationRepositoryProvider);
  final eitherAllNotificationsOrError = await notificationRepository.getAllNotifications();
  return eitherAllNotificationsOrError!.fold(
    (error) => throw error,
    (allNotifications) => allNotifications,
  );
}

@riverpod
Future<bool> deleteAllNotifications(DeleteAllNotificationsRef ref) async {
  final notificationRepository = ref.watch(notificationRepositoryProvider);
  final eitherAllNotificationsOrError = await notificationRepository.deleteAllNotifications();
  return eitherAllNotificationsOrError!.fold(
    (error) => throw error,
    (allNotifications) => allNotifications,
  );
}

@riverpod
Future<bool> deleteMessageNotification(DeleteMessageNotificationRef ref, {required String? conversationId}) async {
  final notificationRepository = ref.watch(notificationRepositoryProvider);
  final eitherAllNotificationsOrError = await notificationRepository.deleteMessageNotification(conversationId);
  return eitherAllNotificationsOrError!.fold(
    (error) => throw error,
    (allNotifications) => allNotifications,
  );
}

@riverpod
Future<bool> deleteNotification(DeleteNotificationRef ref, {required String? notificationId}) async {
  final notificationRepository = ref.watch(notificationRepositoryProvider);
  final eitherAllNotificationsOrError = await notificationRepository.deleteNotification(notificationId);
  return eitherAllNotificationsOrError!.fold(
    (error) => throw error,
    (allNotifications) => allNotifications,
  );
}
