import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LectureTabShimmer extends StatelessWidget {
  const LectureTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.5),
      child:ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        separatorBuilder: (_,__) => const SizedBox(height: 5),
        itemBuilder: (_,__) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 10,
              width: double.infinity,
              color: Colors.white,
            ),
            ListView.separated(
              itemCount: 2,
              separatorBuilder: (_, __) => const SizedBox(height: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shrinkWrap: true,
              itemBuilder: (_, __) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
