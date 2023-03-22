import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FacilitatorCard extends StatelessWidget with HomeWidgets {
  const FacilitatorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          top: 10, right: size.width * 0.04, left: size.width * 0.04),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: success100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
              child: CachedNetworkImage(
            imageUrl: "https://www.none.com",
            placeholder: (context, url) {
              return Image.asset(ImagePath.facilitator);
            },
            errorWidget: (context, url, error) {
              return Image.asset(ImagePath.facilitator);
            },
          )),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  authorNameText("John Doe"),
                  const SizedBox(width: 5),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        authorLabelText("PhD, Design"),
                        Container(
                          height: 2,
                          width: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: skipColor,
                          ),
                        ),
                        authorLabelText("Graphic Designer"),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailRowText("Ratings (4.7)", Icons.stars),
                  const SizedBox(width: 5),
                  detailRowText("Courses (55)", Icons.library_books),
                  const SizedBox(width: 5),
                  detailRowText("Students (1k)", Icons.supervisor_account),
                  const SizedBox(width: 5),
                  detailRowText("Reviews (400)", Icons.reviews)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
