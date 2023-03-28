import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

Future<void> showToast(context, GlobalKey keyGlobal) {
  RenderBox box = keyGlobal.currentContext!.findRenderObject() as RenderBox;
  Offset position = box.localToGlobal(Offset.zero); //this is global position
  return showFlash(
      context: context,
      duration: const Duration(milliseconds: 1000),
      builder: (context, controller) {
        return Flash.dialog(
            controller: controller,
            margin: EdgeInsets.only(top: position.dy, left: position.dx),
            alignment: Alignment.topCenter,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            backgroundColor: greys600,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Course added!",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: white),
              ),
            ));
      });
}
