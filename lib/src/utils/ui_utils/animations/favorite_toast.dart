import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showToast(context, GlobalKey keyGlobal) {
  // RenderBox box = keyGlobal.currentContext!.findRenderObject() as RenderBox;
  // Offset position = box.localToGlobal(Offset.zero); //this is global position
  return Fluttertoast.showToast(
    msg: "Course added!",
    gravity: ToastGravity.CENTER,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: greys600,
  );
}
