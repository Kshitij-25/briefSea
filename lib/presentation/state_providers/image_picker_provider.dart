import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedAvatarImageProvider = StateProvider.autoDispose<String?>((ref) => null);

final newAvatarUploadedProvider = StateProvider.autoDispose<bool?>((ref) => false);

final newBannerUploadedProvider = StateProvider.autoDispose<bool?>((ref) => false);

final verifyAvatarImageProvider = StateProvider.autoDispose<File?>((ref) => null);

final selectedBannerImageProvider = StateProvider.autoDispose<String?>((ref) => null);

final verifyBannerImageProvider = StateProvider.autoDispose<File?>((ref) => null);

final selectedPostImageProvider = StateProvider.autoDispose<File?>((ref) => null);

final uploadedAvatarKeyProvider = StateProvider.autoDispose<String?>((ref) => null);

final uploadedBannerKeyProvider = StateProvider.autoDispose<String?>((ref) => null);

final uploadedThreadImageKeyProvider = StateProvider.autoDispose<String?>((ref) => null);
