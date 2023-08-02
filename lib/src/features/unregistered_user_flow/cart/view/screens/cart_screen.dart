import 'package:birds_learning_network/src/features/core/auth/view/sign_up.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/cart_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/courses_mixins.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnregisteredCartScreen extends StatelessWidget with CourseTextWidgets{
  const UnregisteredCartScreen({super.key, this.isFullScreen = false});
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: appBarText(CartTexts.myCart),
        leading: isFullScreen ? leadingIcon(context) : null,
        elevation: 0,
        backgroundColor: white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.15),
                SvgPicture.asset(ImagePath.emptyCart),
                const SizedBox(height: 50),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Register here",
                          style: AuthStyles.termsStyle.copyWith(fontSize: 16, color: skipColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context)=> const SignUpScreen()),
                                    (route) => false),
                        ),
                        TextSpan(
                          text: " to cart courses,",
                          style: AuthStyles.termsStyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
