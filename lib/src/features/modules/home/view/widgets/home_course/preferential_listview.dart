import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/custom_shimmer_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreferentialListView extends StatelessWidget {
  const PreferentialListView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey topKey = GlobalKey();
    CartProvider cart = context.read<CartProvider>();
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(
      builder: (_, home, __) => SizedBox(
        height: 195,
        child: home.prefCourses.isEmpty && home.isPrefLoading
            ? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return const CustomHomeCardShimmer();
                })
            : home.prefCourses.isEmpty && !home.isPrefLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "No Preferential Course available for you, kindly edit your preferences.",
                        style: CartStyles.richStyle1,
                      ),
                    ),
                  )
                : ListView.separated(
                    key: topKey,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemCount: home.prefCourses.length > 10
                        ? 10
                        : home.prefCourses.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      if (home.topIcons.length < home.prefCourses.length) {
                        if (home.prefCourses[index].wishList!) {
                          home.topIcons.add(true);
                        } else {
                          home.topIcons.add(false);
                        }
                      }
                      return CourseCard(
                        iconData: home.topIcons[index]
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        onFavPressed: () async {
                          home.setTopValue(index);
                          if (home.topIcons[index]) {
                            await cart.addWishlist(
                                context, home.prefCourses[index].id!, topKey);
                          } else {
                            await cart.deleteWishlist(
                                context, home.prefCourses[index].id!, topKey);
                          }
                        },
                        course: home.prefCourses[index],
                      );
                    }),
      ),
    );
  }
}
