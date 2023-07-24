import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/view_course/view_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/payment/view/screens/payment_screen.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/content_mixins.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseActionButtons extends StatelessWidget
    with HomeWidgets, ContentWidget {
  const CourseActionButtons({super.key, required this.course});
  final Courses course;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final toastKey = GlobalKey();
    CartProvider cart = context.watch<CartProvider>();
    CartProvider cartRead = context.read<CartProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 60,
          child: BlackButtonWidget(
              onPressed: () async {
                course.salePrice! == "0.00"
                    ? RoutingService.pushAndPopUntilRouteIsFirst(
                        context, ViewCourseScreen(course: course))
                    : RoutingService.pushRouting(
                        context, PaymentScreen(course: course));
              },
              child: buttonText(
                  course.salePrice! == "0.00" ? "Start Course" : "Enroll Now",
                  nextColor)),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 60,
              width: size.width * 0.45,
              child: WhiteButtonWidget(
                  onPressed: () async {
                    if (cartRead.cartClicked) {
                      cartRead.onCartClick();
                      return;
                    }
                    cartRead.onCartClick();
                    await cartRead.addCart(context, course.id!);
                  },
                  child: cart.cartClicked
                      ? loadingIdicator()
                      : buttonText("Add to Cart", skipColor)),
            ),
            SizedBox(
              height: 60,
              width: size.width * 0.45,
              child: WhiteButtonWidget(
                  onPressed: () async {
                    if (cartRead.wishlistClicked) {
                      cartRead.onWishlistClick();
                      return;
                    }
                    cartRead.onWishlistClick();
                    // course.wishList!
                    //     ? await cartRead.deleteWishlist(
                    //         context, course.id!, toastKey,
                    //         page: "Course screen"):
                    await cartRead.addWishlist(context, course.id!, toastKey,
                        page: "Course Screen");
                    // course.wishList = !course.wishList!;
                  },
                  child: cart.wishlistClicked
                      ? loadingIdicator()
                      : buttonText(
                          // course.wishList!
                          // ? "Added to WishList":
                          "Add to WishList",
                          skipColor)),
            )
          ],
        )
      ],
    );
  }
}
