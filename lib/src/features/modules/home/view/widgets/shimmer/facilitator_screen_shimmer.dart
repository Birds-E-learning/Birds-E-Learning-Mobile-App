import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/more_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FacilitatorScreenShimmer extends StatelessWidget {
  const FacilitatorScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 150,
              width: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,),
          ),
          const SizedBox(height: 15),
          Container(
            height: 20,
            width: 150,
            color: Colors.black,
          ),
          const SizedBox(height: 5),
          Container(
            height: 10,
            width: 120,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 10,
                width: 200,
                color: Colors.white10,
              ),
              const SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_,__) => const SizedBox(height: 3),
                itemCount: 5,
                itemBuilder: (_,__)=> Container(
                  height: 12,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) => Container(
                  height: 70,
                  width: size.width * 0.22,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)
                  ),
                ),)
              ),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)
                ),
              ),
              const SizedBox(height: 15),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_,__) => const SizedBox(height: 10),
                itemBuilder: (_,__) => const MoreCardsShimmer(),
                itemCount: 4,
              )
            ],
          ),
        ],
      ),
    );
  }
}
