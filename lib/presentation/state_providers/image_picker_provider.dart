// Provider to manage selected image state
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedAvatarImageProvider = StateProvider<String?>((ref) => null);

final verifyAvatarImageProvider = StateProvider<File?>((ref) => null);

final selectedBannerImageProvider = StateProvider<String?>((ref) => null);

final verifyBannerImageProvider = StateProvider<File?>((ref) => null);

final selectedPostImageProvider = StateProvider<File?>((ref) => null);

final uploadedAvatarKeyProvider = StateProvider<String?>((ref) => null);

final uploadedBannerKeyProvider = StateProvider<String?>((ref) => null);

final uploadedThreadImageKeyProvider = StateProvider<String?>((ref) => null);

final uploadedAvatarUrlProvider = StateProvider<String?>((ref) => null);

final uploadedBannerUrlProvider = StateProvider<String?>((ref) => null);

final hoverProvider = StateProvider<bool>((ref) => false);
