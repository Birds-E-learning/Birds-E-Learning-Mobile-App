import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/custom_shimmer_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuickListView extends StatelessWidget {
  const QuickListView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey quickKey = GlobalKey();
    CartProvider cart = context.read<CartProvider>();
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(
      builder: (_, home, __) => SizedBox(
        height: 205,
        child: home.quickCourses.isEmpty && home.isQuickLoading
            ? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return const CustomHomeCardShimmer();
                })
            : home.quickCourses.isEmpty && !home.isQuickLoading
                ? const Center(
                    child: Text(
                      "No available quick courses.",
                      style: CartStyles.richStyle1,
                    ),
                  )
                : ListView.separated(
                    key: quickKey,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemCount: home.quickCourses.length > 10
                        ? 10
                        : home.quickCourses.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      if (home.quickIcons.length < home.quickCourses.length) {
                        if (home.quickCourses[index].wishList!) {
                          home.quickIcons.add(true);
                        } else {
                          home.quickIcons.add(false);
                        }
                      }
                      return CourseCard(
                        iconData: home.quickIcons[index]
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        onFavPressed: () async {
                          home.setQuickValue(index);
                          if (home.quickIcons[index]) {
                            await cart.addWishlist(context,
                                home.quickCourses[index].id!, quickKey);
                          } else {
                            await cart.deleteWishlist(context,
                                home.quickCourses[index].id!, quickKey);
                          }
                        },
                        course: home.quickCourses[index],
                      );
                    }),
      ),
    );
  }
}
