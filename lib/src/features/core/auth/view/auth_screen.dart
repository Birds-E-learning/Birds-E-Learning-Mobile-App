import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthenticationWidget extends StatelessWidget with ImagePath {
  const AuthenticationWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.2,
          child: SvgPicture.asset(
            ImagePath.auth,
            width: double.infinity,
          ),
        ),
        child
      ],
    );
  }
}
