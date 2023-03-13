import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/profile_page.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/filter_mixins/filter_mixin.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget with FilterTextWidgets {
  const GetStartedPage({super.key});

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
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.15),
                child: Image.asset(
                  ImagePath.started,
                  height: size.height * 0.4,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              startedHeader(),
              const SizedBox(height: 10),
              startedText(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      width: size.width * 0.4,
                      child: WhiteButtonWidget(
                          onPressed: () {}, child: skipButtonText())),
                  SizedBox(
                    width: size.width * 0.4,
                    child: BlackButtonWidget(
                        onPressed: () {
                          RoutingService.pushAndRemoveAllRoute(
                              context, const UserProfilePage());
                        },
                        child: proceedButtonText()),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
