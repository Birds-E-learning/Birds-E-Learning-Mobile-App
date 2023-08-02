import 'package:birds_learning_network/src/features/core/settings/model/repositories/filter_repository.dart';
import 'package:birds_learning_network/src/features/core/settings/model/response_model/get_preference.dart';
import 'package:flutter/material.dart';

class HomePreferenceProvider extends ChangeNotifier {
  FilterRepository repo = FilterRepository();
  List _myList = [];

  bool _isLoading = false;

  List get prefList => _myList;
  bool get isLoading => _isLoading;

  Future getPreferenceList(context) async {
    try {
      List<String> list = [];
      _isLoading = true;
      notifyListeners();
      List<PreferenceResponseData>? prefList_ =
          await repo.getFilterData(context);
      if (prefList_ != null && prefList_.isNotEmpty) {
        for (PreferenceResponseData val in prefList_) {
          list.add(val.name!);
        }
        _myList = list;
        notifyListeners();
      }
      _isLoading = false;
      notifyListeners();
    } catch (_) {
      _isLoading = false;
      notifyListeners();
    }
  }

}
