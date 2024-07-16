import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          height: 50,
          padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Color(0xFF01FFF5),
            size: 40,
          ),
        ),
      ),
    );
  }
}
