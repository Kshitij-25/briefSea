import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/screens/auth_screens/welcome_screen.dart';
import '../../presentation/state_providers/bottom_nav_bar_state_provider.dart';

class AppUtility {
  final BuildContext context;

  AppUtility(this.context);

  ThemeData get _theme => Theme.of(context);

  TextTheme get _styles => _theme.textTheme;

  ColorScheme get _scheme => _theme.colorScheme;

  void error(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$e",
          style: _styles.bodyLarge!.copyWith(
            color: _scheme.onErrorContainer,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _scheme.errorContainer,
      ),
    );
  }

  void message(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$e",
          style: _styles.bodyLarge!.copyWith(
            color: _scheme.onTertiaryContainer,
          ),
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _scheme.onPrimary,
      ),
    );
  }

  Future<void> handleLogout(BuildContext context, SharedPreferences? prefs, WidgetRef ref, bool isDelete) async {
    try {
      if (prefs != null) {
        await prefs.setBool('isLogin', false);
        await prefs.clear();
        await GoogleSignIn().signOut(); // Sign out from GoogleSignIn
        await FirebaseAuth.instance.signOut();
        context.pushReplacementNamed(WelcomeScreen.routeName);
        AppUtility(context).message(!isDelete ? 'Logout Successful' : 'Account Deleted');
        ref.read(currentIndexProvider.notifier).state = 0;
      } else {
        AppUtility(context).message('Error: Shared preferences not initialized');
      }
    } catch (e) {
      AppUtility(context).message('Error during logout: $e');
    }
  }
}
