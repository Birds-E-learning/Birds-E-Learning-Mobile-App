import 'package:birds_learning_network/src/features/modules/profile/model/repository/profile_repository.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/request_model/change_password_model.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/success_dialog.dart';
import 'package:flutter/material.dart';

class ChangePasswordProvider extends ChangeNotifier {
  bool _showNewPassword = false;
  bool _showOldPassword = false;
  bool _showConfirmPassword = false;
  bool _updateClicked = false;

  bool get showNewPassword => _showNewPassword;
  bool get updateClicked => _updateClicked;
  bool get showOldPassword => _showOldPassword;
  bool get showConfirmPassword => _showConfirmPassword;

  void onOldPasswordClick() {
    _showOldPassword = !_showOldPassword;
    notifyListeners();
  }

  void onNewPasswordClick() {
    _showNewPassword = !_showNewPassword;
    notifyListeners();
  }

  void onUpdateClick() {
    _updateClicked = !_updateClicked;
    notifyListeners();
  }

  void onConfirmPasswordClick() {
    _showConfirmPassword = !_showConfirmPassword;
    notifyListeners();
  }

  Future changeUserPassword(
      context, String oldPassword, String newPassword) async {
    try {
      ChangePasswordModel data = ChangePasswordModel(
          oldPassword: oldPassword, newPassword: newPassword);
      String response =
          await ProfileRepository().changePasswordRepo(context, data);
      if (response == "00") {
        updateClicked ? onUpdateClick() : null;
        successDialog(
            context, "Successful!", "Password successfuly changed", "OK", () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
    } catch (e) {
      updateClicked ? onUpdateClick() : null;
    }
  }
}
