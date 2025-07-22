import 'package:go_router/go_router.dart';

import '../../data/models/briefs_result.dart';
import '../../data/models/chat_user_model.dart';
import '../../data/models/comment_model.dart';
import '../../data/models/user_profile_model.dart';
import '../../main.dart';
import '../../presentation/screens/auth_screens/agency_register_screen.dart';
import '../../presentation/screens/auth_screens/choose_account_type.dart';
import '../../presentation/screens/auth_screens/existing_login_screen.dart';
import '../../presentation/screens/auth_screens/freelancer_register_screen.dart';
import '../../presentation/screens/auth_screens/otp_screen.dart';
import '../../presentation/screens/auth_screens/professional_register_screen.dart';
import '../../presentation/screens/auth_screens/welcome_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/messages/chat_screen.dart';
import '../../presentation/screens/messages/messages_screen_navigator.dart';
import '../../presentation/screens/my_feed/feed_screen.dart';
import '../../presentation/screens/my_feed/reply_screen.dart';
import '../../presentation/screens/notification/notification_screen.dart';
import '../../presentation/screens/profile/edit_profile_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/profile/verify_profile_screen.dart';
import '../../presentation/screens/terms_and_privacy/terms_and_privacy_view.dart';

class AppRouter {
  AppRouter._();
  static final router = GoRouter(
    initialLocation: getInitialRoute(),
    routes: [
      GoRoute(
        name: WelcomeScreen.routeName,
        path: WelcomeScreen.routeName,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        name: AgencyRegistrationScreen.routeName,
        path: AgencyRegistrationScreen.routeName,
        builder: (context, state) => AgencyRegistrationScreen(),
      ),
      GoRoute(
        name: FreelancerRegisterScreen.routeName,
        path: FreelancerRegisterScreen.routeName,
        builder: (context, state) => FreelancerRegisterScreen(),
      ),
      GoRoute(
        name: ChooseAccountType.routeName,
        path: ChooseAccountType.routeName,
        builder: (context, state) => ChooseAccountType(),
      ),
      GoRoute(
        name: ProfessionalRegisterScreen.routeName,
        path: ProfessionalRegisterScreen.routeName,
        builder: (context, state) => ProfessionalRegisterScreen(),
      ),
      GoRoute(
        name: ExistingLoginScreen.routeName,
        path: ExistingLoginScreen.routeName,
        builder: (context, state) => ExistingLoginScreen(),
      ),
      GoRoute(
        name: ProfileScreen.routeName,
        path: ProfileScreen.routeName,
        builder: (context, state) {
          final extras = state.extra! as Map<String, dynamic>;
          final isOtherProfile = extras['isOtherProfile'] as bool;
          final otherUserId = extras['otherUserId'] ?? '';
          return ProfileScreen(isOtherProfile: isOtherProfile, otherUserId: otherUserId.toString());
        },
      ),
      GoRoute(
        name: OtpScreen.routeName,
        path: OtpScreen.routeName,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        name: VerifyProfileScreen.routeName,
        path: VerifyProfileScreen.routeName,
        builder: (context, state) => VerifyProfileScreen(),
      ),
      GoRoute(
        name: HomeScreen.routeName,
        path: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: MessagesScreenNavigator.routeName,
        path: MessagesScreenNavigator.routeName,
        builder: (context, state) => const MessagesScreenNavigator(),
      ),
      GoRoute(
        name: NotificationScreen.routeName,
        path: NotificationScreen.routeName,
        builder: (context, state) => NotificationScreen(),
      ),
      GoRoute(
        name: ChatScreen.routeName,
        path: ChatScreen.routeName,
        builder: (context, state) => ChatScreen(
          chatUser: state.extra! as ChatUserModel,
        ),
      ),
      GoRoute(
        name: FeedScreen.routeName,
        path: FeedScreen.routeName,
        builder: (context, state) {
          final extras = state.extra! as Map<String, dynamic>;
          final briefId = extras['briefId'] ?? '';
          return FeedScreen(briefId: briefId.toString());
        },
      ),
      GoRoute(
        name: EditProfileScreen.routeName,
        path: EditProfileScreen.routeName,
        builder: (context, state) => EditProfileScreen(
          userProfileModel: state.extra! as UserProfileModel,
        ),
      ),
      GoRoute(
        name: TermsAndPrivacyView.routeName,
        path: TermsAndPrivacyView.routeName,
        builder: (context, state) => TermsAndPrivacyView(
          webviewUrl: state.extra! as String,
        ),
      ),
      GoRoute(
        name: ReplyScreen.routeName,
        path: ReplyScreen.routeName,
        builder: (context, state) {
          final extras = state.extra! as Map<String, dynamic>;
          final commentModel = extras['commentModel'] as CommentModel;
          final briefResult = extras['briefResult'] as BriefsResult;
          return ReplyScreen(commentModel: commentModel, briefResult: briefResult);
        },
      ),
      GoRoute(
        name: 'SharedFeedScreen',
        path: '/forum/discussion/thread/share/:briefId',
        builder: (context, state) {
          final briefId = state.pathParameters['briefId']!;
          return FeedScreen(briefId: briefId);
        },
      ),
    ],
  );

  static String getInitialRoute() {
    final isLogin = prefs!.getBool('isLogin') ?? false;
    final profile = prefs!.getBool('profile') ?? false;

    if (isLogin == false) {
      return WelcomeScreen.routeName;
    } else if (!profile) {
      return VerifyProfileScreen.routeName;
    } else {
      return HomeScreen.routeName;
    }
  }
}
