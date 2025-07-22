import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:uni_links2/uni_links.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../common/app_utils/screen_size.dart';
import '../../../common/others/assets.dart';
import '../../../common/others/strings.dart';
import '../../../data/core/api_client.dart';
import '../../../data/data_sources/contacts_data_source.dart';
import '../../../data/di/get_it.dart';
import '../../../data/models/contacts_model.dart';
import '../../../main.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/socket_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/bottom_nav_bar_state_provider.dart';
import '../messages/messages_screen_navigator.dart';
import '../my_feed/my_feed_navigator.dart';
import '../notification/notification_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = "/homeScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late PageController _pageController;
  int? notificationsBadge;
  // late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();

    ref.read(userAvatarNotifierProvider.notifier).loadUserAvatar();

    init();

    final currentIndex = ref.read(currentIndexProvider);
    _pageController = PageController(initialPage: currentIndex);

    // _setupUniLinks();
    getNotificationBadge();
    final socketService = ref.read(socketServiceProvider);
    socketService.connectSocket();

    socketService.socket.emit('welcome', {'room_id': socketService.socket.id});

    socketService.socket.on('welcome', (data) {
      log("SOCKET SERVICE WELCOME $data");
      String? roomId = data['room_id'];
      log("WELCOME ===> $roomId");
      final userData = ref.read(userDetailsProvider);
      socketService.socket.emit('add-user', {'user_id': userData['user_id'], 'room_id': roomId});
    });
  }

  void init() async {
    final apiClient = getItInstance<ApiClient>();

    // Ensure permissions are granted before calling the provider
    if (await Permission.contacts.isGranted != null || await Permission.contacts.isGranted == true) {
      var contactsBox = await Hive.box('contactsBox');

      // Safely cast the dynamic list to List<ContactsModel>
      final List<dynamic>? contactsDynamic = contactsBox.get('contacts');
      final List<ContactsModel> contacts = contactsDynamic?.cast<ContactsModel>() ?? [];

      // Send contacts
      await ContactDataSourceImpl(apiClient).sendContacts(contacts, context);
    } else {
      // Request permission if not granted
      await Permission.contacts.request();

      if (await Permission.contacts.isGranted != null || await Permission.contacts.isGranted == true) {
        var contactsBox = await Hive.box('contactsBox');

        // Safely cast the dynamic list to List<ContactsModel>
        final List<dynamic>? contactsDynamic = contactsBox.get('contacts');
        final List<ContactsModel> contacts = contactsDynamic?.cast<ContactsModel>() ?? [];

        // Send contacts
        await ContactDataSourceImpl(apiClient).sendContacts(contacts, context);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    // _sub.cancel();
    super.dispose();
  }

  void getNotificationBadge() async {
    // Fetch all notifications
    var notifications = await ref.read(NotificationProvider.getAllNotificationsProvider.future);

    // Filter notifications where element.isVisible is true
    var visibleNotifications = notifications.where((element) => element.isViewed != true).toList();

    // Update the badge count based on the visible notifications
    if (mounted) {
      setState(() {
        notificationsBadge = visibleNotifications.length;
      });
    }
  }

  // void _setupUniLinks() {
  //   _sub = uriLinkStream.listen((Uri? uri) {
  //     if (uri != null) {
  //       // Handle the deep link. For example, navigate to a specific screen.
  //       log('Received link: $uri');
  //       _handleIncomingLink(uri);
  //     }
  //   }, onError: (err) {
  //     log('Failed to receive link: $err');
  //   });
  // }

  void _handleIncomingLink(Uri uri) {
    // Example parsing logic, adjust based on your URL structure.
    if (uri.pathSegments.contains('discussion') && uri.pathSegments.contains('thread')) {
      // Navigate to a specific screen within your app
      final threadId = uri.pathSegments.last;
      // Navigate to the screen corresponding to the threadId
      // For example: Navigator.pushNamed(context, '/discussion/thread', arguments: threadId);
      log('Navigating to thread: $threadId');
    }
    // Add other cases as necessary
  }

  void onPageChanged(int index) {
    ref.read(currentIndexProvider.notifier).state = index;
  }

  void onTabTapped(int index) {
    _pageController.jumpToPage(index);
    ref.read(currentIndexProvider.notifier).state = index;
    if (index == 0) {
      ref.invalidate(briefsNotifierProvider);
      ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: 1);
    } else if (index == 1) {
      ref.invalidate(ChatProvider.getChatUsersListProvider);
    } else if (index == 2) {
      ref.invalidate(NotificationProvider.getAllNotificationsProvider);
      notificationsBadge = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentIndexProvider);
    var avatarPath = ref.watch(userAvatarNotifierProvider);
    if (avatarPath == null) {
      final avatarUrl = prefs!.getString('avatarUrl') ?? '';
      avatarPath = avatarUrl;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
                          height: 33 * ScaleSize.textScaleFactor(context),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Chat",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                    ],
                  )
                : Text(
                    currentIndex == 2 ? "Notifications" : "Profile",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                await showAdaptiveDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      content: Text(
                        Strings.logoutContent,
                        style: TextStyle(color: Colors.black),
                      ),
                      title: const Text(
                        Strings.logoutWarning,
                        style: TextStyle(color: Colors.black),
                      ),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            enableFeedback: true,
                          ),
                          onPressed: () {
                            context.pop(false);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            enableFeedback: true,
                          ),
                          onPressed: () async {
                            await AppUtility(context).handleLogout(context, prefs, ref, false);
                          },
                          child: Text(
                            'Logout',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MyFeedNavigator(homePageController: _pageController),
          const MessagesScreenNavigator(),
          NotificationScreen(notificationPageController: _pageController),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF4B26FD),
        unselectedItemColor: Colors.black,
        // selectedIconTheme: const CupertinoIconThemeData(color: Color(0xFF4B26FD)),
        selectedIconTheme: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
        // unselectedIconTheme: const CupertinoIconThemeData(color: Colors.black),
        unselectedIconTheme: Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        iconSize: 20 * ScaleSize.textScaleFactor(context),
        selectedFontSize: 12 * ScaleSize.textScaleFactor(context),
        unselectedFontSize: 12 * ScaleSize.textScaleFactor(context),
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list_fill),
            label: "My Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2_fill),
            // icon: Badge.count(
            //   count: 10,
            //   child: Icon(CupertinoIcons.chat_bubble_2_fill),
            // ),
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
            icon: notificationsBadge != null && notificationsBadge != 0
                ? Badge.count(
                    count: notificationsBadge!,
                    child: Icon(CupertinoIcons.bell_fill),
                  )
                : Icon(CupertinoIcons.bell_fill),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: avatarPath != null
                ? CircleAvatar(
                    radius: 12 * ScaleSize.textScaleFactor(context),
                    backgroundImage: avatarPath.startsWith('https://')
                        ? CachedNetworkImageProvider(
                            avatarPath,
                            cacheKey: avatarPath,
                          )
                        : Image.file(
                            File(avatarPath),
                            fit: BoxFit.cover,
                          ).image,
                    backgroundColor: Colors.white,
                  )
                : CircleAvatar(
                    radius: 12 * ScaleSize.textScaleFactor(context),
                    backgroundImage: null, // We will use a child instead
                    backgroundColor: currentIndex == 3 ? Color(0xFF4B26FD) : Colors.white,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        currentIndex == 3 ? Colors.white : Colors.black,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        Assets.PERSON,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
            // : CircleAvatar(
            //     radius: 12 * ScaleSize.textScaleFactor(context),
            //     backgroundImage: Image.asset(
            //       Assets.PERSON,
            //       fit: BoxFit.cover,
            //       colorBlendMode: BlendMode.color,
            //       color: currentIndex == 3 ? Colors.white : Colors.black,
            //     ).image,
            //     backgroundColor: currentIndex == 3 ? Color(0xFF4B26FD) : Colors.white,
            //   ),
            label: "Me",
          ),
        ],
      ),
    );
  }
}
