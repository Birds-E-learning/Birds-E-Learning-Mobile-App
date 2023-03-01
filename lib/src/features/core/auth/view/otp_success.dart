import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:flutter/material.dart';

class OtpSuccessPage extends StatelessWidget with AuthTextWidgets {
  const OtpSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: AuthenticationWidget(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04, vertical: size.height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                ImagePath.otpSuccess,
                height: size.height * 0.4,
                width: double.infinity,
              ),
              const SizedBox(height: 50),
              AuthTextWidgets.sucessText(),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: BlackButtonWidget(
                  onPressed: () {},
                  child: AuthTextWidgets.buttonText(AuthTexts.complete),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
