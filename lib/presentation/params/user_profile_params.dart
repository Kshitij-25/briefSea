import 'dart:io';

class VerifyProfileParams {
  final String? userId;
  final String? uName;
  final int? countryCode;
  final int? contact;
  final String? jobTitle;
  final String? company;
  final List<String>? industry;
  final List<String>? devExpertise;
  final List<String>? markExpertise;
  final String? location;
  final String? avatarSrc;
  final String? bannerSrc;
  final String? jwtToken;
  final String? postingAs;
  final String? gender;
  final String? username;
  final String? aboutMe;

  VerifyProfileParams({
    required this.userId,
    required this.uName,
    required this.countryCode,
    required this.contact,
    required this.jobTitle,
    required this.company,
    required this.industry,
    required this.devExpertise,
    required this.markExpertise,
    required this.location,
    required this.avatarSrc,
    required this.bannerSrc,
    required this.jwtToken,
    required this.postingAs,
    required this.gender,
    required this.username,
    required this.aboutMe,
  });
}

class EditProfileParams {
  final String? userId;
  final String? uName;
  final int? countryCode;
  final int? contact;
  final String? jobTitle;
  final String? company;
  final List<String>? industry;
  final List<String>? devExpertise;
  final List<String>? markExpertise;
  final String? location;
  final String? avatarSrc;
  final String? bannerSrc;
  final String? jwtToken;
  final String? postingAs;
  final String? gender;
  final String? createdAt;
  final String? updatedAt;
  final String? userName;
  final bool? viewAccess;
  final String? aboutMe;

  EditProfileParams({
    required this.userId,
    required this.uName,
    required this.countryCode,
    required this.contact,
    required this.jobTitle,
    required this.company,
    required this.industry,
    required this.devExpertise,
    required this.markExpertise,
    required this.location,
    required this.avatarSrc,
    required this.bannerSrc,
    required this.jwtToken,
    required this.postingAs,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.viewAccess,
    required this.aboutMe,
  });
}

class UploadAvatarParams {
  final String? fileName;
  final String? fileType;
  final String? userId;
  final String? userType;

  UploadAvatarParams({
    required this.fileName,
    required this.fileType,
    required this.userId,
    required this.userType,
  });
}

class UploadBannerParams {
  final String? fileName;
  final String? fileType;
  final String? userId;
  final String? userType;

  UploadBannerParams({
    required this.fileName,
    required this.fileType,
    required this.userId,
    required this.userType,
  });
}

class UploadToAWSParams {
  final String? url;
  final String? fileName;
  final File file;
  final String? fileType;

  UploadToAWSParams({
    required this.url,
    required this.fileName,
    required this.file,
    required this.fileType,
  });
}
