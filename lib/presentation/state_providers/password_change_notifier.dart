import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final passwordNotifierProvider = ChangeNotifierProvider<PassNotifier>((ref) => PassNotifier());

class PassNotifier extends ChangeNotifier {
  bool _obscureAgencyPassword = true;
  bool get obscureAgencyPassword => _obscureAgencyPassword;
  set obscureAgencyPassword(bool obscureText) {
    _obscureAgencyPassword = obscureText;
    notifyListeners();
  }

  bool _obscureAgencyConfirmPassword = true;
  bool get obscureAgencyConfirmPassword => _obscureAgencyConfirmPassword;
  set obscureAgencyConfirmPassword(bool obscureAgencyConfirmPassword) {
    _obscureAgencyConfirmPassword = obscureAgencyConfirmPassword;
    notifyListeners();
  }

  bool _obscureFreelancerPassword = true;
  bool get obscureFreelancerPassword => _obscureFreelancerPassword;
  set obscureFreelancerPassword(bool obscureText) {
    _obscureFreelancerPassword = obscureText;
    notifyListeners();
  }

  bool _obscureFreelancerConfirmPassword = true;
  bool get obscureFreelancerConfirmPassword => _obscureFreelancerConfirmPassword;
  set obscureFreelancerConfirmPassword(bool obscureFreelancerConfirmPassword) {
    _obscureFreelancerConfirmPassword = obscureFreelancerConfirmPassword;
    notifyListeners();
  }

  bool _obscureWPPassword = true;
  bool get obscureWPPassword => _obscureWPPassword;
  set obscureWPPassword(bool obscureText) {
    _obscureWPPassword = obscureText;
    notifyListeners();
  }

  bool _obscureWPConfirmPassword = true;
  bool get obscureWPConfirmPassword => _obscureWPConfirmPassword;
  set obscureWPConfirmPassword(bool obscureWPConfirmPassword) {
    _obscureWPConfirmPassword = obscureWPConfirmPassword;
    notifyListeners();
  }

  bool _obscureExistingPassword = true;
  bool get obscureExistingPassword => _obscureExistingPassword;
  set obscureExistingPassword(bool obscureText) {
    _obscureExistingPassword = obscureText;
    notifyListeners();
  }
}
