import 'dart:io';

class VerifyProfileParams {
  final String userId;
  final Map<String, dynamic>? specificFields;
  final Map<String, dynamic>? fullProfileData;

  VerifyProfileParams({
    required this.userId,
    this.specificFields,
    this.fullProfileData,
  });
}

class EditProfileParams {
  final String userId;
  final Map<String, dynamic>? specificFields;
  final Map<String, dynamic>? fullProfileData;

  EditProfileParams({
    required this.userId,
    this.specificFields,
    this.fullProfileData,
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
