import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../state_providers/messages_state_provider.dart';
import 'inbox_screen.dart';

class MessagesScreenNavigator extends ConsumerWidget {
  const MessagesScreenNavigator({super.key});

  static const routeName = "/messagesScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(messageTabIndexProvider);
    final pageController = PageController(initialPage: currentIndex);

    void onPageChanged(int index) {
      ref.read(messageTabIndexProvider.notifier).state = index;
    }

    void onTabTapped(int index) {
      pageController.jumpToPage(index);
      ref.read(messageTabIndexProvider.notifier).state = index;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: const Color(0xFF4B26FD),
        //   title: const Text(
        //     "Messages",
        //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        //   ),
        //   centerTitle: true,
        //   elevation: 0,
        //   iconTheme: const CupertinoIconThemeData(color: Colors.white),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(
        //         CupertinoIcons.checkmark_alt,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {},
        //     )
        //   ],
        // ),
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
              child: Column(
                children: [
                  // Container(
                  //   // height: 170,
                  //   decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.only(
                  //       topLeft: Radius.circular(40),
                  //       topRight: Radius.circular(40),
                  //     ),
                  //     gradient: LinearGradient(
                  //       begin: FractionalOffset.topCenter,
                  //       end: FractionalOffset.bottomCenter,
                  //       stops: const [0.1, 0.9],
                  //       colors: [
                  //         Colors.white,
                  //         Colors.grey[300]!,
                  //       ],
                  //     ),
                  //   ),
                  //   child: const Column(
                  //     children: [
                  //       // Padding(
                  //       //   padding: const EdgeInsets.all(25.0),
                  //       //   child: CustomTabBar(
                  //       //     tab1Text: "Inbox",
                  //       //     tab2Text: "Sent",
                  //       //     onSelectedIndex: (p0) {
                  //       //       onTabTapped(p0);
                  //       //     },
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      onPageChanged: onPageChanged,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        InboxScreen(),
                        // SentScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
