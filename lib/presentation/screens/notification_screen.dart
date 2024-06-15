import 'package:briefsea/presentation/providers/notification_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/screen_size.dart';
import '../widgets/custom_notification_tile.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  static const routeName = "/notificationScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allNotifications = ref.watch(getAllNotificationsProvider);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            color: const Color(0xFF4B26FD),
          ),
          Container(
            height: ScreenSize.height(context),
            width: ScreenSize.width(context),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: allNotifications.when(
                data: (notification) {
                  if (notification.isEmpty) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.bell_solid),
                        Text("No Notifications"),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await ref.read(deleteAllNotificationsProvider.future);
                              ref.invalidate(getAllNotificationsProvider);
                            },
                            child: const Text("Clear All"),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: notification.length,
                          itemBuilder: (context, index) {
                            final reversedIndex = notification.length - 1 - index;
                            return CustomNotificationTile(
                              notificationModel: notification[reversedIndex],
                              confirmDismiss: () async {
                                if (notification[reversedIndex].type == "message received") {
                                  var isDeleted = await ref.read(
                                    deleteMessageNotificationProvider(conversationId: notification[reversedIndex].conversationId).future,
                                  );
                                  ref.invalidate(getAllNotificationsProvider);
                                  return isDeleted;
                                } else {
                                  var isDeleted = ref.read(
                                    deleteNotificationProvider(notificationId: notification[reversedIndex].notificationId).future,
                                  );
                                  ref.invalidate(getAllNotificationsProvider);
                                  return isDeleted;
                                }
                              },
                              onDismissed: () => ref.invalidate(getAllNotificationsProvider),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return Center(child: Text('Error: $error'));
                },
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
