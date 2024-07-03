import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../common/app_utils/screen_size.dart';
import '../../../common/app_utils/validation_utils.dart';
import '../../../common/enums/enums.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';
import '../../widgets/custom_text_form_field.dart';

class ExistingLoginScreen extends ConsumerWidget {
  ExistingLoginScreen({super.key});

  static const routeName = "/existingLoginScreen";

  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();
  final TextEditingController forgotEmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginNotifierProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF4C27FF),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SizedBox(
              height: ScreenSize.height(context),
              child: Stack(
                children: [
                  const CustomShapeWidget(),
                  Container(
                    width: ScreenSize.width(context),
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: ScreenSize.height(context) * .2),
                          GestureDetector(
                            onTap: () {
                              emailCont.text = "kshitij@briefsea.com";
                              passCont.text = 'Test@1234';
                            },
                            onLongPress: () {
                              emailCont.text = "dowaye6258@elahan.com";
                              passCont.text = 'Test@123';
                            },
                            onDoubleTap: () {
                              emailCont.text = "rahul@briefsea.com";
                              passCont.text = "Abcd@1234#";
                            },
                            child: const Text(
                              "Login as Existing User",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              // textScaler: TextScaler.linear(1.2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: ScreenSize.height(context) * .1),
                          CustomTextFormField(
                            hintText: "Enter your Email",
                            controller: emailCont,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!ValidationUtils.isValidEmail(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: "Enter Password",
                            controller: passCont,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              overlayColor: WidgetStateColor.transparent,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: const Color(0xFF4C27FF),
                                // isScrollControlled: true,
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
                                              const Text(
                                                "Reset your password",
                                                style: TextStyle(color: Colors.white),
                                                textScaler: TextScaler.linear(1),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 20),
                                              CustomTextFormField(
                                                hintText: "Enter Email",
                                                controller: forgotEmail,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Email is required';
                                                  }
                                                  if (!ValidationUtils.isValidEmail(value)) {
                                                    return 'Enter a valid email';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(height: 20),
                                              CustomElevatedButton(
                                                width: ScreenSize.width(context) * 0.5,
                                                buttonLabel: "Submit",
                                                onPressed: () async {
                                                  if (_formKey2.currentState!.validate()) {
                                                    await ref.read(ForgetPasswordProvider(email: forgotEmail.text).future);
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
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          // SizedBox(height: ScreenSize.height(context) * .05),
                          // const Text(
                          //   "Or sign up using an option:",
                          //   style: TextStyle(color: Colors.white),
                          //   textScaler: TextScaler.linear(1),
                          //   textAlign: TextAlign.center,
                          // ),
                          // const SizedBox(height: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     _signUpOptions(
                          //       context,
                          //       'assets/logos/google-icon.svg',
                          //       () {},
                          //     ),
                          //     const SizedBox(width: 20),
                          //     _signUpOptions(
                          //       context,
                          //       'assets/logos/linkedin-icon.svg',
                          //       () {},
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: ScreenSize.height(context) * .05),
                          const Text(
                            "Agency, Freelancer or\nWorking Professional?",
                            style: TextStyle(color: Colors.white),
                            textScaler: TextScaler.linear(1),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).pop();
                            },
                            style: const ButtonStyle(
                              overlayColor: WidgetStateColor.transparent,
                            ),
                            child: const Text(
                              "Go back",
                              style: TextStyle(
                                color: Color(0xFF01FFF5),
                              ),
                            ),
                          ),
                          Center(
                            child: CustomElevatedButton(
                              width: ScreenSize.width(context) * 0.5,
                              buttonLabel: "Next",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await ref.read(loginNotifierProvider.notifier).loginUser(emailCont.text, passCont.text, ref, context);
                                }
                              },
                            ),
                          ),
                        ],
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
          ),
          if (loginState == LoginState.loading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
        ],
      ),
    );
  }

  _signUpOptions(context, imagePath, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
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
