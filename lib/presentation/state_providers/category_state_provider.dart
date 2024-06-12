import 'package:hooks_riverpod/hooks_riverpod.dart';

final isCategoryVisibleProvider = StateProvider<bool>((ref) => false);

final selectedCategoryProvider = StateProvider<String>((ref) => "");
