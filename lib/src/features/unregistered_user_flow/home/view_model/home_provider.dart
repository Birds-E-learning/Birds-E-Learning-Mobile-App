import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view/screens/home_page.dart';
import 'package:flutter/cupertino.dart';

class UnregisteredHomeProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const UnregisteredUserHomePage(),
    Container(),
   Container(),
    Container()
  ];

  List<Widget> get screens => _widgetOptions;
  int get selectedIndex => _selectedIndex;

  set onItemClick(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

}