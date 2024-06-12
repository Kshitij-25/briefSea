import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/screen_size.dart';
import '../state_providers/bottom_nav_bar_state_provider.dart';
import 'messages/messages_screen_navigator.dart';
import 'my_feed/my_feed_navigator.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const routeName = "/homeScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final pageController = PageController(initialPage: currentIndex);

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
        title: Text(
          currentIndex == 0
              ? "Briefsea"
              : currentIndex == 1
                  ? "Messages"
                  : currentIndex == 2
                      ? "Notifications"
                      : "Profile",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       CupertinoIcons.search,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          MyFeedNavigator(),
          MessagesScreenNavigator(),
          NotificationScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF4B26FD),
        unselectedItemColor: Colors.black,
        selectedIconTheme: const CupertinoIconThemeData(color: Color(0xFF4B26FD)),
        unselectedIconTheme: const CupertinoIconThemeData(color: Colors.black),
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list_fill),
            label: "My Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.envelope_open_fill),
            label: "Messages",
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
