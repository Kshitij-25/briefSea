import 'package:hooks_riverpod/hooks_riverpod.dart';

final briefsTabIndexProvider = StateProvider<int>((ref) => 0);

class SelectedBriefsFilter extends StateNotifier<String> {
  SelectedBriefsFilter() : super('All');

  void setFilter(String filter) {
    state = filter;
  }
}

final selectedBriefsFilter = StateNotifierProvider<SelectedBriefsFilter, String>((ref) {
  return SelectedBriefsFilter();
});
