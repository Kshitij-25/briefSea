import 'package:briefsea/common/static_data/service_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../common/static_data/expertise_data.dart';
import '../../common/static_data/post_data.dart';
import '../../common/static_data/team_size.dart';

final selectedIndustriesProvider = StateProvider.autoDispose<List<String>>((ref) => []);

final selectedDevExpertiseProvider = StateProvider.autoDispose<List<String>>((ref) => []);

final selectedServicesProvider = StateProvider.autoDispose<List<String>>((ref) => []);

final devExpertiseItemsProvider = StateProvider.autoDispose<List<MultiSelectItem<String?>>>((ref) {
  return techExpertiseData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

final servicesItemsProvider = StateProvider.autoDispose<List<MultiSelectItem<String?>>>((ref) {
  return serviceData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

final postListDataProvider = StateProvider.autoDispose<List<MultiSelectItem<String?>>>((ref) {
  return postListData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

final selectedPostProvider = StateProvider.autoDispose<String?>((ref) => null);

final teamSizeDataProvider = StateProvider.autoDispose<List<MultiSelectItem<String?>>>((ref) {
  return teamSizeOptions.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

final selectedTeamSizeProvider = StateProvider.autoDispose<String?>((ref) => null);

final selectedMarkExpertiseProvider = StateProvider.autoDispose<List<String>>((ref) => []);

final markExpertiseItemsProvider = StateProvider.autoDispose<List<MultiSelectItem<String?>>>((ref) {
  return marketingExpertiseData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

final selectedGenderProvider = ChangeNotifierProvider.autoDispose((ref) => SelectedGender());

class SelectedGender extends ChangeNotifier {
  String? selectedGender;
  final List<String> genders = ["Male", "Female", "Others"];

  void setGender(String gen) {
    selectedGender = gen;
    notifyListeners();
  }
}

final selectAccountTypeProvider = ChangeNotifierProvider.autoDispose((ref) => SelectAccountType());

class SelectAccountType extends ChangeNotifier {
  String? selectedType;

  final List<String> accountType = ["Agency", "Freelancer", "Working professional"];

  void setAccountType(String type) {
    selectedType = type;
    notifyListeners();
  }
}
