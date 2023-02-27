import 'package:birds_learning_network/src/features/core/walk_through/view/walk_through.dart';
import 'package:birds_learning_network/src/features/core/walk_through/view/walk_through_two.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/walk_through/walk_through.dart';
import 'package:flutter/material.dart';

class FirstWalkThroughPage extends StatelessWidget with WalkThroughTextWidget {
  const FirstWalkThroughPage({super.key});
  @override
  Widget build(BuildContext context) {
    return WalkThroughScreen(
      image: ImagePath.walkImage1,
      position: 0,
      child: walkText1(),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const SecondWalkThroughPage()));
      },
    );
  }
}
