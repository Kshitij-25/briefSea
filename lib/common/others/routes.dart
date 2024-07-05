import 'package:go_router/go_router.dart';

import '../../data/models/chat_user_model.dart';
import '../../data/models/user_profile_model.dart';
import '../../main.dart';
import '../../presentation/screens/auth_screens/agency_register_screen.dart';
import '../../presentation/screens/auth_screens/existing_login_screen.dart';
import '../../presentation/screens/auth_screens/freelancer_register_screen.dart';
import '../../presentation/screens/auth_screens/otp_screen.dart';
import '../../presentation/screens/auth_screens/professional_register_screen.dart';
import '../../presentation/screens/auth_screens/verify_profile_screen.dart';
import '../../presentation/screens/auth_screens/welcome_screen.dart';
import '../../presentation/screens/edit_profile_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/messages/chat_screen.dart';
import '../../presentation/screens/messages/messages_screen_navigator.dart';
import '../../presentation/screens/my_feed/feed_screen.dart';
import '../../presentation/screens/notification_screen.dart';
import '../../presentation/screens/profile_screen.dart';

class AppRouter {
  AppRouter._();
  static final router = GoRouter(
    initialLocation: getInitialRoute(),
    routes: [
      GoRoute(
        path: WelcomeScreen.routeName,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AgencyRegisterScreen.routeName,
        builder: (context, state) => AgencyRegisterScreen(),
      ),
      GoRoute(
        path: FreelancerRegisterScreen.routeName,
        builder: (context, state) => FreelancerRegisterScreen(),
      ),
      GoRoute(
        path: ProfessionalRegisterScreen.routeName,
        builder: (context, state) => ProfessionalRegisterScreen(),
      ),
      GoRoute(
        path: ExistingLoginScreen.routeName,
        builder: (context, state) => ExistingLoginScreen(),
      ),
      GoRoute(
        path: ProfileScreen.routeName,
        builder: (context, state) {
          final Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
          final bool isOtherProfile = extras['isOtherProfile'];
          final String otherUserId = extras['otherUserId'] ?? "";
          return ProfileScreen(isOtherProfile: isOtherProfile, otherUserId: otherUserId);
        },
      ),
      GoRoute(
        path: OtpScreen.routeName,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: VerifyProfileScreen.routeName,
        builder: (context, state) => VerifyProfileScreen(),
      ),
      GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: MessagesScreenNavigator.routeName,
        builder: (context, state) => const MessagesScreenNavigator(),
      ),
      GoRoute(
        path: NotificationScreen.routeName,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: ChatScreen.routeName,
        builder: (context, state) => ChatScreen(
          chatUser: state.extra as ChatUserModel,
        ),
      ),
      GoRoute(
        path: FeedScreen.routeName,
        builder: (context, state) {
          final Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
          final String? briefId = extras['briefId'] ?? "";
          return FeedScreen(briefId: briefId);
        },
      ),
      GoRoute(
        path: EditProfileScreen.routeName,
        builder: (context, state) => EditProfileScreen(
          userProfileModel: state.extra as UserProfileModel,
        ),
      ),
    ],
  );

  static String getInitialRoute() {
    bool isLogin = prefs!.getBool('isLogin') ?? false;
    bool profile = prefs!.getBool('profile') ?? false;

    if (!isLogin) {
      return WelcomeScreen.routeName;
    } else if (!profile) {
      return WelcomeScreen.routeName;
    } else {
      return HomeScreen.routeName;
    }
  }
}
