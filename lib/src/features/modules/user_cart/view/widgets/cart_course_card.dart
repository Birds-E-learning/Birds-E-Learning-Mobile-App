import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/view/buy_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/payment/view/screens/payment_screen.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/cart_mixins.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/global_constants/asset_paths/image_path.dart';
import '../../../home/model/response_model/get_courses.dart';

class CourseCartCards extends StatefulWidget {
  const CourseCartCards({
    super.key,
    required this.course,
    this.isWishlist = false,
    required this.removeButton,
  });
  final Courses course;
  final bool isWishlist;
  final Widget removeButton;

  @override
  State<CourseCartCards> createState() => _CourseCartCardsState();
}

class _CourseCartCardsState extends State<CourseCartCards> with CartWidgets {
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
    return Consumer<CartProvider>(
      builder: (_, cart, __) => InkWell(
        onTap: () {
          RoutingService.pushRouting(
              context, BuyCourseScreen(course: widget.course));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl: widget.course.imageUrl ?? "",
                    fit: BoxFit.fill,
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
                        ownerNameText(widget.course.facilitator == null
                            ? "Anonymous"
                            : widget.course.facilitator!.name == ""
                                ? "Anonymous"
                                : widget.course.facilitator!.name!),
                        const SizedBox(width: 5),
                        Row(
                          children: getStarList(
                              widget.course.facilitator!.ratings.toString(),
                              ImagePath.starFill,
                              ImagePath.starUnfill),
                        ),
                        const SizedBox(width: 5),
                        ratingText(widget.course.facilitator == null
                            ? "4"
                            : widget.course.facilitator!.ratings.toString())
                      ],
                    ),
                    const SizedBox(height: 3),
                    amountText(widget.course.salePrice ?? "000",
                        widget.course.price ?? "000"),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: widget.isWishlist
                              ? null
                              : addRemoveCart(
                                  "Buy Now",
                                  skipColor,
                                  Icons.add,
                                  () => RoutingService.pushRouting(context,
                                      PaymentScreen(course: widget.course))),
                        ),
                        SizedBox(width: widget.isWishlist ? 0 : 15),
                        widget.removeButton,
                        // isWishlist && cart.removeWishIcon
                        //     ? loadingIdicator()
                        //     : !isWishlist && cart.removeCartIcon
                        //         ? loadingIdicator()
                        // : addRemoveCart("Remove", errors500, Icons.remove,
                        //     onRemoveTap),
                      ],
                    )
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                thickness: 0.2,
                color: success1000,
              ),
            )
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
