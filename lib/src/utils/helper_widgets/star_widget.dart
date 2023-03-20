import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> getStarList(value, String icon1, String icon2, {double size = 8}) {
  List<Widget> starList = [];
  for (var i = 0; i < int.parse(value); i++) {
    starList.add(SvgPicture.asset(icon1, height: size, width: size));
  }
  if (5 - int.parse(value) != 0) {
    for (var j = 0; j < (5 - int.parse(value)); j++) {
      starList.add(SvgPicture.asset(icon2, height: size, width: size));
    }
  }
  return starList;
}
