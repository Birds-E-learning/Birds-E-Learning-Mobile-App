import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FilterCardShimmer extends StatelessWidget {
  const FilterCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.5),
      child: Container(
        height: 40,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
