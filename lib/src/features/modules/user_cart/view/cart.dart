import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses_pref.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view/widgets/cart_course_card.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/cart_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget with CartWidgets {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: appBarText(),
        elevation: 0,
      ),
      body: Consumer<CartProvider>(
        builder: (_, cart, __) => SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04, vertical: size.height * 0.01),
          child: cart.myCartList.isEmpty && cart.wishlist.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImagePath.emptyCart),
                      const SizedBox(height: 30),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: emptyCartTexts(() {
                            cart.addvalue();
                          })),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CourseCartCards(course: CoursesPref());
                        },
                      ),
                      const SizedBox(height: 15),
                      wishlistText(),
                      const SizedBox(height: 20),
                      ListView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CourseCartCards(course: CoursesPref());
                        },
                      ),
                    ],
                  ),
                ),
        )),
      ),
    );
  }
}
