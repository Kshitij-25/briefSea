import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/screen_size.dart';
import '../../state_providers/briefs_state_provider.dart';
import '../../widgets/custom_tab_bar.dart';
import '../../widgets/post_brief_modal_sheet.dart';
import 'all_briefs_screen.dart';
import 'my_briefs_screen.dart';

class MyFeedNavigator extends ConsumerWidget {
  const MyFeedNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(briefsTabIndexProvider);
    final pageController = PageController(initialPage: currentIndex);

    // final allBriefs = ref.watch(getAllBriefsProvider);
    // final userBriefs = ref.watch(getUserBriefsProvider);

    void onPageChanged(int index) {
      ref.read(briefsTabIndexProvider.notifier).state = index;
    }

    void onTabTapped(int index) {
      pageController.jumpToPage(index);
      ref.read(briefsTabIndexProvider.notifier).state = index;
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 70,
          color: const Color(0xFF4B26FD),
        ),
        Container(
          height: ScreenSize.height(context),
          width: ScreenSize.width(context),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.grey[300]!,
          ),
          child: Column(
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    stops: const [0.1, 0.9],
                    colors: [
                      Colors.white,
                      Colors.grey[300]!,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: CustomTabBar(
                        tab1Text: "All Briefs",
                        tab2Text: "My Briefs",
                        onSelectedIndex: (p0) {
                          onTabTapped(p0);
                        },
                      ),
                    ),
                    PostBriefModalSheet(),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    AllBriefsScreen(),
                    MyBriefsScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
