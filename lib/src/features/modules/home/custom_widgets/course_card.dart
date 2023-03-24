import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses_pref.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget with ImagePath, HomeWidgets {
  const CourseCard({
    super.key,
    required this.onFavPressed,
    required this.course,
    this.iconData = Icons.favorite_outline,
    this.iconColor = skipColor,
  });
  final VoidCallback onFavPressed;
  final CoursesPref course;
  final Color iconColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 165,
      // // height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: grey100,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 90,
            width: 165,
            child: CachedNetworkImage(
              imageUrl: "",
              placeholder: (context, url) {
                return Image.asset(
                  ImagePath.thumbnail,
                  fit: BoxFit.fill,
                );
              },
              errorWidget: (context, url, error) {
                return Image.asset(
                  ImagePath.thumbnail,
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                SizedBox(
                  width: size.width - (size.width * 0.08) - 60,
                  child: courseTitleText(course.title ??
                      "Getting Started with Adobe Figma Course"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ownerText("John Doe"),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Row(
                              children: getStarList("2", ImagePath.starFill,
                                  ImagePath.starUnfill),
                            ),
                            const SizedBox(width: 10),
                            ratingText(course.views ?? "4,103")
                          ],
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: onFavPressed,
                        icon: Icon(
                          iconData,
                          color: iconColor,
                        ))
                  ],
                ),
                const SizedBox(height: 5),
                amountText(course.salePrice ?? "5000", course.price ?? "5500")
              ],
            ),
          )
        ],
      ),
    );
  }
}
