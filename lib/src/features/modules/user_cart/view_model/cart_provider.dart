import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses_pref.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CoursesPref> _myCart = [];
  List<CoursesPref> _wishlist = [];

  List<CoursesPref> get myCartList => _myCart;
  List<CoursesPref> get wishlist => _wishlist;

  void addvalue() {
    _myCart.add(CoursesPref());
    notifyListeners();
  }
}
