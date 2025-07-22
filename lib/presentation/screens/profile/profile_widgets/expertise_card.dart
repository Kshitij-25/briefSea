import 'package:flutter/material.dart';

import '../../../../common/app_utils/screen_size.dart';
import '../../../../data/models/user_profile_model.dart';

class ExpertiseCard extends StatelessWidget {
  const ExpertiseCard({this.userProfileData});

  final UserProfileModel? userProfileData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Industries, Expertise',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: userProfileData?.industry?.length,
            itemBuilder: (context, index) {
              final industry = userProfileData!.industry![index];
              final expertiseList = industry == 'Development & Product' ? userProfileData!.devExpertise ?? [] : userProfileData!.markExpertise ?? [];

              return ExpansionTile(
                dense: true,
                shape: RoundedRectangleBorder(side: BorderSide.none),
                title: Text(
                  industry,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                ),
                enableFeedback: true,
                tilePadding: EdgeInsets.zero,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 5,
                      alignment: WrapAlignment.start,
                      children: expertiseList
                          .map(
                            (expertise) => Chip(
                              visualDensity: VisualDensity.compact,
                              label: Text(
                                expertise,
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
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
