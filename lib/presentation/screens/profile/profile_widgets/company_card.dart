import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common/app_utils/app_utility.dart';
import '../../../../common/app_utils/screen_size.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../../main.dart';
import '../../../state_providers/verify_profile_industry_provider.dart';
import '../../../widgets/custom_text_form_field.dart';

class CompanyCard extends StatelessWidget {
  CompanyCard({
    this.userProfileData,
    this.isOtherProfile,
    this.companyName,
    this.companyStartDate,
    this.companyEndDate,
    this.companyOnPressed,
  });

  final UserProfileModel? userProfileData;
  final bool? isOtherProfile;

  final TextEditingController? companyName;
  final TextEditingController? companyStartDate;
  final TextEditingController? companyEndDate;

  DateTime? selectedStartDate;
  bool isCurrentlyWorking = true;

  final void Function()? companyOnPressed;

  @override
  Widget build(BuildContext context) {
    if (userProfileData?.experience?.isEmpty == true)
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Companies',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
                Spacer(),
                if (isOtherProfile != true)
                  IconButton(
                    onPressed: () {
                      if (prefs!.getBool('profile') == false) {
                        AppUtility(context).error('Complete the Profile first.');
                        return;
                      }
                      showModalBottomSheet(
                        context: context,
                        useSafeArea: true,
                        constraints: BoxConstraints.fromViewConstraints(ViewConstraints(minWidth: ScreenSize.width(context))),
                        isScrollControlled: true,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 15, right: 15, top: 15),
                            child: StatefulBuilder(
                              builder: (
                                BuildContext context,
                                StateSetter setState,
                              ) {
                                return Consumer(
                                  builder: (context, ref, _) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Add Company',
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurface,
                                              ),
                                        ),
                                        SizedBox(height: 5),
                                        DropdownButtonFormField<String>(
                                          menuMaxHeight: 400,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.red),
                                            ),
                                            hintText: 'Choose Designation',
                                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14 * ScaleSize.textScaleFactor(context)),
                                            fillColor: Theme.of(context).colorScheme.surfaceContainer,
                                            filled: true,
                                          ),
                                          isExpanded: true,
                                          value: ref.watch(selectedPostProvider),
                                          onChanged: (String? newValue) {
                                            ref.read(selectedPostProvider.notifier).state = newValue;
                                          },
                                          items: ref.watch(postListDataProvider).map<DropdownMenuItem<String>>((item) {
                                            return DropdownMenuItem<String>(
                                              value: item.value,
                                              child: Text(
                                                item.label,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        SizedBox(height: 5),
                                        CustomTextFormField(
                                          hintText: 'Enter the name of company',
                                          controller: companyName,
                                        ),
                                        SizedBox(height: 5),
                                        CustomTextFormField(
                                          hintText: 'Start Date',
                                          controller: companyStartDate,
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now(),
                                            );

                                            if (pickedDate != null) {
                                              setState(() {
                                                selectedStartDate = pickedDate;
                                                companyStartDate!.text = "${pickedDate.toLocal()}".split(' ')[0];
                                              });
                                            }
                                          },
                                        ),
                                        SizedBox(height: 5),
                                        if (isCurrentlyWorking != true)
                                          CustomTextFormField(
                                            hintText: 'End Date',
                                            controller: companyEndDate,
                                            readOnly: true,
                                            onTap: () async {
                                              DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: selectedStartDate!,
                                                lastDate: DateTime.now(),
                                              );

                                              if (pickedDate != null) {
                                                setState(() {
                                                  companyEndDate!.text = "${pickedDate.toLocal()}".split(' ')[0];
                                                });
                                              }
                                            },
                                          ),
                                        SizedBox(height: 5),
                                        CheckboxListTile.adaptive(
                                          value: isCurrentlyWorking,
                                          onChanged: (value) {
                                            setState(() {
                                              isCurrentlyWorking = value!;
                                            });
                                          },
                                          title: Text('Currently working here'),
                                        ),
                                        SizedBox(height: 5),
                                        DropdownButtonFormField<String>(
                                          menuMaxHeight: 400,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.red),
                                            ),
                                            hintText: 'Team Size',
                                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14 * ScaleSize.textScaleFactor(context)),
                                            fillColor: Theme.of(context).colorScheme.surfaceContainer,
                                            filled: true,
                                          ),
                                          isExpanded: true,
                                          value: ref.watch(selectedTeamSizeProvider),
                                          onChanged: (String? newValue) {
                                            ref.read(selectedTeamSizeProvider.notifier).state = newValue;
                                          },
                                          items: ref.watch(teamSizeDataProvider).map<DropdownMenuItem<String>>((item) {
                                            return DropdownMenuItem<String>(
                                              value: item.value,
                                              child: Text(
                                                item.label,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                              ),
                                              onPressed: companyOnPressed,
                                              child: Text('Add Company'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Theme.of(context).colorScheme.secondary,
                                              ),
                                              onPressed: () {
                                                ref.read(selectedTeamSizeProvider.notifier).dispose();
                                                ref.read(selectedPostProvider.notifier).dispose();
                                                GoRouter.of(context).pop();
                                              },
                                              child: Text('Close'),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 25),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.add_circled_solid,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
              ],
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(-0.73, 0.68),
                    end: Alignment(0.73, -0.68),
                    colors: [Color(0xFF4A26FE), Color(0xFF222CFF)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'No Company Details found!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.42,
                    ),
                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    else
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Companies',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
                Spacer(),
                if (isOtherProfile != true)
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        useSafeArea: true,
                        constraints: BoxConstraints.fromViewConstraints(ViewConstraints(minWidth: ScreenSize.width(context))),
                        isScrollControlled: true,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 15, right: 15, top: 15),
                            child: StatefulBuilder(
                              builder: (
                                BuildContext context,
                                StateSetter setState,
                              ) {
                                return Consumer(
                                  builder: (context, ref, _) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Add Company',
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurface,
                                              ),
                                        ),
                                        SizedBox(height: 5),
                                        DropdownButtonFormField<String>(
                                          menuMaxHeight: 400,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.red),
                                            ),
                                            hintText: 'Choose Designation',
                                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14 * ScaleSize.textScaleFactor(context)),
                                            fillColor: Theme.of(context).colorScheme.surfaceContainer,
                                            filled: true,
                                          ),
                                          isExpanded: true,
                                          value: ref.watch(selectedPostProvider),
                                          onChanged: (String? newValue) {
                                            ref.read(selectedPostProvider.notifier).state = newValue;
                                          },
                                          items: ref.watch(postListDataProvider).map<DropdownMenuItem<String>>((item) {
                                            return DropdownMenuItem<String>(
                                              value: item.value,
                                              child: Text(
                                                item.label,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        SizedBox(height: 5),
                                        CustomTextFormField(
                                          hintText: 'Enter the name of company',
                                          controller: companyName,
                                        ),
                                        SizedBox(height: 5),
                                        CustomTextFormField(
                                          hintText: 'Start Date',
                                          controller: companyStartDate,
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now(),
                                            );

                                            if (pickedDate != null) {
                                              setState(() {
                                                selectedStartDate = pickedDate;
                                                companyStartDate!.text = "${pickedDate.toLocal()}".split(' ')[0];
                                              });
                                            }
                                          },
                                        ),
                                        if (isCurrentlyWorking != true) SizedBox(height: 5),
                                        if (isCurrentlyWorking != true)
                                          CustomTextFormField(
                                            hintText: 'End Date',
                                            controller: companyEndDate,
                                            readOnly: true,
                                            onTap: () async {
                                              DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: selectedStartDate!,
                                                lastDate: DateTime.now(),
                                              );

                                              if (pickedDate != null) {
                                                setState(() {
                                                  companyEndDate!.text = "${pickedDate.toLocal()}".split(' ')[0];
                                                });
                                              }
                                            },
                                          ),
                                        SizedBox(height: 5),
                                        CheckboxListTile.adaptive(
                                          value: isCurrentlyWorking,
                                          onChanged: (value) {
                                            setState(() {
                                              isCurrentlyWorking = value!;
                                            });
                                          },
                                          title: Text('Currently working here'),
                                        ),
                                        SizedBox(height: 5),
                                        DropdownButtonFormField<String>(
                                          menuMaxHeight: 400,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.red),
                                            ),
                                            hintText: 'Team Size',
                                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14 * ScaleSize.textScaleFactor(context)),
                                            fillColor: Theme.of(context).colorScheme.surfaceContainer,
                                            filled: true,
                                          ),
                                          isExpanded: true,
                                          value: ref.watch(selectedTeamSizeProvider),
                                          onChanged: (String? newValue) {
                                            ref.read(selectedTeamSizeProvider.notifier).state = newValue;
                                          },
                                          items: ref.watch(teamSizeDataProvider).map<DropdownMenuItem<String>>((item) {
                                            return DropdownMenuItem<String>(
                                              value: item.value,
                                              child: Text(
                                                item.label,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                              ),
                                              onPressed: companyOnPressed,
                                              child: Text('Add Company'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Theme.of(context).colorScheme.secondary,
                                              ),
                                              onPressed: () {
                                                GoRouter.of(context).pop();
                                              },
                                              child: Text('Close'),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 25),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.add_circled_solid,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: userProfileData?.experience?.length,
              itemBuilder: (context, index) {
                final userColor = _generateUserColor(userProfileData, index);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: userColor,
                        radius: 25 * ScaleSize.textScaleFactor(context),
                        child: Text(
                          userProfileData?.experience?[index].worksAt?[0].toUpperCase() ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: ScreenSize.width(context) * 0.76,
                            child: Row(
                              children: [
                                Text(
                                  userProfileData?.experience?[index].post ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                ),
                                Spacer(),
                                Text(
                                  'Team Size',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: ScreenSize.width(context) * 0.76,
                            child: Row(
                              children: [
                                Text(
                                  userProfileData?.experience?[index].worksAt ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                ),
                                Spacer(),
                                Text(
                                  userProfileData?.experience?[index].teamSize ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      );
  }

  Color _generateUserColor(UserProfileModel? userProfileData, int? index) {
    final random = math.Random(userProfileData?.experience?[index!].worksAt!.hashCode);
    return Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7);
  }
}
