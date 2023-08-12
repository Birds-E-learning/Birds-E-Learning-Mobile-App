import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:flutter/material.dart';

class TestimonyCard extends StatelessWidget {
  const TestimonyCard({super.key, this.image});
  final dynamic image;

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
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: image != null
                          ? Image.network(image).image
                          : Image.asset(ImagePath.testimonyImage).image)),
            ),
            const SizedBox(width: 15),
            const Text(
              "John Dee",
              style: TextStyle(
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
                  4.toString(), ImagePath.starFill, ImagePath.starUnfill,
                  size: 10),
            ),
            const SizedBox(width: 15),
            Text(
              "3/20/2023",
              style: style.copyWith(fontSize: 10),
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Lorem ipsum dolor sit amet consectetur. Pharetra odio at cursus nulla suspendisse vitae sit nibh. Magnis pharetra nisi nibh ornare magna potenti fames dictum. ",
          style: style.copyWith(color: deepBlack),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
