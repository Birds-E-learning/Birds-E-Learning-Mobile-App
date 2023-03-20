import 'dart:ui';

import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child, this.appBar});
  final Widget child;
  final SliverAppBar? appBar;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
          SafeArea(
            child: CustomScrollView(
              slivers: [
                appBar ?? Container(),
                SliverToBoxAdapter(
                  child: child,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
