import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SubscriptionShimmer extends StatelessWidget {
  const SubscriptionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.5),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: greys300)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration:  const BoxDecoration(
                      shape: BoxShape.circle,
                      color: success1000
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        width: 30,
                        color: black,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 5,
                        width: 30,
                        color: success800,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 5,
              width: 10,
              color: skipColor,
            )
          ],
        ),
      ),
    );
  }
}
