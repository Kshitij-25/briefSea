// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:briefsea/common/others/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../common/app_utils/validation_utils.dart';
import '../../../common/enums/enums.dart';
import '../../providers/auth_provider.dart';
import '../../state_providers/password_change_notifier.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';
import '../../widgets/custom_text_form_field.dart';

class AgencyRegistrationScreen extends ConsumerWidget {
  AgencyRegistrationScreen({super.key});

  static const String routeName = "/agencyRegisterScreen";

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerNotifierProvider);
    final passwordNotifier = ref.watch(passwordNotifierProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
                            Text(
                              "Briefsea for Agencies",
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: ScreenSize.height(context) * .05),
                            CustomTextFormField(
                              hintText: "Enter your First Name",
                              controller: _firstNameController,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (!ValidationUtils.isNotEmpty(value!)) {
                                  return 'First Name is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              hintText: "Enter your Last Name",
                              controller: _lastNameController,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (!ValidationUtils.isNotEmpty(value!)) {
                                  return 'Last Name is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              hintText: "Enter your Email",
                              controller: _emailController,
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
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              hintText: "Enter Password",
                              controller: _passwordController,
                              obscureText: passwordNotifier.obscureAgencyPassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  passwordNotifier.obscureAgencyPassword = !passwordNotifier.obscureAgencyPassword;
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Icon(
                                    !passwordNotifier.obscureAgencyPassword ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                                    size: 20 * ScaleSize.textScaleFactor(context),
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
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
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              hintText: "Confirm Password",
                              controller: _confirmPasswordController,
                              obscureText: passwordNotifier.obscureAgencyConfirmPassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  passwordNotifier.obscureAgencyConfirmPassword = !passwordNotifier.obscureAgencyConfirmPassword;
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Icon(
                                    !passwordNotifier.obscureAgencyConfirmPassword ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                                    size: 20 * ScaleSize.textScaleFactor(context),
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              validator: (value) {
                                if (!ValidationUtils.isNotEmpty(value!)) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: ScreenSize.height(context) * .05),
                            // SizedBox(height: ScreenSize.height(context) * .05),
                            // const Text(
                            //   "Or sign up using an option:",
                            //   style: TextStyle(color: Colors.white),
                            //   textScaler: TextScaler.linear(1),
                            //   textAlign: TextAlign.center,
                            // ),
                            // const SizedBox(height: 10),
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
                            Text(
                              "Freelancer, Working professional or\nExisting User?",
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
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
                              child: Text(
                                "Go back",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiaryContainer,
                                ),
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              ),
                            ),
                            Center(
                              child: CustomElevatedButton(
                                width: ScreenSize.width(context) * 0.5,
                                buttonLabel: "Next",
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Proceed with registration if validation passes
                                    await ref.read(registerNotifierProvider.notifier).registerUser(
                                          firstName: _firstNameController.text.trim(),
                                          lastName: _lastNameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text.trim(),
                                          type: "Agency",
                                          subType: "",
                                          ref: ref,
                                          context: context,
                                        );
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: ScreenSize.height(context) * .05),
                            Text(
                              Strings.agencyFooter,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 11),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
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

// _signUpOptions(context, imagePath, onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 70,
//         width: 70,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: SvgPicture.asset(
//           imagePath,
//           fit: BoxFit.scaleDown,
//         ),
//       ),
//     );
//   }
}
