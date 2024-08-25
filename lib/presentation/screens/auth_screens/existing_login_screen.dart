import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../common/app_utils/screen_size.dart';
import '../../../common/app_utils/validation_utils.dart';
import '../../../common/enums/enums.dart';
import '../../providers/auth_provider.dart';
import '../../state_providers/password_change_notifier.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';
import '../../widgets/custom_text_form_field.dart';
import 'agency_register_screen.dart';

class ExistingLoginScreen extends ConsumerWidget {
  ExistingLoginScreen({super.key});

  static const routeName = "/existingLoginScreen";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController forgotEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginNotifierProvider);
    final passNotifier = ref.watch(passwordNotifierProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: Stack(
                children: [
                  const CustomShapeWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: ScreenSize.width(context),
                        height: ScreenSize.height(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: ScreenSize.height(context) * .25),
                            GestureDetector(
                              onTap: () {
                                if (kDebugMode) {
                                  emailController.text = "kshitij@briefsea.com";
                                  passwordController.text = 'Kshitij@2201';
                                }
                              },
                              onLongPress: () {
                                if (kDebugMode) {
                                  emailController.text = "xalonev795@devncie.com";
                                  passwordController.text = 'Test@1234';
                                }
                              },
                              // onDoubleTap: () {
                              //   if (kDebugMode) {
                              //     emailController.text = "lofeti1583@luvnish.com";
                              //     passwordController.text = "lofeti1583@luvnish.com";
                              //   }
                              // },
                              onDoubleTap: () {
                                if (kDebugMode) {
                                  emailController.text = "anmol.pandey@urpopular.com";
                                  passwordController.text = "Anmol@123";
                                }
                              },
                              child: Text(
                                'Welcome,',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              'Glad to see you!',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 27),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: ScreenSize.height(context) * .03),
                            CustomTextFormField(
                              hintText: "Enter your Email",
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: [AutofillHints.email],
                              validator: (value) {
                                if (!ValidationUtils.isNotEmpty(value!)) {
                                  return 'Email is required';
                                }
                                if (!ValidationUtils.isValidEmail(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              hintText: "Enter Password",
                              controller: passwordController,
                              textInputAction: TextInputAction.done,
                              obscureText: passNotifier.obscureExistingPassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  passNotifier.obscureExistingPassword = !passNotifier.obscureExistingPassword;
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Icon(
                                    !passNotifier.obscureExistingPassword ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                                    size: 20 * ScaleSize.textScaleFactor(context),
                                  ),
                                ),
                              ),
                              maxLines: 1,
                              validator: (value) {
                                if (!ValidationUtils.isNotEmpty(value!)) {
                                  return 'Password is required';
                                }
                                return null;
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                style: const ButtonStyle(
                                  enableFeedback: true,
                                  overlayColor: WidgetStateColor.transparent,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: const Color(0xFF4C27FF),
                                    // isScrollControlled: true,
                                    constraints: BoxConstraints.fromViewConstraints(ViewConstraints(minWidth: ScreenSize.width(context))),
                                    useSafeArea: true,
                                    builder: (context) {
                                      return SafeArea(
                                        child: Form(
                                          key: _formKey2,
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                            child: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Reset your password",
                                                    style: Theme.of(context).textTheme.titleLarge,
                                                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  CustomTextFormField(
                                                    hintText: "Enter Email",
                                                    controller: forgotEmailController,
                                                    autofillHints: [AutofillHints.email],
                                                    validator: (value) {
                                                      if (!ValidationUtils.isNotEmpty(value!)) {
                                                        return 'Email is required';
                                                      }
                                                      if (!ValidationUtils.isValidEmail(value)) {
                                                        return 'Enter a valid email';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 10),
                                                  CustomElevatedButton(
                                                    width: ScreenSize.width(context) * 0.5,
                                                    buttonLabel: "Submit",
                                                    onPressed: () async {
                                                      if (_formKey2.currentState!.validate()) {
                                                        await ref.read(ForgetPasswordProvider(email: forgotEmailController.text).future);
                                                        context.pop();
                                                        AppUtility(context).message("Check email to reset password.");
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.white),
                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                ),
                              ),
                            ),
                            SizedBox(height: ScreenSize.height(context) * .02),
                            Center(
                              child: CustomElevatedButton(
                                buttonLabel: "Login",
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await ref.read(loginNotifierProvider.notifier).loginUser(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                          ref,
                                          context,
                                        );
                                  }
                                },
                              ),
                            ),
                            // SizedBox(height: ScreenSize.height(context) * .05),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Divider(
                            //         thickness: 2,
                            //         color: Theme.of(context).colorScheme.onInverseSurface,
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.symmetric(horizontal: 10),
                            //       child: Text(
                            //         "Or Login with",
                            //         style: Theme.of(context).textTheme.bodyMedium,
                            //         textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Divider(
                            //         thickness: 2,
                            //         color: Theme.of(context).colorScheme.onInverseSurface,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: ScreenSize.height(context) * .02),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     _signUpOptions(
                            //       context: context,
                            //       imagePath: Assets.GOOGLE_LOGO,
                            //       onTap: () async {
                            //         await ref.read(loginNotifierProvider.notifier).loginWithGoogle(
                            //               context: context,
                            //               ref: ref,
                            //               isLogin: true,
                            //             );
                            //       },
                            //     ),
                            //     // const SizedBox(width: 20),
                            //     // _signUpOptions(
                            //     //   context: context,
                            //     //   imagePath: Assets.phoneIcon,
                            //     //   onTap: () {},
                            //     // ),
                            //   ],
                            // ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                  textAlign: TextAlign.center,
                                ),
                                TextButton(
                                  onPressed: () {
                                    GoRouter.of(context).pushReplacementNamed(AgencyRegistrationScreen.routeName);
                                  },
                                  style: const ButtonStyle(
                                    overlayColor: WidgetStateColor.transparent,
                                  ),
                                  child: Text(
                                    'Sign up now',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.tertiaryContainer,
                                    ),
                                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: ScreenSize.height(context) * .01),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 40,
                    left: 0,
                    child: CustomBackButton(),
                  ),
                ],
              ),
            ),
            if (loginState == LoginState.loading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _signUpOptions({context, imagePath, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 160,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
        ),
        child: SvgPicture.asset(
          imagePath,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
