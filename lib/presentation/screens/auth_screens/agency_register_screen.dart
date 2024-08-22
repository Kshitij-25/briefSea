// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:briefsea/presentation/screens/auth_screens/existing_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../common/app_utils/validation_utils.dart';
import '../../../common/enums/enums.dart';
import '../../../common/others/assets.dart';
import '../../providers/auth_provider.dart';
import '../../state_providers/password_change_notifier.dart';
import '../../state_providers/verify_profile_industry_provider.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';
import '../../widgets/custom_text_form_field.dart';

class AgencyRegistrationScreen extends HookConsumerWidget {
  AgencyRegistrationScreen({super.key});

  static const String routeName = "/agencyRegisterScreen";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _firstNameController = useTextEditingController();
    final _lastNameController = useTextEditingController();
    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();
    final _confirmPasswordController = useTextEditingController();

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
              child: Stack(
                children: [
                  const CustomShapeWidget(),
                  Container(
                    width: ScreenSize.width(context),
                    height: ScreenSize.height(context),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: ScreenSize.height(context),
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: ScreenSize.height(context) * .1),
                              Text(
                                "Create Account",
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "to get started now!",
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 27),
                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: ScreenSize.height(context) * .03),
                              CustomTextFormField(
                                hintText: "Enter your First Name",
                                controller: _firstNameController,
                                textInputAction: TextInputAction.next,
                                autofillHints: [AutofillHints.givenName],
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
                                autofillHints: [AutofillHints.familyName],
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
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  hintText: 'Select Account Type',
                                  hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black),
                                  isDense: true,
                                  enabled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusColor: Colors.white,
                                  filled: true,
                                  fillColor: Theme.of(context).colorScheme.surface,
                                ),
                                value: ref.watch(selectAccountTypeProvider).selectedType,
                                onChanged: (String? newValue) async {
                                  ref.read(selectAccountTypeProvider).setAccountType(newValue!);
                                },
                                items: ref.watch(selectAccountTypeProvider).accountType.map<DropdownMenuItem<String>>((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(color: Colors.black),
                                      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: ScreenSize.height(context) * .03),
                              CustomElevatedButton(
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
                                      "Or Sign up with",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _signUpOptions(
                                    context: context,
                                    imagePath: Assets.GOOGLE_LOGO,
                                    onTap: () async {
                                      await ref.read(loginNotifierProvider.notifier).loginWithGoogle(
                                            context: context,
                                            ref: ref,
                                            isLogin: false,
                                          );
                                    },
                                  ),
                                ],
                              ),
                              // SizedBox(height: ScreenSize.height(context) * .01),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
                                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                    textAlign: TextAlign.center,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      GoRouter.of(context).pushReplacementNamed(ExistingLoginScreen.routeName);
                                    },
                                    style: const ButtonStyle(
                                      enableFeedback: true,
                                      overlayColor: WidgetStateColor.transparent,
                                    ),
                                    child: Text(
                                      "Login now",
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.tertiaryContainer,
                                      ),
                                      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(top: 40, left: 0, child: CustomBackButton()),
                ],
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
