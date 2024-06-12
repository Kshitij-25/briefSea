import 'package:briefsea/presentation/screens/auth_screens/agency_register_screen.dart';
import 'package:briefsea/presentation/screens/auth_screens/existing_login_screen.dart';
import 'package:briefsea/presentation/screens/auth_screens/freelancer_register_screen.dart';
import 'package:briefsea/presentation/screens/auth_screens/professional_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/screen_size.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const routeName = "/welcomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4C27FF),
      body: bodyWidget(context),
    );
  }

  bodyWidget(context) {
    return SizedBox(
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
                  // SizedBox(height: ScreenSize.height(context) * .2),
                  Image.asset(
                    'assets/logos/IMG_9485.PNG',
                    color: Colors.white,
                  ),
                  // const Text(
                  //   "Briefsea",
                  //   style: TextStyle(color: Colors.white),
                  //   textScaler: TextScaler.linear(5),
                  // ),
                  // const SizedBox(height: 20),
                  const Text(
                    "Quickly connect with\nFreelancers, Vendors and Agencies\nof your industry",
                    style: TextStyle(color: Colors.white),
                    textScaler: TextScaler.linear(1.38),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: ScreenSize.height(context) * .05),
                  const Text(
                    "By continuing you agree to\nTerms of Use and Privacy Policy",
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
    );
  }
}
