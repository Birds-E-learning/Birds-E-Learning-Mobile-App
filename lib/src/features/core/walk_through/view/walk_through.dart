import 'dart:ui';
import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/view/sign_up.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/walk_through/walk_through.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class WalkThroughScreen extends StatelessWidget with WalkThroughTextWidget {
  const WalkThroughScreen(
      {super.key,
      required this.image,
      required this.child,
      required this.position,
      this.isShort = false,
      this.lastScreen = false,
        this.onPressed2,
      required this.onPressed});
  final String image;
  final Widget child;
  final double position;
  final bool isShort;
  final bool lastScreen;
  final VoidCallback onPressed;
  final VoidCallback? onPressed2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
      children: [
          Container(
            color: backgroundBlurColor,
            width: double.infinity,
            height: size.height / 3,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 30, sigmaY: 70, tileMode: TileMode.clamp),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.17, bottom: isShort ? 100 : 40),
                  child: Image.asset(
                    image,
                    height: isShort ? 220 : 250,
                    width: double.infinity,
                  ),
                ),
                Center(
                  child: DotsIndicator(
                    dotsCount: 3,
                    position: position,
                    decorator: DotsDecorator(
                      activeColor: activeDottColor,
                      color: inactiveDotColor,
                      size: const Size.square(8),
                      spacing: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      activeSize: const Size(16, 8),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Align(alignment: Alignment.center, child: child),
                const SizedBox(height: 60),
                Container(
                  child: lastScreen
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: BlackButtonWidget(
                            onPressed: onPressed, child: startedButtonText()),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: WhiteButtonWidget(
                            onPressed: onPressed2 ?? (){}, child: browseCourseButtonText()),
                      )
                    ],
                  )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.42,
                              child: WhiteButtonWidget(
                                  onPressed: () {
                                    RoutingService.pushReplacementRouting(
                                        context, const SignUpScreen());
                                  },
                                  child: skipButtonText()),
                            ),
                            SizedBox(
                              width: size.width * 0.42,
                              child: BlackButtonWidget(
                                  onPressed: onPressed, child: nextButtonText()),
                            )
                          ],
                        ),
                )
              ],
            ),
          )
      ],
    ),
        ));
  }
}
