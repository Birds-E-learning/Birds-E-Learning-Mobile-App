import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/settings/model/repositories/filter_repository.dart';
import 'package:birds_learning_network/src/features/core/settings/model/request_model/save_preference.dart';
import 'package:birds_learning_network/src/features/core/settings/model/response_model/get_preference.dart';
import 'package:birds_learning_network/src/features/core/settings/model/response_model/save_pref_response.dart';
import 'package:birds_learning_network/src/features/core/settings/view/filter/get_started_screen.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/device_info.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  List<bool> selectedCards = [];
  List<String> _myList = [];
  final List<String> _userPrefList = [];
  int selectedIndex = -1;
  FilterRepository repo = FilterRepository();
  bool _buttonClicked = false;

  bool get buttonClicked => _buttonClicked;
  List<String> get myList => _myList;
  List<String> get userPrefList => _userPrefList;

  // void onCardClick() {
  //   if (_color == grey700) {
  //     _backgroundColor = grey700;
  //     _color = white;
  //     notifyListeners();
  //   } else {
  //     _color = grey700;
  //     _backgroundColor = white;
  //     notifyListeners();
  //   }
  // }

  void setValue(index) {
    selectedCards[index] = !selectedCards[index];
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

  void getIndex(index) {
    selectedIndex = index;
    notifyListeners();
  }

  void onButtonClick() {
    _buttonClicked = !_buttonClicked;
    notifyListeners();
  }

  Future getPreferenceList(context) async {
    try {
      List<PreferenceResponseData>? prefList =
          await repo.getFilterData(context);
      if (prefList != null && prefList.isNotEmpty) {
        for (PreferenceResponseData val in prefList) {
          _myList.add(val.name!);
          notifyListeners();
        }
        print(_myList);
      }
      notifyListeners();
    } catch (_) {
      _myList = ["Technology", "Fashion", "health", "Design", "IT & Software"];
    }
  }

  Future postPreferenceList(context) async {
    try {
      String email = await UserPreferences.getUserEmail();
      String deviceId = await DevicePreference.getDeviceId();
      SavePreferenceModel data = SavePreferenceModel(
          userEmail: email, deviceId: deviceId, preferenceList: _userPrefList);

      String code = await repo.saveUserPreference(context, data);
      buttonClicked ? onButtonClick() : null;
      if (code == "00") {
        RoutingService.pushAndRemoveAllRoute(context, const GetStartedPage());
      }
    } catch (e) {
      print(e);
      buttonClicked ? onButtonClick() : null;
    }
  }
}
