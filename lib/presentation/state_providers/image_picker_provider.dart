import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedAvatarImageProvider = StateProvider.autoDispose<String?>((ref) => null);

final newAvatarUploadedProvider = StateProvider.autoDispose<bool?>((ref) => false);

final newBannerUploadedProvider = StateProvider.autoDispose<bool?>((ref) => false);

final verifyAvatarImageProvider = StateProvider<File?>((ref) => null);

final selectedBannerImageProvider = StateProvider.autoDispose<String?>((ref) => null);

final verifyBannerImageProvider = StateProvider<File?>((ref) => null);

final selectedPostImageProvider = StateProvider<File?>((ref) => null);

final uploadedAvatarKeyProvider = StateProvider<String?>((ref) => null);

final uploadedBannerKeyProvider = StateProvider<String?>((ref) => null);

final uploadedThreadImageKeyProvider = StateProvider<String?>((ref) => null);
