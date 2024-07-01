import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';
import 'verify_profile_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  static const routeName = "/otpScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4C27FF),
      body: bodyWidget(context),
    );
  }

  bodyWidget(context) {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: ScreenSize.height(context) * .17),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter Email\nVerification Code",
                      style: TextStyle(color: Colors.white),
                      textScaler: TextScaler.linear(2),
                    ),
                  ),
                  SizedBox(height: ScreenSize.height(context) * .1),
                  Text(
                    "Resend Code in",
                    style: TextStyle(color: Colors.grey[350]!),
                    textScaler: const TextScaler.linear(1),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OtpTextField(
                    fillColor: Colors.grey[200]!,
                    filled: true,
                    fieldWidth: 55,
                    fieldHeight: 55,
                    numberOfFields: 5,
                    autoFocus: true,
                    borderColor: const Color(0xFF512DA8),
                    textStyle: const TextStyle(color: Colors.black),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Verification Code"),
                              content: Text('Code entered is $verificationCode'),
                            );
                          });
                    }, // end onSubmit
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "A 5-digit code has been\nsent to demo@demo.com",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    textScaler: TextScaler.linear(1.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Please check your spam\nfolder if you can't locate it.",
                    style: TextStyle(color: Colors.grey[350]!),
                    textScaler: const TextScaler.linear(1),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: ScreenSize.height(context) * .05),
                  CustomElevatedButton(
                    width: ScreenSize.width(context) * 0.5,
                    buttonLabel: "Submit",
                    onPressed: () {
                      GoRouter.of(context).go(VerifyProfileScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 40,
            left: 0,
            child: Row(
              children: [
                CustomBackButton(),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Sent to demo@demo.com",
                    style: TextStyle(color: Colors.white),
                    textScaler: TextScaler.linear(1.3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
