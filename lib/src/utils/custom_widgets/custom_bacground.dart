import 'dart:ui';

import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key,
    required this.child, this.appBar,
    this.isHome = false,
    this.physics,
    this.controller,
  });
  final Widget child;
  final SliverAppBar? appBar;
  final bool isHome;
  final ScrollPhysics? physics;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Container(
            color: white,
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
              primary:  false,
              controller: controller,
              physics: physics,
              slivers: [
                appBar ?? Container(),
                SliverToBoxAdapter(
                  child: child,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
