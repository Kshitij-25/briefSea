import 'package:flutter/material.dart';

import '../../../../common/app_utils/screen_size.dart';
import '../../../../data/models/user_profile_model.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({this.userProfileData});

  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Services',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          ),
          Wrap(
            spacing: 5,
            alignment: WrapAlignment.start,
            children: userProfileData!.services!
                .map(
                  (services) => Chip(
                    visualDensity: VisualDensity.compact,
                    label: Text(
                      services,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
