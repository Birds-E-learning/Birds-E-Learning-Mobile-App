import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/subscription/model/response_model/subscription_type.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/screens/payment_screen.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/widget/subscription_card.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/text_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/payment_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/payment_mixins.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget{
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> with PaymentWidgets{
  String? selectedValue;
  _onChanged(value){
    setState(() {
      selectedValue = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: appBarText(PaymentTexts.subscription),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        leading: leadingIcon(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 6),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choose a Plan",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                    color: skipColor
                  ),
                ),
               const SizedBox(height: 8),
               const Text(
                  "NB: In order to continue accessing the courses, it is necessary to renew your subscription once it has expired.",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: greys200,
                      fontFamily: "Inter"
                  ),
                ),
                const SizedBox(height: 30),
                SubscriptionCardWidget(duration: DurationData(
                  amount: 20, currency: "USD", duration: "Monthly",
                ), selectedValue: selectedValue, onChanged: _onChanged,),
                const SizedBox(height: 20),
                SubscriptionCardWidget(duration: DurationData(
                    amount: 30, currency: "USD", duration: "Quarterly"
                ), selectedValue: selectedValue, onChanged: _onChanged,),
                const SizedBox(height: 20),
                SubscriptionCardWidget(duration: DurationData(
                    amount: 50, currency: "USD", duration: "Yearly"
                ), selectedValue: selectedValue, onChanged: _onChanged,),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  child: BlackButtonWidget(
                      onPressed: (){
                        RoutingService.pushRouting(context,
                            SubscriptionPaymentScreen(data: DurationData()));
                      }, child: Text(
                    "Proceed to Payment",
                    style: TextStyles.buttonStyle.copyWith(color: nextColor),
                  )),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: WhiteButtonWidget(
                      onPressed: (){
                        RoutingService.popRouting(context);
                      }, child: Text(
                    "Cancel",
                    style: TextStyles.buttonStyle.copyWith(color: skipColor),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
