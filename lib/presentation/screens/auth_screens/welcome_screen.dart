import 'package:briefsea/common/others/strings.dart';
import 'package:briefsea/data/core/api_constants.dart';
import 'package:briefsea/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/app_utils/device_type.dart';
import '../../../common/app_utils/screen_size.dart';
import '../../../common/others/assets.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';
import '../terms_and_privacy_view.dart';
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
    ScaleSize.textScaleFactor(context).log();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
                    SizedBox(
                      height: getDeviceType(context) == DeviceType.Tablet ? ScreenSize.height(context) * .4 : null,
                      child: logoImage!,
                    ),
                    Text(
                      Strings.welcomeText,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
                      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: ScreenSize.height(context) * .05),
                    Text(
                      Strings.privacyPolicy,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12 * ScaleSize.textScaleFactor(context)),
                      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      textAlign: TextAlign.center,
                    ),
                    // GoRouter.of(context).push(TermsAndPrivacyView.routeName),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Terms of Use',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.tertiaryContainer,
                                  fontSize: 12 * ScaleSize.textScaleFactor(context),
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                GoRouter.of(context).push(
                                  TermsAndPrivacyView.routeName,
                                  extra: ApiConstants.termsOfUse,
                                );
                              },
                          ),
                          TextSpan(
                            text: ' and ',
                            style: Theme.of(context).textTheme.bodySmall!,
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.tertiaryContainer,
                                  fontSize: 12 * ScaleSize.textScaleFactor(context),
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                GoRouter.of(context).push(
                                  TermsAndPrivacyView.routeName,
                                  extra: ApiConstants.privacyPolicy,
                                );
                              },
                          ),
                        ],
                      ),
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
