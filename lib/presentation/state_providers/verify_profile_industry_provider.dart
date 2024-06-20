import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedIndustriesProvider = StateProvider<List<String>>((ref) => []);

final selectedExpertiseProvider = StateProvider<List<String>>((ref) => []);

final selectedGenderProvider = ChangeNotifierProvider((ref) => SelectedGender());

class SelectedGender extends ChangeNotifier {
  String? selectedGender;
  final List<String> genders = ["Male", "Female", "Others"];

  void setGender(String gen) {
    selectedGender = gen;
    notifyListeners();
  }
}
