import 'package:briefsea/common/static_data/service_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../common/static_data/expertise_data.dart';
import '../../common/static_data/post_data.dart';
import '../../common/static_data/team_size.dart';

final selectedIndustriesProvider = StateProvider<List<String>>((ref) => []);

final selectedDevExpertiseProvider = StateProvider<List<String>>((ref) => []);

final selectedServicesProvider = StateProvider<List<String>>((ref) => []);

final devExpertiseItemsProvider = StateProvider<List<MultiSelectItem<String?>>>((ref) {
  return techExpertiseData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

final servicesItemsProvider = StateProvider<List<MultiSelectItem<String?>>>((ref) {
  return serviceData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

final postListDataProvider = StateProvider<List<MultiSelectItem<String?>>>((ref) {
  return postListData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

final selectedPostProvider = StateProvider<String?>((ref) => null);

final teamSizeDataProvider = StateProvider<List<MultiSelectItem<String?>>>((ref) {
  return teamSizeOptions.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

final selectedTeamSizeProvider = StateProvider<String?>((ref) => null);

final selectedMarkExpertiseProvider = StateProvider<List<String>>((ref) => []);

final markExpertiseItemsProvider = StateProvider<List<MultiSelectItem<String?>>>((ref) {
  return marketingExpertiseData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

final selectedGenderProvider = ChangeNotifierProvider((ref) => SelectedGender());

class SelectedGender extends ChangeNotifier {
  String? selectedGender;
  final List<String> genders = ["Male", "Female", "Others"];

  void setGender(String gen) {
    selectedGender = gen;
    notifyListeners();
  }
}
