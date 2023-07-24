import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/alll_courses_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/more_card_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view/widgets/cart_course_card.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/cart_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget with CartWidgets {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context.read<CartProvider>().refreshList(context);
    GlobalKey wishKey = GlobalKey();
    GlobalKey cartKey = GlobalKey();
    return BackgroundWidget(
      appBar: SliverAppBar(
        backgroundColor: backgroundBlurColor,
        title: appBarText(),
        elevation: 0,
        pinned: true,
        floating: true,
      ),
      child: Consumer<CartProvider>(
        builder: (_, cart, __) => SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04, vertical: size.height * 0.01),
          child: cart.myCartList.isEmpty &&
                  cart.wishlist.isEmpty &&
                  !cart.isCartLoading &&
                  !cart.isWishlistLoading
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.1),
                      SvgPicture.asset(ImagePath.emptyCart),
                      const SizedBox(height: 30),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: emptyCartTexts(() {
                            RoutingService.pushRouting(
                                context, const AllCoursesScreen());
                          })),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cart.myCartList.isEmpty && cart.isCartLoading
                        ? ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return const MoreCardsShimmer();
                            },
                          )
                        : cart.myCartList.isEmpty && !cart.isCartLoading
                            ? const Center(
                                child: Text(
                                  "Cart is Empty!",
                                  style: CartStyles.richStyle1,
                                ),
                              )
                            : ListView.builder(
                                key: cartKey,
                                itemCount: cart.myCartList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  if (cart.selectedCart.length <
                                      cart.myCartList.length) {
                                    cart.selectedCart.add(false);
                                  }
                                  return CourseCartCards(
                                    course: cart.myCartList[index],
                                    removeButton: cart.removeCartIcon &&
                                            cart.selectedCart[index]
                                        ? loadingIdicator(stroke: 0.4)
                                        : addRemoveCart(
                                            "Remove", errors500, Icons.remove,
                                            () async {
                                            cart.onCartSelected(index);
                                            if (cart.removeCartIcon) {
                                              cart.onRemoveCartIconClick();
                                            }
                                            cart.onRemoveCartIconClick();
                                            await cart.deleteCart(
                                                context,
                                                cart.myCartList[index].id!,
                                                cartKey);
                                          }),
                                  );
                                },
                              ),
                    const SizedBox(height: 15),
                    wishlistText(),
                    const SizedBox(height: 20),
                    cart.wishlist.isEmpty &&
                            (cart.isWishlistLoading || cart.isCartLoading)
                        ? ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return const MoreCardsShimmer();
                            },
                          )
                        : cart.wishlist.isEmpty &&
                                !cart.isWishlistLoading &&
                                !cart.isCartLoading
                            ? const Center(
                                child: Text(
                                  "Wishlist is Empty!",
                                  style: CartStyles.richStyle1,
                                ),
                              )
                            : ListView.builder(
                                key: wishKey,
                                itemCount: cart.wishlist.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  if (cart.selectedWish.length <
                                      cart.wishlist.length) {
                                    cart.selectedWish.add(false);
                                  }
                                  return CourseCartCards(
                                    removeButton: cart.removeWishIcon &&
                                            cart.selectedWish[index]
                                        ? loadingIdicator(stroke: 1)
                                        : addRemoveCart(
                                            "Remove",
                                            errors500,
                                            Icons.remove,
                                            () async {
                                              cart.onWishSelected(index);
                                              if (cart.removeCartIcon) {
                                                cart.onRemoveWishIconClick();
                                              }
                                              cart.onRemoveWishIconClick();
                                              await cart.deleteWishlist(
                                                context,
                                                cart.wishlist[index].id!,
                                                wishKey,
                                              );
                                            },
                                          ),
                                    course: cart.wishlist[index],
                                    isWishlist: true,
                                  );
                                },
                              ),
                  ],
                ),
        )),
      ),
    );
  }
}
