import 'package:briefsea/presentation/providers/notification_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/app_utils/screen_size.dart';
import '../state_providers/bottom_nav_bar_state_provider.dart';
import '../widgets/custom_notification_tile.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key, this.notificationPageController});

  final PageController? notificationPageController;

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
                        Text("No New Notifications"),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     TextButton(
                      //       style: const ButtonStyle(
                      //         overlayColor: WidgetStateColor.transparent,
                      //       ),
                      //       onPressed: () async {
                      //         await ref.read(deleteAllNotificationsProvider.future);
                      //         ref.invalidate(getAllNotificationsProvider);
                      //       },
                      //       child: const Text("Clear All"),
                      //     ),
                      //   ],
                      // ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: notification.length,
                          itemBuilder: (context, index) {
                            return CustomNotificationTile(
                              notificationModel: notification[index],
                              onTap: () async {
                                print("object");
                                if (notification[index].type == "message received") {
                                  ref.read(currentIndexProvider.notifier).state = 1;
                                  notificationPageController!.jumpToPage(1);
                                  await ref.read(
                                    deleteMessageNotificationProvider(conversationId: notification[index].conversationId).future,
                                  );
                                  ref.invalidate(getAllNotificationsProvider);
                                } else if (notification[index].type == "user account") {
                                  ref.read(currentIndexProvider.notifier).state = 0;
                                  notificationPageController!.jumpToPage(0);
                                  await ref.read(
                                    deleteNotificationProvider(notificationId: notification[index].notificationId).future,
                                  );
                                  ref.invalidate(getAllNotificationsProvider);
                                }
                              },
                              confirmDismiss: () async {
                                if (notification[index].type == "message received") {
                                  var isDeleted = await ref.read(
                                    deleteMessageNotificationProvider(conversationId: notification[index].conversationId).future,
                                  );
                                  ref.invalidate(getAllNotificationsProvider);
                                  return isDeleted;
                                } else {
                                  var isDeleted = ref.read(
                                    deleteNotificationProvider(notificationId: notification[index].notificationId).future,
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
