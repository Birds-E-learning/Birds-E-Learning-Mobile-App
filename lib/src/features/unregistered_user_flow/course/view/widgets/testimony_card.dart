import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_review.dart';
import 'package:birds_learning_network/src/global_model/services/native_app/cached_image.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:flutter/material.dart';

class TestimonyCard extends StatelessWidget {
  const TestimonyCard({super.key, required this.review});
  final Reviews review;

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontFamily: "Inter",
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: black300);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CachedImage(
              imageUrl: review.reviewerImage ?? "",
              imageBuilder: (context, imageProvider) => Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:  DecorationImage(
                    image: imageProvider
                  ),
                ),),
            ),
            const SizedBox(width: 15),
            Text(
              review.reviewerName ?? "",
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  color: greys900),
            )
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Row(
              children: getStarList(
                 review.reviewerRating?.toString() ?? "0", ImagePath.starFill, ImagePath.starUnfill,
                  size: 10),
            ),
            const SizedBox(width: 15),
            Text(
              review.dateOfReview ?? "",
              style: style.copyWith(fontSize: 10),
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          review.reviewerComment ?? "",
          style: style.copyWith(color: deepBlack),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
