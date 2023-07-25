import 'package:flutter/material.dart';

void getFailedDialog(String text, context) async {
  return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children:  [
                 Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 30,
                    ),
                    SizedBox(width: 20),
                    Text("Payment Failed"),
                  ],
                ),
              ],
            ),
                const SizedBox(height: 20),
                Text(text)
              ],
          )
  )
  );
}
