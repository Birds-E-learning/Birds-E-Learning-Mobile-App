import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MoreCardsShimmer extends StatelessWidget {
  const MoreCardsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: size.width * 0.8 - 50,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 15,
                      width: size.width * 0.8 - 80,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 10,
                      width: size.width * 0.8 - 120,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
