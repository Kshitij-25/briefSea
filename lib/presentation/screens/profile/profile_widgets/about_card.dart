import 'package:flutter/material.dart';

import '../../../../common/app_utils/screen_size.dart';
import '../../../../data/models/user_profile_model.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({this.userProfileData});

  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'About',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
              ),
              Spacer(),
              Text(
                'Exp :',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
              ),
              Text(
                ' ${userProfileData?.expDuration ?? 'NA'}',
                style: const TextStyle(
                  color: Colors.black,
                ),
                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
              ),
            ],
          ),
          Text(
            userProfileData?.aboutMe ?? '',
            maxLines: 1000,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          ),
        ],
      ),
    );
  }
}
