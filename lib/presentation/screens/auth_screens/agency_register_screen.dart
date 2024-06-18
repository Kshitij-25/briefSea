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

class AgencyRegisterScreen extends ConsumerWidget {
  AgencyRegisterScreen({super.key});

  static const routeName = "/agencyRegisterScreen";

  final TextEditingController agencyUsername = TextEditingController();
  final TextEditingController agencyEmail = TextEditingController();
  final TextEditingController agencyPass = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerNotifierProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF4C27FF),
      body: Stack(
        children: [
          bodyWidget(context, ref, registerState),
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

  bodyWidget(context, WidgetRef ref, RegisterState registerState) {
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
                  SizedBox(height: ScreenSize.height(context) * .15),
                  const Text(
                    "Verify your Agency",
                    style: TextStyle(color: Colors.white),
                    textScaler: TextScaler.linear(2),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: ScreenSize.height(context) * .05),
                  CustomTextFormField(
                    hintText: "Enter Name",
                    controller: agencyUsername,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: "Enter your Email",
                    controller: agencyEmail,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: "Enter Password",
                    controller: agencyPass,
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
                    "Freelancer, Professional or Existing User?",
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
                        if (agencyUsername.text.isNotEmpty && agencyEmail.text.isNotEmpty && agencyPass.text.isNotEmpty) {
                          //   final isRegistered = await ref.read(registerUserProvider(
                          //     userName: agencyUsername.text,
                          //     email: agencyEmail.text,
                          //     password: agencyPass.text,
                          //     type: "agency",
                          //     subType: "",
                          //   ).future);
                          //   print(isRegistered);

                          //   if (isRegistered == true) {
                          //     AppUtility(context).message("Registered Successfully. Check email to Verify Profile and Login.");
                          //     GoRouter.of(context).pop();
                          //   }
                          await ref
                              .read(registerNotifierProvider.notifier)
                              .registerUser(agencyUsername.text, agencyEmail.text, agencyPass.text, "agency", "", ref, context);
                          // await ref.read(postNewNotificationProvider(requestBody: {
                          //   "type": 'user account',
                          //   "sender_id": 'briefseaAdmin9712',
                          //   "sender_name": 'Briefsea',
                          //   "receiver_id": result?.user_id,
                          //   "notification":
                          //       "Welcome to Briefsea.Hire the best freelancers, vendors and professionals for your tech and marketing projects."
                          // }).future);
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
