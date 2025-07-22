import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common/app_utils/screen_size.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () async {
        await GoogleSignIn().signOut(); // Sign out from GoogleSignIn
        await FirebaseAuth.instance.signOut();
        GoRouter.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 50 * ScaleSize.textScaleFactor(context),
          padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
          child: Icon(
            CupertinoIcons.left_chevron,
            color: Theme.of(context).colorScheme.tertiaryContainer,
            size: 40 * ScaleSize.textScaleFactor(context),
          ),
        ),
      ),
    );
  }
}
