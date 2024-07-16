import 'package:briefsea/common/others/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../common/app_utils/validation_utils.dart';
import '../../../common/enums/enums.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';
import '../../widgets/custom_text_form_field.dart';

class FreelancerRegisterScreen extends ConsumerWidget {
  FreelancerRegisterScreen({super.key});

  static const routeName = "/freelancerRegisterScreen";

  final TextEditingController freelanceFirstName = TextEditingController();
  final TextEditingController freelanceLastName = TextEditingController();
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
                            hintText: "Enter your First Name",
                            controller: freelanceFirstName,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (!ValidationUtils.isNotEmpty(value!)) {
                                return 'First Name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: "Enter your Last Name",
                            controller: freelanceLastName,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (!ValidationUtils.isNotEmpty(value!)) {
                                return 'Last Name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: "Enter your Email",
                            controller: freelanceEmail,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
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
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: "Enter Password",
                            controller: freelancePass,
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                            maxLines: 1,
                            validator: (value) {
                              if (!ValidationUtils.isNotEmpty(value!)) {
                                return 'Password is required';
                              }
                              if (!ValidationUtils.isValidPassword(value)) {
                                return 'Password should be at least 8 characters, contain at least one letter, one number, and one special character';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: "Confirm Password",
                            controller: freelanceConfirmPass,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            validator: (value) {
                              if (!ValidationUtils.isNotEmpty(value!)) {
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
                              enableFeedback: true,
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
                                        firstName: freelanceFirstName.text,
                                        lastName: freelanceLastName.text,
                                        email: freelanceEmail.text,
                                        password: freelancePass.text,
                                        type: "Freelancer",
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
                            Strings.freelancerFooter,
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
