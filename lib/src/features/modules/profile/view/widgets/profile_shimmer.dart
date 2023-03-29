import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePictureShimmer extends StatelessWidget {
  const ProfilePictureShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.5),
      child: Container(
        height: 80,
        width: 80,
        decoration:
            BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
      ),
    );
  }
}
