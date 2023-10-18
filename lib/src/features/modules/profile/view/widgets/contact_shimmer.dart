import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContactShimmer extends StatelessWidget {
  const ContactShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.5),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration:
        BoxDecoration(
          color: Colors.grey[300],
        ),
      ),
    );
  }
}