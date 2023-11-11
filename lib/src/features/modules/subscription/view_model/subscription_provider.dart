import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/repository/payment_repository.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/request_model/stripe_model.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/request_model/stripe_payment.dart';
import 'package:birds_learning_network/src/features/modules/payment/view_model/payment_provider.dart';
import 'package:birds_learning_network/src/features/modules/subscription/model/repository/subscription_repo.dart';
import 'package:birds_learning_network/src/features/modules/subscription/model/request_model/subscribe_model.dart';
import 'package:birds_learning_network/src/features/modules/subscription/model/response_model/subscribe_response.dart';
import 'package:birds_learning_network/src/features/modules/subscription/model/response_model/subscription_type.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/failed_dialog.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class SubscriptionProvider extends SubscriptionRepo with ChangeNotifier{
  List<DurationData> subscriptionPlans = [];
  dynamic data;
  Status subStatus = Status.initial;
  Status paymentStatus = Status.initial;

  Future subscriptionLatestMethod(context)async{
    try{
      var json = await getLatestSubscriptionRepo(context);
      if(json == null){
        await getLatestSubscriptionRepo(context);
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future subscriptionPlanMethod(context)async{
    try{
      subStatus = Status.loading;
      notifyListeners();
      List<DurationData>? data = await getSubscriptionPlansRepo(context);
      subStatus = Status.completed;
      notifyListeners();
      if(data != null){
        subscriptionPlans = data;
        notifyListeners();
      }
    }catch(e){
      subStatus = Status.error;
      notifyListeners();
      debugPrint(e.toString());
    }
  }

  Future latestSubscriptionMethod(context)async{
    try{
      SubscriptionModel? data = await getLatestSubscriptionRepo(context);
      if(data != null){
        data = data;
        notifyListeners();
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future makeChargePayment(
      context, SubscriptionPaymentRequest data, {Courses? course}) async {
    SubscriptionPaymentResponse? response = await subscriptionPaymentRepo(context, data);
    if (response != null) {
      if (response.responseCode == "00" || response.responseCode == "000") {
        subscriptionLatestMethod(context);
        paymentSuccessDialog(context, course: course);
      } else {
        getFailedDialog(
            " ${response.responseMessage}.", context);
      }
    }
  }

  calculateAmount(dynamic amountt) {
    int amount = (double.parse(amountt.toString()).toInt()) * 100;
    return amount.toString();
  }

  roundAmount(dynamic price) {
    int amount = double.parse(price).round();
    return amount.toString();
  }

  Future getPaymentToken(context,
      {required StripePaymentRequest card, required DurationData plan,  Courses? course}) async {
    if(paymentStatus == Status.loading){
      updateStatus(status: Status.completed);
      return;
    }else{
      updateStatus(status: Status.loading);
    }
    try {
      Stripe.publishableKey = Stripe.publishableKey.isNotEmpty ? Stripe.publishableKey :
      await Provider.of<PaymentProvider>(context, listen: false).getStripeKeys(context);
      StripePaymentModel body = StripePaymentModel(
          amount: calculateAmount(card.amount ?? "0"),
          currency: plan.currency.toString().toUpperCase(),
          paymentMethodTypes: "card");
      data = await PaymentRepository().stripePaymentIntent(body, context);
      notifyListeners();
      // Create a token with the card details
      List<String> expiry = card.expiryDate!.split("/");
      CardDetails card_ = CardDetails(
          number: card.cardNo,
          expirationMonth: int.parse(expiry[0]),
          expirationYear: int.parse(expiry[1]),
          cvc: card.ccv);
      await Stripe.instance.dangerouslyUpdateCardDetails(card_);
      final token = await Stripe.instance.createToken(
         CreateTokenParams.card(
          params: CardTokenParams(
              type: TokenType.Card, name: "Birds learning network", currency: plan.currency ?? "USD"), ),
      );
      SubscriptionPaymentRequest chargeData = SubscriptionPaymentRequest(
        amount: calculateAmount(plan.amount),
        currency: plan.currency?.toString().toUpperCase() ?? "USD",
        description: "Subscription",
        token: token.id,
        subscriptionSlug: plan.slug
      );
      await makeChargePayment(context, chargeData, course: course);
      updateStatus(status: Status.completed);
    } on StripeException catch (e) {
      updateStatus(status: Status.error);
      getFailedDialog(e.error.message!, context);
    } catch (e) {
      updateStatus(status: Status.error);
      getFailedDialog("Unable to successfully make payment", context);
    }
  }

  void updateStatus({Status status = Status.initial}){
    paymentStatus = status;
    notifyListeners();
  }
}