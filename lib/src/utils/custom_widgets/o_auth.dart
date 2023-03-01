import 'package:birds_learning_network/src/utils/custom_widgets/social_cards.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:flutter/material.dart';

class OAuthWidget extends StatelessWidget {
  const OAuthWidget({
    super.key,
    required this.onFacebookTap,
    required this.onGoogleTap,
    required this.onAppleTap,
  });
  final VoidCallback onFacebookTap;
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SocialCard(onTap: onFacebookTap, image: ImagePath.facebook),
        SocialCard(onTap: onGoogleTap, image: ImagePath.google),
        SocialCard(onTap: onAppleTap, image: ImagePath.apple),
      ],
    );
  }
}
