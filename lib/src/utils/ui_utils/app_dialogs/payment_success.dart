import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/profile_styles/profile_styles.dart';
import 'package:flutter/material.dart';

void getSuccessPaymentDialog(context, {pending = false}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100.0,
            ),
            const SizedBox(height: 10.0),
            Text(pending ? "Payment Initiated" : "Payment Successful!",
                style: ProfileStyles.logoutHeaderStyle
                    .copyWith(color: success1000, fontSize: 18)),
            const SizedBox(height: 10),
            Text(pending
                ? "Payment has been initiated, you will be notified shortly."
                : ""),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  RoutingService.popUntilRouteIsFirstRouting(context);
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor: deepGrey,
                  elevation: 3,
                  shadowColor: Colors.grey[100],
                ),
                child: Text(
                  "Go to Home",
                  style: ProfileStyles.logoutButtonStyle
                      .copyWith(color: nextColor, fontSize: 14),
                )),
          ),
        ]),
  );
}
