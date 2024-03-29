import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class BlackButtonWidget extends StatelessWidget {
  const BlackButtonWidget({
    Key? key,
    this.onPressed,
    required this.child,
    this.isDisabled = false,
    this.backgroundColor = deepGrey,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Widget child;
  final bool isDisabled;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            // padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            backgroundColor: isDisabled ? backgroundColor.withOpacity(0.6) : backgroundColor,
            elevation: 3,
            shadowColor: Colors.grey[100],
          ),
          child: child),
    );
  }
}
