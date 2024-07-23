import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/app_utils/screen_size.dart';
import '../state_providers/briefs_state_provider.dart';

class CustomTabBar extends ConsumerStatefulWidget {
  const CustomTabBar({
    super.key,
    required this.tab1Text,
    required this.tab2Text,
    required this.onSelectedIndex,
    this.defaultSelectedIndex = 0,
  });

  final String tab1Text;
  final String tab2Text;
  final Function(int) onSelectedIndex;
  final int defaultSelectedIndex;

  @override
  ConsumerState<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends ConsumerState<CustomTabBar> with AutomaticKeepAliveClientMixin {
  late bool isTab1Pressed;
  late bool isTab2Pressed;

  @override
  void initState() {
    super.initState();
    isTab1Pressed = widget.defaultSelectedIndex == 0;
    isTab2Pressed = widget.defaultSelectedIndex == 1;
  }

  int getSelectedIndex() {
    if (isTab1Pressed) return 0;
    if (isTab2Pressed) return 1;
    return 0; // Default index
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<Offset> positions = [
      Offset(ScreenSize.width(context) * 0.015, 0), // Index 0
      Offset(ScreenSize.width(context) * 0.33, 0), // Index 1
    ];

    return Container(
      width: ScreenSize.width(context) * 0.7,
      height: ScreenSize.height(context) * 0.05,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceDim,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: ScreenSize.height(context) * 0.005,
            left: positions[getSelectedIndex()].dx,
            child: buildTabContainer(context, true),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _updateSelectedIndex(0);
                },
                child: buildTab(context, widget.tab1Text, isTab1Pressed),
              ),
              InkWell(
                onTap: () {
                  _updateSelectedIndex(1);
                },
                child: buildTab(context, widget.tab2Text, isTab2Pressed),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateSelectedIndex(int index) {
    setState(() {
      isTab1Pressed = index == 0;
      isTab2Pressed = index == 1;
    });

    widget.onSelectedIndex(index);
    ref.read(briefsTabIndexProvider.notifier).state = index; // Update the Riverpod state
  }

  Widget buildTab(BuildContext context, String tabText, bool isTabPressed) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: ScreenSize.width(context) * 0.32,
      height: ScreenSize.height(context) * 0.05,
      child: Center(
        child: Text(
          tabText,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: isTabPressed ? Colors.white : Theme.of(context).colorScheme.secondary,
                letterSpacing: 0.42,
              ),
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
        ),
      ),
    );
  }

  Widget buildTabContainer(BuildContext context, bool inset) {
    return Container(
      width: ScreenSize.width(context) * 0.35,
      height: ScreenSize.height(context) * 0.04,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-0.73, 0.68),
          end: Alignment(0.73, -0.68),
          colors: [Color(0xFF4A26FE), Color(0xFF222CFF)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
