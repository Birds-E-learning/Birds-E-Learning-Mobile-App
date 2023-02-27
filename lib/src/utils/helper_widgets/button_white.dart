import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class WhiteButtonWidget extends StatelessWidget {
  const WhiteButtonWidget({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = white,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: const BorderSide(color: deepGrey))),
            ),
            child: child));
  }
}
