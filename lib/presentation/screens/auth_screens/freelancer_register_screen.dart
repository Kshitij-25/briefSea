import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/enums.dart';
import '../../../common/screen_size.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';
import '../../widgets/custom_text_form_field.dart';

class FreelancerRegisterScreen extends ConsumerWidget {
  FreelancerRegisterScreen({super.key});

  static const routeName = "/freelancerRegisterScreen";

  final TextEditingController freelanceUserName = TextEditingController();
  final TextEditingController freelanceEmail = TextEditingController();
  final TextEditingController freelancePass = TextEditingController();
  final TextEditingController freelanceConfirmPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerNotifierProvider);
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
                          SizedBox(height: ScreenSize.height(context) * .15),
                          const Text(
                            "Briefsea for Freelancers",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                            // textScaler: TextScaler.linear(1.2),
                          ),
                          SizedBox(height: ScreenSize.height(context) * .05),
                          CustomTextFormField(
                            hintText: "Enter Name",
                            controller: freelanceUserName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: "Enter your Email",
                            controller: freelanceEmail,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: "Enter Password",
                            controller: freelancePass,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 8) {
                                return 'Password should be at least 8 characters';
                              }
                              if (!value.contains(RegExp(r'[0-9]'))) {
                                return 'Password should contain at least one number';
                              }
                              if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                return 'Password should contain at least one special character';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: "Confirm Password",
                            controller: freelanceConfirmPass,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != freelancePass.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
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
                            "Agency, Working professional or\nExisting User?",
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
                                  await ref.read(registerNotifierProvider.notifier).registerUser(
                                        userName: freelanceUserName.text,
                                        email: freelanceEmail.text,
                                        password: freelancePass.text,
                                        type: "freelancer",
                                        subType: "",
                                        ref: ref,
                                        context: context,
                                      );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: ScreenSize.height(context) * .05),
                          const Text(
                            "Instantly discover and grab\nhot freelancing opportunities\nin your industry.",
                            style: TextStyle(color: Colors.white),
                            textScaler: TextScaler.linear(1),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(top: 40, left: 0, child: CustomBackButton()),
                ],
              ),
            ),
          ),
          if (registerState == RegisterState.loading)
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
