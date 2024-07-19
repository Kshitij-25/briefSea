import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/app_utils/app_utility.dart';
import '../../common/app_utils/screen_size.dart';
import '../../common/others/assets.dart';
import '../../main.dart';
import '../providers/auth_provider.dart';
import '../providers/socket_provider.dart';
import '../state_providers/bottom_nav_bar_state_provider.dart';
import 'messages/messages_screen_navigator.dart';
import 'my_feed/my_feed_navigator.dart';
import 'notification_screen.dart';
import 'profile/profile_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const routeName = "/homeScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final pageController = PageController(initialPage: currentIndex);

    final userData = ref.watch(userDetailsProvider);

    final socketService = ref.read(socketServiceProvider);
    socketService.connectSocket();

    socketService.socket.emit('welcome', {'room_id': socketService.socket.id});

    socketService.socket.on('welcome', (data) {
      log("SOCKET SERVICE WELCOME $data");
      String? roomId = data['room_id'];
      log("WELCOME ===> $roomId");
      socketService.socket.emit('add-user', {'user_id': userData['user_id'], 'room_id': roomId});
    });

    void onPageChanged(int index) {
      ref.read(currentIndexProvider.notifier).state = index;
    }

    void onTabTapped(int index) {
      pageController.jumpToPage(index);
      ref.read(currentIndexProvider.notifier).state = index;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B26FD),
        title: currentIndex == 0
            ? Padding(
                padding: EdgeInsets.only(bottom: 10 * ScaleSize.textScaleFactor(context)),
                child: Image.asset(
                  Assets.APP_LOGO,
                  height: 150 * ScaleSize.textScaleFactor(context),
                  color: Colors.white,
                ),
              )
            : currentIndex == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Image.asset(
                          Assets.logoSmall,
                          height: 35 * ScaleSize.textScaleFactor(context),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Chat",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                    ],
                  )
                : Text(
                    currentIndex == 2 ? "Notifications" : "Profile",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  ),
        centerTitle: true,
        elevation: 0,
        leadingWidth: ScreenSize.width(context) * 0.3,
        // leading: Row(
        //   children: [
        //     IconButton(
        //       icon: const Icon(
        //         CupertinoIcons.person_add_solid,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {},
        //     ),
        //     // IconButton(
        //     //   icon: const Icon(
        //     //     CupertinoIcons.envelope_open_fill,
        //     //     color: Colors.white,
        //     //   ),
        //     //   onPressed: () {
        //     //     context.push(MessagesScreen.routeName);
        //     //   },
        //     // )
        //   ],
        // ),
        actions: [
          if (currentIndex == 3)
            IconButton(
              enableFeedback: true,
              tooltip: "Logout",
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                size: 20 * ScaleSize.textScaleFactor(context),
              ),
              onPressed: () async {
                await AppUtility(context).handleLogout(context, prefs, ref, false);
              },
            )
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MyFeedNavigator(homePageController: pageController),
          const MessagesScreenNavigator(),
          NotificationScreen(notificationPageController: pageController),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF4B26FD),
        unselectedItemColor: Colors.black,
        selectedIconTheme: const CupertinoIconThemeData(color: Color(0xFF4B26FD)),
        unselectedIconTheme: const CupertinoIconThemeData(color: Colors.black),
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        iconSize: 20 * ScaleSize.textScaleFactor(context),
        selectedFontSize: 12 * ScaleSize.textScaleFactor(context),
        unselectedFontSize: 12 * ScaleSize.textScaleFactor(context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list_fill),
            label: "My Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.envelope_open_fill),
            label: "Chat",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.person_3_fill),
          //   label: "Bowls",
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.bag_fill),
          //   label: "My Company",
          // ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_alt_circle),
            label: "Me",
          ),
        ],
      ),
    );
  }
}
