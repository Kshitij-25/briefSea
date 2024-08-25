import 'package:briefsea/common/others/strings.dart';
import 'package:briefsea/data/core/api_constants.dart';
import 'package:briefsea/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/device_type.dart';
import '../../../common/app_utils/screen_size.dart';
import '../../../common/others/assets.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';
import '../terms_and_privacy_view.dart';
import 'agency_register_screen.dart';
import 'existing_login_screen.dart';

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
              height: ScreenSize.height(context),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: ScreenSize.width(context),
                  height: ScreenSize.height(context),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: getDeviceType(context) == DeviceType.Tablet ? ScreenSize.height(context) * .4 : null,
                          child: logoImage!,
                        ),
                        SizedBox(height: ScreenSize.height(context) * .001),
                        Text(
                          Strings.welcomeText,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: ScreenSize.height(context) * .03),
                        CustomElevatedButton(
                          buttonLabel: "Login",
                          onPressed: () {
                            GoRouter.of(context).push(ExistingLoginScreen.routeName);
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomElevatedButton(
                          buttonLabel: "Sign Up",
                          onPressed: () {
                            GoRouter.of(context).push(AgencyRegistrationScreen.routeName);
                          },
                        ),
                        SizedBox(height: ScreenSize.height(context) * .02),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Theme.of(context).colorScheme.onInverseSurface,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Or",
                                style: Theme.of(context).textTheme.bodyMedium,
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Theme.of(context).colorScheme.onInverseSurface,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenSize.height(context) * .02),
                        _GoogleButton(),
                        Spacer(),
                        Text(
                          Strings.privacyPolicy,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12 * ScaleSize.textScaleFactor(context)),
                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                          textAlign: TextAlign.center,
                        ),
                        _buildTermsAndPrivacyText(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsAndPrivacyText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          _buildClickableText(context, 'Terms of Use', ApiConstants.termsOfUse),
          TextSpan(
            text: ' and ',
            style: TextStyle(
              fontSize: 12 * ScaleSize.textScaleFactor(context),
            ),
          ),
          _buildClickableText(context, 'Privacy Policy', ApiConstants.privacyPolicy),
        ],
      ),
    );
  }

  TextSpan _buildClickableText(BuildContext context, String text, String route) {
    return TextSpan(
      text: text,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            fontSize: 12 * ScaleSize.textScaleFactor(context),
          ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          GoRouter.of(context).push(
            TermsAndPrivacyView.routeName,
            extra: route,
          );
        },
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return InkWell(
        borderRadius: BorderRadius.circular(10),
        // highlightColor: Theme.of(context).highlightColor,
        // focusColor: Theme.of(context).highlightColor,
        // splashColor: Theme.of(context).highlightColor,
        onTap: () async {
          await ref.read(loginNotifierProvider.notifier).loginWithGoogle(
                context: context,
                ref: ref,
                isLogin: true,
              );
        },
        child: Container(
          height: getDeviceType(context) == DeviceType.Tablet ? 70 : 50,
          width: ScreenSize.width(context) / ScaleSize.textScaleFactor(context),
          decoration: BoxDecoration(
            color: Colors.grey[200]!,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(Assets.GOOGLE_LOGO),
              Text(
                'Continue with Google',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                textScaler: TextScaler.linear(
                  ScaleSize.textScaleFactor(context),
                ),
              ),
              SizedBox(width: ScreenSize.width(context) * .02)
            ],
          ),
        ),
      );
    });
  }
}
