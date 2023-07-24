import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/custom_shimmer_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingListView extends StatelessWidget {
  const TrendingListView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey trendingKey = GlobalKey();
    CartProvider cart = context.read<CartProvider>();
    return Consumer<HomeProvider>(
      builder: (_, home, __) => SizedBox(
        height: 205,
        child: home.trendingCourses.isEmpty && home.isTrendingLoading
            ? ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return const CustomHomeCardShimmer();
                })
            : home.trendingCourses.isEmpty && !home.isTrendingLoading
                ? const Center(
                    child: Text(
                      "No available trending courses.",
                      style: CartStyles.richStyle1,
                    ),
                  )
                : ListView.separated(
                    key: trendingKey,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemCount: home.trendingCourses.length > 10
                        ? 10
                        : home.trendingCourses.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      if (home.trendingIcons.length <
                          home.trendingCourses.length) {
                        if (home.trendingCourses[index].wishList!) {
                          home.trendingIcons.add(true);
                        } else {
                          home.trendingIcons.add(false);
                        }
                      }
                      return CourseCard(
                        iconData: home.trendingIcons[index]
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        onFavPressed: () async {
                          home.setTrendingValue(index);
                          if (home.trendingIcons[index]) {
                            await cart.addWishlist(context,
                                home.trendingCourses[index].id!, trendingKey);
                          } else {
                            await cart.deleteWishlist(context,
                                home.trendingCourses[index].id!, trendingKey);
                          }
                        },
                        course: home.trendingCourses[index],
                      );
                    }),
      ),
    );
  }
}
