import 'package:briefsea/common/others/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../common/others/assets.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';
import 'agency_register_screen.dart';
import 'existing_login_screen.dart';
import 'freelancer_register_screen.dart';
import 'professional_register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const routeName = "/welcomeScreen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Image? logoImage;

  @override
  void initState() {
    logoImage = Image.asset(
      Assets.APP_LOGO,
      color: Colors.white,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(logoImage!.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4C27FF),
      body: SizedBox(
        height: ScreenSize.height(context),
        child: Stack(
          children: [
            const CustomShapeWidget(),
            Container(
              width: ScreenSize.width(context),
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    logoImage!,
                    const Text(
                      Strings.welcomeText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      // textScaler: TextScaler.linear(1.2),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: ScreenSize.height(context) * .05),
                    const Text(
                      Strings.privacyPolicy,
                      style: TextStyle(color: Colors.white),
                      textScaler: TextScaler.linear(1),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      buttonLabel: "Join as an Agency",
                      onPressed: () {
                        GoRouter.of(context).push(AgencyRegisterScreen.routeName);
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      buttonLabel: "Join as a Freelancer",
                      onPressed: () {
                        GoRouter.of(context).push(FreelancerRegisterScreen.routeName);
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      buttonLabel: "Join as a Working Professional",
                      onPressed: () {
                        GoRouter.of(context).push(ProfessionalRegisterScreen.routeName);
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      buttonLabel: "Sign in as an Existing User",
                      onPressed: () {
                        GoRouter.of(context).push(ExistingLoginScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
