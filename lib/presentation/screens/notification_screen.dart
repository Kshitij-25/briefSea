import 'package:briefsea/presentation/providers/notification_provider.dart';
import 'package:briefsea/presentation/screens/my_feed/feed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/app_utils/screen_size.dart';
import '../../data/core/app_error.dart';
import '../state_providers/bottom_nav_bar_state_provider.dart';
import '../widgets/custom_notification_tile.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key, this.notificationPageController});

  final PageController? notificationPageController;

  static const routeName = "/notificationScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allNotifications = ref.watch(NotificationProvider.getAllNotificationsProvider);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Container(
            height: ScreenSize.height(context),
            width: ScreenSize.width(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: allNotifications.when(
                data: (notification) {
                  if (notification.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.bell_solid,
                          size: 30 * ScaleSize.textScaleFactor(context),
                        ),
                        SizedBox(
                          height: 20 * ScaleSize.textScaleFactor(context),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(-0.73, 0.68),
                              end: Alignment(0.73, -0.68),
                              colors: [Color(0xFF4A26FE), Color(0xFF222CFF)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'No New Notifications',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.42,
                              ),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                            ),
                          ),
                        ),
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
                                print(notification[index].type.toString() + "object");
                                if (notification[index].type == "message received") {
                                  ref.read(currentIndexProvider.notifier).state = 1;
                                  notificationPageController!.jumpToPage(1);
                                  await ref.read(
                                    NotificationProvider.deleteMessageNotificationProvider(notification[index].conversationId).future,
                                  );
                                  ref.invalidate(NotificationProvider.getAllNotificationsProvider);
                                } else if (notification[index].type == "user account") {
                                  ref.read(currentIndexProvider.notifier).state = 0;
                                  notificationPageController!.jumpToPage(0);
                                  await ref.read(
                                    NotificationProvider.deleteNotificationProvider(notification[index].notificationId).future,
                                  );
                                  ref.invalidate(NotificationProvider.getAllNotificationsProvider);
                                } else if (notification[index].type == 'brief comment') {
                                  context.pushNamed(
                                    FeedScreen.routeName,
                                    extra: {'briefId': notification[index].threadId},
                                  );
                                } else if (notification[index].type == 'brief liked') {
                                  context.pushNamed(
                                    FeedScreen.routeName,
                                    extra: {'briefId': notification[index].threadId},
                                  );
                                }
                              },
                              confirmDismiss: () async {
                                if (notification[index].type == "message received") {
                                  var isDeleted = await ref.read(
                                    NotificationProvider.deleteMessageNotificationProvider(notification[index].conversationId).future,
                                  );
                                  ref.invalidate(NotificationProvider.getAllNotificationsProvider);
                                  return isDeleted;
                                } else {
                                  var isDeleted = ref.read(
                                    NotificationProvider.deleteNotificationProvider(notification[index].notificationId).future,
                                  );
                                  ref.invalidate(NotificationProvider.getAllNotificationsProvider);
                                  return isDeleted;
                                }
                              },
                              onDismissed: () => ref.invalidate(NotificationProvider.getAllNotificationsProvider),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  if (error is AppError) {
                    return Center(
                      child: Text(
                        error.errorMessage.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                      ),
                    );
                  }
                  return Center(
                    child: Text('ERROR : ${error.toString()}'),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
