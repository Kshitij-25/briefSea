import 'package:flutter/foundation.dart' show immutable;

@immutable
class Assets {
  const Assets._();

  static const APP_LOGO = 'assets/logos/IMG_9485.PNG';
  static const GOOGLE_LOGO = 'assets/icons/google-icon.svg';
  static const INSTA_LOGO = 'assets/icons/insta.svg';
  static const PROFILE_LINKEDIN = 'assets/icons/linkedin.svg';
  static const LINKEDIN_LOGO = 'assets/icons/linkedin-icon.svg';
  static const X_LOGO = 'assets/icons/x.svg';
  static const MALE = 'assets/icons/male.png';
  static const FEMALE = 'assets/icons/female.png';
  static const OTHERS = 'assets/icons/team.png';
  static const PERSON = 'assets/icons/person.png';
  static const BANNER = 'assets/logos/default-banner.jpg';
  static const COMPANY_ICON = 'assets/icons/company.svg';
  static const logoSmall = 'assets/logos/logo_small.png';

  // List of assets for MALE and FEMALE
  static const List<String> MALE_ASSETS = [
    'assets/icons/boy.png',
    'assets/icons/bussiness-man.png',
    'assets/icons/man-2.png',
    'assets/icons/man-3.png',
    'assets/icons/man-4.png',
    'assets/icons/man.png',
    'assets/icons/write.png',
    'assets/icons/writing.png',
  ];

  static const List<String> FEMALE_ASSETS = [
    'assets/icons/female-user.png',
    'assets/icons/woman-2.png',
    'assets/icons/woman-3.png',
    'assets/icons/woman-4.png',
    'assets/icons/woman-5.png',
    'assets/icons/woman-6.png',
    'assets/icons/woman.png',
    'assets/icons/worker.png',
  ];
}
