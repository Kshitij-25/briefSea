import 'package:flutter/material.dart';

import '../../common/screen_size.dart';
import '../widgets/custom_notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const routeName = "/notificationScreen";

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const CustomNotificationTile();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
