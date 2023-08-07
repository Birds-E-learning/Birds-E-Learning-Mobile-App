import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/screens/payment_screen.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/widget/card_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/widget/subscription_card.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view_model/subscription_provider.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/text_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/payment_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/payment_mixins.dart';
import 'package:birds_learning_network/src/utils/shared_functions/get_subscription_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async{
      context.read<SubscriptionProvider>().subscriptionPlans.isEmpty ? 
      await context.read<SubscriptionProvider>().subscriptionPlanMethod(context) : null;
    });
    super.initState();
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
      body: Consumer<SubscriptionProvider>(
        builder: (_, sub, __) => SafeArea(
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
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: greys200,
                        fontFamily: "Inter"
                    ),
                  ),
                  const SizedBox(height: 30),
                  sub.subStatus != Status.loading
                  ? sub.subscriptionPlans.isEmpty
                    ? const Center(child: Text("No subscription plan available", style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Inter", color: success1000
                      ),),)
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (_ ,index) {
                          return SubscriptionCardWidget(
                            duration: sub.subscriptionPlans[index],
                            selectedValue: selectedValue,
                            isSelected: selectedValue == sub.subscriptionPlans[index].duration,
                            onChanged: _onChanged,);
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemCount: sub.subscriptionPlans.length,
                      )
                  : ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (_ ,index) {
                      return const SubscriptionShimmer();
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemCount: 3,
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    child: BlackButtonWidget(
                        onPressed: (){
                          if(selectedValue == null){
                            showSnack(context, "03", "Choose a subscription plan before proceeding to payment");
                          }else{
                            RoutingService.pushRouting(context,
                                SubscriptionPaymentScreen(data: getSubscriptionPlan(selectedValue!, sub.subscriptionPlans)));
                          }
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
      ),
    );
  }
}
