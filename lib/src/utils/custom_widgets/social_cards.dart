import 'package:birds_learning_network/src/features/core/auth/view_model/oauth_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.serviceProvider,
  });
  final VoidCallback onTap;
  final String image;
  final String serviceProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<OAuthProvider>(
      builder: (_, auth, __) => InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          width: size.width * 0.27,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: greys300)),
          child: Center(
            child:
                callClick(auth) ? loadingIdicator() : SvgPicture.asset(image),
          ),
        ),
      ),
    );
  }

  bool callClick(OAuthProvider auth) {
    if (serviceProvider == "FACEBOOK") {
      return auth.facebookClicked;
    } else if (serviceProvider == "GOOGLE") {
      return auth.googleClicked;
    } else if (serviceProvider == "APPLE") {
      return auth.appleClicked;
    }
    return false;
  }
}

class GoogleCard extends StatelessWidget with AuthTextWidgets {
  const GoogleCard({
    super.key,
    required this.onTap,
    required this.text,
  });
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<OAuthProvider>(
      builder: (_, auth, __) => InkWell(
        onTap: onTap,
        child: Container(
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: greys300)),
          child: Center(
            child: auth.googleClicked
                ? loadingIdicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImagePath.google),
                      const SizedBox(width: 10),
                      AuthTextWidgets.googleText(text),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
