import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_image.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/buy_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/payment/view/screens/payment_screen.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/widget/subscription_tag.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/cart_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseCartCards extends StatelessWidget with CartWidgets {
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
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<CartProvider>(
      builder: (_, cart, __) => InkWell(
        onTap: () {
          course.sections = <Sections>[];
          RoutingService.pushRouting(context, BuyCourseScreen(course: course));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 55,
                  width: 50,
                  child: CourseImageWidget(imageUrl: course.imageUrl ?? "",
                    height: 50, width: 60, isMore: true,)
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width - (size.width * 0.08) - 60,
                      child: courseTitleText(
                          course.title ?? "Introduction to Technology"),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        ownerNameText(course.facilitator == null
                            ? "Anonymous"
                            : course.facilitator!.name == ""
                                ? "Anonymous"
                                : course.facilitator!.name!),
                        const SizedBox(width: 5),
                        Row(
                          children: getStarList(
                              course.facilitator!.ratings.toString(),
                              ImagePath.starFill,
                              ImagePath.starUnfill),
                        ),
                        const SizedBox(width: 5),
                        ratingText(course.facilitator == null
                            ? "4"
                            : course.facilitator!.ratings.toString())
                      ],
                    ),
                    const SizedBox(height: 3),
                    Container(
                      child: course.subscriptionBased ?? true
                          ? SubscriptionTagWidget(course: course)
                          : amountText(
                          course.salePrice ?? "5000", course.price ?? "5500"),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: isWishlist
                              ? null
                              : addRemoveCart(
                                  "Buy Now",
                                  skipColor,
                                  Icons.add,
                                  () => RoutingService.pushRouting(
                                      context, PaymentScreen(course: course))),
                        ),
                        SizedBox(width: isWishlist ? 0 : 15),
                        removeButton,
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
      course.sections = sections;
    }
  }
}
