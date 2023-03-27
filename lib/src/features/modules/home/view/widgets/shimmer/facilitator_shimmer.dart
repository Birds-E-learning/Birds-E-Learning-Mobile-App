import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FacilitatorShimmer extends StatelessWidget {
  const FacilitatorShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.5),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: greys800),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Container(
                      height: 30,
                      width: size.width * 0.9 - 70,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 20,
                      width: size.width * 0.9 - 70,
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
