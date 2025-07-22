import 'package:briefsea/presentation/providers/notification_provider.dart';
import 'package:briefsea/presentation/screens/my_feed/feed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../data/core/app_error.dart';
import '../../../data/models/notification_model.dart';
import '../../state_providers/bottom_nav_bar_state_provider.dart';
import '../../widgets/custom_notification_tile.dart';

class NotificationScreen extends ConsumerWidget {
  NotificationScreen({super.key, this.notificationPageController});

  final PageController? notificationPageController;

  List<String> notificationIds = [];

  static const String routeName = "/notificationScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(
      NotificationProvider.getAllNotificationsProvider,
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            color: Theme.of(context).colorScheme.secondary,
          ),
          RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(NotificationProvider.getAllNotificationsProvider);
            },
            backgroundColor: Theme.of(context).colorScheme.surface,
            color: Theme.of(context).colorScheme.primary,
            child: Container(
              height: ScreenSize.height(context),
              width: ScreenSize.width(context),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: notifications.when(
                  data: (notifications) {
                    if (notifications.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.bell_solid,
                              size: 30 * ScaleSize.textScaleFactor(context),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(-0.73, 0.68),
                                  end: Alignment(0.73, -0.68),
                                  colors: [
                                    Color(0xFF4A26FE),
                                    Color(0xFF222CFF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'No New Notifications',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.42,
                                ),
                                textScaler: TextScaler.linear(
                                  ScaleSize.textScaleFactor(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      notificationIds = notifications
                          .where((notification) => !notification.isViewed!)
                          .map((notification) => notification.notificationId!)
                          .toList();
                      ref.read(
                        NotificationProvider.updateNotificationViewStatusProvider(
                          notificationIds,
                        ).future,
                      );
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                final notification = notifications[index];
                                return CustomNotificationTile(
                                  notificationModel: notification,
                                  onTap: () => _handleNotificationTap(
                                    context,
                                    ref,
                                    notification,
                                  ),
                                  confirmDismiss: () =>
                                      _handleConfirmDismiss(ref, notification),
                                  onDismissed: () => ref.invalidate(
                                    NotificationProvider
                                        .getAllNotificationsProvider,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    if (error is AppError) {
                      return Center(
                        child: Text(
                          error.errorMessage.toString(),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(color: Colors.black),
                        ),
                      );
                    }
                    return Center(child: Text('ERROR : ${error.toString()}'));
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _handleConfirmDismiss(WidgetRef ref, notification) async {
    if (notification.type == "message received") {
      final isDeleted = await ref.read(
        NotificationProvider.deleteMessageNotificationProvider(
          notification.conversationId,
        ).future,
      );
      ref.invalidate(NotificationProvider.getAllNotificationsProvider);
      return isDeleted;
    } else {
      final isDeleted = ref.read(
        NotificationProvider.deleteNotificationProvider(
          notification.notificationId,
        ).future,
      );
      ref.invalidate(NotificationProvider.getAllNotificationsProvider);
      return isDeleted;
    }
  }

  void _handleNotificationTap(
    BuildContext context,
    WidgetRef ref,
    NotificationModel notification,
  ) async {
    await ref.read(
      NotificationProvider.updateNotificationTapStatusProvider(
        notification.notificationId,
      ).future,
    );
    ref.invalidate(NotificationProvider.getAllNotificationsProvider);
    if (notification.type == "message received") {
      ref.read(currentIndexProvider.notifier).state = 1;
      notificationPageController!.jumpToPage(1);
      _deleteNotification(ref, notification.conversationId!);
    } else if (notification.type == "user account") {
      ref.read(currentIndexProvider.notifier).state = 0;
      notificationPageController!.jumpToPage(0);
      _deleteNotification(ref, notification.notificationId!);
    } else if (notification.type == 'brief comment' ||
        notification.type == 'brief liked') {
      context.pushNamed(
        FeedScreen.routeName,
        extra: {'briefId': notification.threadId},
      );
    }
  }

  void _deleteNotification(WidgetRef ref, String notificationId) {
    ref.read(
      NotificationProvider.deleteNotificationProvider(notificationId).future,
    );
    ref.invalidate(NotificationProvider.getAllNotificationsProvider);
  }
}
