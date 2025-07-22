import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/app_utils/screen_size.dart';
import '../../../common/enums/enums.dart';
import '../../providers/auth_provider.dart';
import '../../state_providers/verify_profile_industry_provider.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shape_widget.dart';

class ChooseAccountType extends HookConsumerWidget {
  static const String routeName = "/chooseAccountType";

  const ChooseAccountType({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginNotifierProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            SizedBox(
              width: ScreenSize.width(context),
              child: Stack(
                children: [
                  const CustomShapeWidget(),
                  Container(
                    width: ScreenSize.width(context),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: ScreenSize.width(context),
                        height: ScreenSize.height(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'How would you like to use Briefsea?',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: ScreenSize.height(context) * .03),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Using Briefsea as',
                                labelStyle: TextStyle(color: Theme.of(context).hintColor, fontSize: 14 * ScaleSize.textScaleFactor(context)),
                                hintText: 'Using Briefsea as',
                                hintStyle: TextStyle(color: Theme.of(context).hintColor, fontSize: 14 * ScaleSize.textScaleFactor(context)),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                // isDense: true,
                                enabled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
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
                            Center(
                              child: CustomElevatedButton(
                                buttonLabel: "Next",
                                onPressed: () async {
                                  await ref.read(loginNotifierProvider.notifier).chooseAccountType(
                                        ref: ref,
                                        context: context,
                                        isUserRegistered: false,
                                      );
                                },
                              ),
                            ),
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
}
