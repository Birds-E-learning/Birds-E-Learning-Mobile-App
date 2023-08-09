import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNewsShimmer extends StatelessWidget {
  const CustomNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                height: 150,
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
                    const SizedBox(height: 5),
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
                    const SizedBox(height: 10),
                    Container(
                      height: 10,
                      width: 165,
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: 15,
            width: 165,
            color: success900,
            margin: const EdgeInsets.all(10),
          ),
          const SizedBox(height: 5),
          Container(
            height: 15,
            width: 165,
            color: success900,
            margin: const EdgeInsets.all(10),
          ),
          const SizedBox(height: 10),
          Container(
            height: 15,
            width: 100,
            color: greys200,
            margin: const EdgeInsets.all(10),
          ),
          const SizedBox(height: 30),
          ListView.separated(
            separatorBuilder: (_,__)=> const SizedBox(height: 4),
            shrinkWrap: true,
            itemCount: 8,
              itemBuilder: (_, index) => Container(
                height: 15,
                width: double.infinity,
                color: success900,
                margin: const EdgeInsets.all(10),
              ),
          )
        ],
      ),
    );
  }
}
