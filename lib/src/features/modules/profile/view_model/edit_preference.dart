import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/settings/model/repositories/filter_repository.dart';
import 'package:birds_learning_network/src/features/core/settings/model/request_model/save_preference.dart';
import 'package:birds_learning_network/src/features/core/settings/model/response_model/get_preference.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/device_info.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/success_dialog.dart';
import 'package:flutter/material.dart';

class PreferenceProvider extends ChangeNotifier {
  bool _doneClicked = false;
  List<String> _myList = [];
  List<String> _prefList = [];
  final List<String> _userPrefList = [];
  List<bool> selectedCards = [];
  FilterRepository repo = FilterRepository();

  bool get doneClicked => _doneClicked;
  List<String> get myList => _myList;
  List<String> get userPrefList => _userPrefList;
  List<String> get prefList => _prefList;

  void onDoneClick() {
    _doneClicked = !_doneClicked;
    notifyListeners();
  }

  void addPref(String pref) {
    _userPrefList.add(pref);
    notifyListeners();
  }

  void removePref(String pref) {
    _userPrefList.remove(pref);
    notifyListeners();
  }

  void setValue(int index) {
    selectedCards[index] = !selectedCards[index];
    notifyListeners();
  }

  Future getPreferenceList(context) async {
    try {
      _myList = [];
      selectedCards = [];
      List<PreferenceResponseData>? prefList =
          await repo.getFilterData(context);
      if (prefList != null && prefList.isNotEmpty) {
        for (PreferenceResponseData val in prefList) {
          _myList.add(val.name!);
          notifyListeners();
        }
      }
      notifyListeners();
    } catch (_) {
      showSnack(context, "02", "Unable to get course categories");
    }
  }

  Future getUserPreferenceList(context) async {
    try {
      _prefList = [];
      List<String>? prefList = await repo.getUserFilterData(context);
      if (prefList != null && prefList.isNotEmpty) {
        _prefList = prefList;
      }
      notifyListeners();
    } catch (_) {
      print(_);
      showSnack(context, "02", "Unable to get course categories");
    }
  }

  Future postPreferenceList(context) async {
    try {
      String email = await UserPreferences.getUserEmail();
      String deviceId = await DevicePreference.getDeviceId();
      SavePreferenceModel data = SavePreferenceModel(
          userEmail: email, deviceId: deviceId, preferenceList: _userPrefList);

      String code = await repo.saveUserPreference(context, data);
      doneClicked ? onDoneClick() : null;
      if (code == "00") {
        successDialog(
            context, "Successful!", "Preferences successfully saved", "OK", () {
          RoutingService.popRouting(context);
          RoutingService.popRouting(context);
        });
      }
    } catch (e) {
      doneClicked ? onDoneClick() : null;
    }
  }
}
