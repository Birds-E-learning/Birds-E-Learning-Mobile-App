import 'package:birds_learning_network/src/features/core/auth/view/sign_up.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCategoryWidget extends StatelessWidget {
  const EmptyCategoryWidget({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.only(top: size.height * 0.20),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(ImagePath.noCourse),
            const SizedBox(height: 10),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "No available $category courses. Click ",
                      style: AuthStyles.termsStyle.copyWith(fontSize: 16),
                    ),
                    TextSpan(
                      text: "here ",
                      style: AuthStyles.termsStyle.copyWith(fontSize: 16, color: skipColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context)=> const SignUpScreen()),
                                (route) => false),
                    ),
                    TextSpan(
                      text: "to Sign up or Login",
                      style: AuthStyles.termsStyle.copyWith(fontSize: 14),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
