import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

void getFailedDialog(String text, context) async {
  return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Row(
                  children:  [
                 Row(
                  children: [
                    GestureDetector(
                      onTap: ()=> Navigator.pop(context),
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 40),
                    const Text("Payment Failed", textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: success600),),
                  ],
                ),
              ],
            ),
                const SizedBox(height: 20),
                const Icon(Icons.warning_sharp, color: redAccent, size: 60),
                const SizedBox(height: 20),
                Text(text, textAlign: TextAlign.center,)
              ],
          )
  )
  );
}
