import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/widgets/subscription_card.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/screens/subscription_screen.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/subscription_plan.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/profile_styles/profile_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileSubscriptionScreen extends StatefulWidget{
  const ProfileSubscriptionScreen({super.key});

  @override
  State<ProfileSubscriptionScreen> createState() => _ProfileSubscriptionScreenState();
}

class _ProfileSubscriptionScreenState extends State<ProfileSubscriptionScreen> {
  SubscriptionModel? subscription;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async{
      subscription = await SubscriptionStorage().getSubscriptionData();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(subscription?.toJson());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subscription",
          style: ProfileStyles.appBarStyle,
        ),
        centerTitle: true,
        leading: leadingIcon(context),
        elevation: 0,
        backgroundColor: white,
      ),
      body: LayoutBuilder(
        builder: (_, constraints) => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Center(
                    child: subscription == null || subscription?.status?.toUpperCase() == "EXPIRED" ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ImagePath.emptySubscription),
                        const SizedBox(height: 50),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: ProfileTexts.emptySubText1,
                                  style: AuthStyles.termsStyle.copyWith(fontSize: 16),
                                ),
                                TextSpan(
                                  text: ProfileTexts.emptySubText2,
                                  style: AuthStyles.termsStyle.copyWith(fontSize: 16, color: skipColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=> const SubscriptionScreen())),
                                ),
                              ],
                            ))
                      ],
                    ) : SubscriptionCardWidget(subscription: subscription),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
