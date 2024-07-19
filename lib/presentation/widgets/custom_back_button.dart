import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/app_utils/screen_size.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () {
        GoRouter.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 50 * ScaleSize.textScaleFactor(context),
          padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
          child: Icon(
            CupertinoIcons.left_chevron,
            color: Color(0xFF01FFF5),
            size: 40 * ScaleSize.textScaleFactor(context),
          ),
        ),
      ),
    );
  }
}
