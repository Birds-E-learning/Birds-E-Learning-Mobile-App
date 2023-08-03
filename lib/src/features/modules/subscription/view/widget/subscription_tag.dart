import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/screens/subscription_screen.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class SubscriptionTagWidget extends StatelessWidget {
  const SubscriptionTagWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => RoutingService.pushRouting(context, const SubscriptionScreen()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        decoration: BoxDecoration(
            color: skipColor,
            borderRadius: BorderRadius.circular(4)
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock, color: white500,
              size: 10,
            ),
            SizedBox(width: 6),
            Text("Subscription Based",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: white500
              ),
            )
          ],
        ),
      ),
    );
  }
}
