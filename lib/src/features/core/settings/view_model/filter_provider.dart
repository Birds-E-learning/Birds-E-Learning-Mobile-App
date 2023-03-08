import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  Color _color = grey700;
  Color _backgroundColor = white;
  List<bool> selectedCards = [];
  final List<String> _myList = [
    "Technology",
    "Education",
    "Science",
    "Engineering",
    "Health",
    "Fashion",
    "IT & Software"
  ];
  int selectedIndex = -1;

  Color get color => _color;
  Color get backgroundColor => _backgroundColor;
  List<String> get myList => _myList;

  void onCardClick() {
    if (_color == grey700) {
      _backgroundColor = grey700;
      _color = white;
      notifyListeners();
    } else {
      _color = grey700;
      _backgroundColor = white;
      notifyListeners();
    }
  }

  void setValue(index) {
    selectedCards[index] = !selectedCards[index];
    notifyListeners();
  }

  void getIndex(index) {
    selectedIndex = index;
    notifyListeners();
  }
}
