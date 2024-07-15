import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../common/static_data/expertise_data.dart';

final selectedIndustriesProvider = StateProvider<List<String>>((ref) => []);

final selectedDevExpertiseProvider = StateProvider<List<String>>((ref) => []);

final devExpertiseItemsProvider = StateProvider<List<MultiSelectItem<String?>>>((ref) {
  return techExpertiseData.map((item) => MultiSelectItem<String?>(item['value'], item['label']!)).toList();
});

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
