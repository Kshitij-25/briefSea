import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../common/app_utils/screen_size.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../widgets/custom_text_form_field.dart';

class ClientWorkCard extends StatelessWidget {
  ClientWorkCard({
    this.userProfileData,
    required this.clientName,
    required this.startDate,
    required this.endDate,
    required this.clientPortfolio,
    this.clientOnPressed,
    this.isOtherProfile,
  });

  final UserProfileModel? userProfileData;
  final bool? isOtherProfile;

  final TextEditingController clientName;
  final TextEditingController startDate;
  final TextEditingController endDate;
  final TextEditingController clientPortfolio;

  final void Function()? clientOnPressed;

  @override
  Widget build(BuildContext context) {
    bool isCurrentlyWorking = true;
    DateTime? selectedStartDate;

    if (userProfileData?.clients?.isEmpty == true)
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Clients Worked With',
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
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Add New Client',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                    ),
                                    CustomTextFormField(
                                      hintText: 'Enter the name of client or company',
                                      controller: clientName,
                                    ),
                                    SizedBox(height: 5),
                                    CustomTextFormField(
                                      hintText: 'Start Date',
                                      controller: startDate,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now(),
                                        );

                                        setState(() {
                                          selectedStartDate = pickedDate;
                                          startDate.text = "${pickedDate!.toLocal()}".split(' ')[0];
                                        });
                                      },
                                    ),
                                    SizedBox(height: 5),
                                    if (isCurrentlyWorking != true)
                                      CustomTextFormField(
                                        hintText: 'End Date',
                                        controller: endDate,
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: selectedStartDate!,
                                            lastDate: DateTime.now(),
                                          );

                                          setState(() {
                                            endDate.text = "${pickedDate!.toLocal()}".split(' ')[0];
                                          });
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
                                    CustomTextFormField(
                                      hintText: 'Portfolio link',
                                      controller: clientPortfolio,
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FilledButton(
                                          style: FilledButton.styleFrom(
                                            backgroundColor: Theme.of(context).colorScheme.secondary,
                                          ),
                                          onPressed: clientOnPressed,
                                          child: Text('Add Client'),
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
                    'No clients available for now!',
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
                  'Clients Worked With',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
                SizedBox(width: 10),
                Text(
                  userProfileData?.clients?.length != null
                      ? (userProfileData!.clients!.length < 5
                          ? '< 5'
                          : userProfileData!.clients!.length < 10
                              ? '< 10'
                              : '≥ 10')
                      : '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
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
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Add New Client',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                    ),
                                    CustomTextFormField(
                                      hintText: 'Enter the name of client or company',
                                      controller: clientName,
                                    ),
                                    SizedBox(height: 5),
                                    CustomTextFormField(
                                      hintText: 'Start Date',
                                      controller: startDate,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now(),
                                        );

                                        setState(() {
                                          selectedStartDate = pickedDate;
                                          startDate.text = "${pickedDate!.toLocal()}".split(' ')[0];
                                        });
                                      },
                                    ),
                                    SizedBox(height: 5),
                                    if (isCurrentlyWorking != true)
                                      CustomTextFormField(
                                        hintText: 'End Date',
                                        controller: endDate,
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: selectedStartDate!,
                                            lastDate: DateTime.now(),
                                          );

                                          setState(() {
                                            endDate.text = "${pickedDate!.toLocal()}".split(' ')[0];
                                          });
                                        },
                                      ),
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
                                    SizedBox(height: 5),
                                    CustomTextFormField(
                                      hintText: 'Portfolio link',
                                      controller: clientPortfolio,
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FilledButton(
                                          style: FilledButton.styleFrom(
                                            backgroundColor: Theme.of(context).colorScheme.secondary,
                                          ),
                                          onPressed: clientOnPressed,
                                          child: Text('Add Client'),
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
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              dense: true,
              shape: RoundedRectangleBorder(side: BorderSide.none),
              trailing: userProfileData?.clients?.length == 1 ? SizedBox.shrink() : null,
              enabled: userProfileData?.experience?.length == 1 ? false : true,
              leading: CircleAvatar(
                backgroundColor: _generateUserColor(userProfileData, 0),
                radius: 25 * ScaleSize.textScaleFactor(context),
                child: Text(
                  userProfileData?.clients?.first.company?[0].toUpperCase() ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
              ),
              title: Text(
                userProfileData?.clients?.first.company ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 15,
                ),
                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
              ),
              subtitle: Text(
                calculateDuration(userProfileData!.clients!.first.startDate!, userProfileData!.clients!.first.endDate),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
              ),
              enableFeedback: true,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (userProfileData?.clients?.length ?? 1) - 1,
                  itemBuilder: (context, index) {
                    final client = userProfileData?.clients?[index + 1];
                    final userColor = _generateUserColor(userProfileData, index);
                    return ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      enabled: false,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      trailing: SizedBox.shrink(),
                      leading: CircleAvatar(
                        backgroundColor: userColor,
                        radius: 25 * ScaleSize.textScaleFactor(context),
                        child: Text(
                          client?.company?[0].toUpperCase() ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                        ),
                      ),
                      title: Text(
                        client?.company ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                      subtitle: Text(
                        calculateDuration(client!.startDate!, client.endDate),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                      enableFeedback: true,
                      dense: true,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
  }

  Color _generateUserColor(UserProfileModel? userProfileData, int? index) {
    final random = math.Random(userProfileData?.clients?[index!].company!.hashCode);
    return Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7);
  }

  String calculateDuration(String startDateStr, [String? endDateStr]) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    try {
      DateTime startDate = dateFormat.parse(startDateStr);
      DateTime endDate = endDateStr != null ? dateFormat.parse(endDateStr) : DateTime.now();
      int years = endDate.year - startDate.year;
      int months = endDate.month - startDate.month;
      if (months < 0) {
        years--;
        months += 12;
      }
      if (years == 0 && months == 0) {
        months = 1;
      }
      String durationMessage;
      if (years > 0 && months > 0) {
        durationMessage = '$years years and $months months';
      } else if (years > 0) {
        durationMessage = '$years years';
      } else if (months == 1 || months == 0) {
        durationMessage = '$months month';
      } else {
        durationMessage = '$months months';
      }
      return durationMessage;
    } catch (e) {
      print('Error parsing dates: $e');
      return 'Invalid dates';
    }
  }
}
