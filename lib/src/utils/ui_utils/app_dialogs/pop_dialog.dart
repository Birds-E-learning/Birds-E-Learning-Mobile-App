import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

 Future getPopScopeDialog(context) async {
  return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        contentPadding: const EdgeInsets.all(24),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Leave App",
              maxLines: 2,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: success600),),
             SizedBox(height: 10),
            Center(
              child: Icon(Icons.warning_sharp,
                  color: redAccent,
                  size: 80),
            ),
             SizedBox(height: 10),
             Text(
              "Do you wish to leave the screen?",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: black
              ),
            )
          ],
        ),
        actionsPadding: const EdgeInsets.only(right: 24),
        actions: [
          TextButton(
              onPressed: ()=> Navigator.pop(context, false),
              child: const Text(
                  "CANCEL", style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 14, color: skipColor,
                  fontFamily: "Inter"
              ),)),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("LEAVE", style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14, color: skipColor,
                fontFamily: "Inter"
            ),),
          )
        ],
      )
  );
}
