// Provider to manage selected image state
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedAvatarImageProvider = StateProvider<String?>((ref) => null);

final selectedBannerImageProvider = StateProvider<String?>((ref) => null);

// Define the provider for the selected image
final selectedPostImageProvider = StateProvider<File?>((ref) => null);

final uploadedAvatarKeyProvider = StateProvider<String?>((ref) => null);

final uploadedBannerKeyProvider = StateProvider<String?>((ref) => null);

final uploadedThreadImageKeyProvider = StateProvider<String?>((ref) => null);

final uploadedAvatarUrlProvider = StateProvider<String?>((ref) => null);

final uploadedBannerUrlProvider = StateProvider<String?>((ref) => null);

final hoverProvider = StateProvider<bool>((ref) => false);
