import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  bool _payClicked = false;
  bool _isChecked = false;

  bool get payClicked => _payClicked;
  bool get isChecked => _isChecked;

  void onPayClick() {
    _payClicked = !_payClicked;
    notifyListeners();
  }

  void onCheckClick(value) {
    _isChecked = value;
    notifyListeners();
  }
}
