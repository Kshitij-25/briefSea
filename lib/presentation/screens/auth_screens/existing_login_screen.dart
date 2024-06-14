import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/enums/login_register_enum.dart';
import '../../../common/screen_size.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginNotifierProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF4C27FF),
      body: Stack(
        children: [
          bodyWidget(context, ref, loginState),
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

  bodyWidget(context, WidgetRef ref, LoginState loginState) {
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: ScreenSize.height(context) * .2),
                  GestureDetector(
                    onTap: () {
                      emailCont.text = "kshitij@briefsea.com";
                      passCont.text = '1234567890';
                    },
                    onDoubleTap: () {
                      emailCont.text = "rahul@briefsea.com";
                      passCont.text = "Abcd@1234#";
                    },
                    child: const Text(
                      "Login as\nExisting User",
                      style: TextStyle(color: Colors.white),
                      textScaler: TextScaler.linear(2),
                    ),
                  ),
                  SizedBox(height: ScreenSize.height(context) * .1),
                  CustomTextFormField(
                    hintText: "Enter your Email",
                    controller: emailCont,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: "Enter Password",
                    controller: passCont,
                    obscureText: true,
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
                    "Agency, Freelancer or Professional?",
                    style: TextStyle(color: Colors.white),
                    textScaler: TextScaler.linear(1),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
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
                        if (emailCont.text.isNotEmpty && passCont.text.isNotEmpty) {
                          await ref.read(loginNotifierProvider.notifier).loginUser(emailCont.text, passCont.text, ref, context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(top: 40, left: 0, child: CustomBackButton()),
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
