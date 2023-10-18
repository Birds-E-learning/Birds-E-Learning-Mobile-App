import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> getStarList(dynamic val, String icon1, String icon2,
    {double size = 8}) {
  int newVal = int.parse(val.toString()) > 5 ? 5 : int.parse(val.toString());
  List<Widget> starList = [];
  String value = val.toString();
  for (var i = 0; i < newVal; i++) {
    starList.add(SvgPicture.asset(icon1, height: size, width: size));
  }
  if (5 - int.parse(value) != 0) {
    for (var j = 0; j < (5 - newVal); j++) {
      starList.add(SvgPicture.asset(icon2, height: size, width: size));
    }
  }
  return starList;
}

List<Widget> getStarListIcon(dynamic val, Color color, {double size = 12}) {
  List<Widget> starList = [];
  int newVal = int.parse(val) > 5 ? 5 : int.parse(val);
  String value = val.toString();
  for (var i = 0; i < newVal; i++) {
    starList.add(Icon(Icons.star, size: size, color: color));
  }
  if (5 - int.parse(value) != 0) {
    for (var j = 0; j < (5 - newVal); j++) {
      starList.add(Icon(Icons.star_border_sharp, size: size, color: color));
    }
  }
  return starList;
}
