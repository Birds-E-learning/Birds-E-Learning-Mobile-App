import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/screens/subscription_screen.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

void getSubscriptionDialog(String text, context, {bool isDays = false}) async {
  return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Subscription Reminder",
                maxLines: 2,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: success600),),
              const SizedBox(height: 10),
               Center(
                 child: Icon(Icons.warning_sharp,
                    color: !isDays ? redAccent : Colors.yellow,
                    size: 80),
               ),
              const SizedBox(height: 10),
              Text("Your subscription will expire in $text", textAlign: TextAlign.left,)
            ],
          ),
        actionsPadding: const EdgeInsets.only(right: 24),
        actions: [
          TextButton(
              onPressed: ()=> Navigator.pop(context),
              child: const Text("CANCEL", style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14, color: skipColor,
                fontFamily: "Inter"
              ),)),
          TextButton(
              onPressed: (){
                RoutingService.popRouting(context);
                RoutingService.pushRouting(context, const SubscriptionScreen());
              },
              child: const Text("RENEW", style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 14, color: skipColor,
                  fontFamily: "Inter"
              ),),
          )
        ],
      )
  );
}
