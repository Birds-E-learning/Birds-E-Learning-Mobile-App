import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
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
      child: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.grey,
                    height: 80,
                    width: 60,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    children: [
                      Container(
                        height: 30,
                        width: size.width * 0.8 - 70,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 15,
                        width: size.width * 0.8 - 70,
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 30,
                        width: size.width * 0.8 - 70,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
                child: Divider(
                  thickness: 0.2,
                  color: success1000,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
