import 'package:birds_learning_network/src/features/core/walk_through/view/walk_text_three.dart';
import 'package:birds_learning_network/src/features/core/walk_through/view/walk_through.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/walk_through/walk_through.dart';
import 'package:flutter/material.dart';

class SecondWalkThroughPage extends StatelessWidget with WalkThroughTextWidget {
  const SecondWalkThroughPage({super.key});
  @override
  Widget build(BuildContext context) {
    return WalkThroughScreen(
      image: ImagePath.walkImage2,
      position: 1,
      isShort: true,
      child: walkTex2(),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ThirdWalkThroughPage()));
      },
    );
  }
}
