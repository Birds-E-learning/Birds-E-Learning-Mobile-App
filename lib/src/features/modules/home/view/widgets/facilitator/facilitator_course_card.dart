import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/buy_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class FacilitatorCourseCards extends StatefulWidget {
  const FacilitatorCourseCards({super.key, required this.course, this.onTap});
  final Courses course;
  final VoidCallback? onTap;

  @override
  State<FacilitatorCourseCards> createState() => _FacilitatorCourseCardsState();
}

class _FacilitatorCourseCardsState extends State<FacilitatorCourseCards>
    with HomeWidgets {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getCourseSection(context, widget.course.id.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => RoutingService.pushRouting(
          context, BuyCourseScreen(course: widget.course, isFcilitator: true)),
      child: SizedBox(
        // height: 70,
        width: size.width * 0.92,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: 50,
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.fill,
                    imageUrl: widget.course.imageUrl ?? "",
                    placeholder: (context, url) {
                      return Image.asset(
                        ImagePath.titlePics,
                        fit: BoxFit.fill,
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        ImagePath.titlePics,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width - (size.width * 0.08) - 60,
                      child: courseTitleText(
                          widget.course.title ?? "Introduction to Technology"),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        ownerText(
                            widget.course.facilitator!.name ?? "Anonymous"),
                        const SizedBox(width: 5),
                        Row(
                          children: getStarList(
                              widget.course.facilitator!.ratings ?? "3",
                              ImagePath.starFill,
                              ImagePath.starUnfill),
                        ),
                        const SizedBox(width: 5),
                        ratingText(widget.course.facilitator!.ratings ?? "3")
                      ],
                    ),
                    const SizedBox(height: 3),
                    amountText(widget.course.salePrice ?? "5000",
                        widget.course.price ?? "5500")
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getCourseSection(context, String id) async {
    var response = await Provider.of<CartProvider>(context, listen: false)
        .getCourseSection(context, id);
    if (response != null) {
      List<Sections> sections = response;
      widget.course.sections = sections;
    }
  }
}
