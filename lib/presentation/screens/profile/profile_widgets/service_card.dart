import 'package:flutter/material.dart';

import '../../../../common/app_utils/screen_size.dart';
import '../../../../data/models/user_profile_model.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({this.userProfileData});

  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context) {
    // Get the services list or default to an empty list if null
    final services = userProfileData?.services ?? [];

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
            children: services.isNotEmpty
                ? services
                    .map(
                      (service) => Chip(
                        visualDensity: VisualDensity.compact,
                        label: Text(
                          service,
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
                    .toList()
                : [Text('No services available', style: const TextStyle(color: Colors.grey))],
          ),
        ],
      ),
    );
  }
}
