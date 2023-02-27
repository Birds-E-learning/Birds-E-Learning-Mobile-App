import 'package:birds_learning_network/src/features/core/walk_through/view/walk_through.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/walk_through/walk_through.dart';
import 'package:flutter/material.dart';

class ThirdWalkThroughPage extends StatelessWidget with WalkThroughTextWidget {
  const ThirdWalkThroughPage({super.key});
  @override
  Widget build(BuildContext context) {
    return WalkThroughScreen(
      image: ImagePath.walkImage3,
      position: 2,
      child: walkText3(),
      onPressed: () {},
    );
  }
}
