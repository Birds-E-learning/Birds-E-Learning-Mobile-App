import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCategoryShimmer extends StatelessWidget {
  const CustomCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.5),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 200,
            width: size.width > 400 ? 341 : size.width * 0.90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: greys300)),
          ),
          Positioned(
            bottom: 40,
            child: Column(
              children: [
                Container(
                  height: 15,
                  width: 165,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 15,
                  width: 165,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 10,
                  width: 165,
                  color: Colors.black26,
                  padding: const EdgeInsets.all(10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
