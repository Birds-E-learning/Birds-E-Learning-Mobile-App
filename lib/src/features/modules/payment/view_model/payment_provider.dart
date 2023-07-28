import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/repository/payment_repository.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/request_model/stripe_charges.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/request_model/stripe_model.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/request_model/stripe_payment.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/response_model/stripe_charge_response.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/response_model/stripe_keys.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/failed_dialog.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentRepository repo = PaymentRepository();
  bool _payClicked = false;
  bool _isChecked = false;
  dynamic data;

  bool get payClicked => _payClicked;
  bool get isChecked => _isChecked;

  void onPayClick() {
    _payClicked = !_payClicked;
    notifyListeners();
  }

  void onCheckClick(value) {
    _isChecked = value;
    notifyListeners();
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
      {StripePaymentRequest? card, Courses? course}) async {
    try {
      Stripe.publishableKey = await getStripeKeys(context);
      StripePaymentModel body = StripePaymentModel(
          amount: calculateAmount(card!.amount ?? "0"),
          currency: "USD",
          paymentMethodTypes: "card");
      data = await repo.stripePaymentIntent(body, context);
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
        const CreateTokenParams.card(
            params: CardTokenParams(
                type: TokenType.Card, name: "Birds learning network", currency: "USD"), ),
      );
      StripeChargesRequest chargeData = StripeChargesRequest(
          amount: calculateAmount(card.amount!),
          currency: "USD",
          description: "Course payment",
          token: token.id,
          courseId: course!.id);
      await makeChargePayment(context, chargeData, course);
      _payClicked ? onPayClick() : null;
    } on StripeException catch (e) {
      _payClicked ? onPayClick() : null;
      getFailedDialog(e.error.message!, context);
    } catch (e) {
      _payClicked ? onPayClick() : null;
      getFailedDialog("Payment error : ${e.toString()}", context);
      throw Exception(e);
    }
  }

  Future<String> getStripeKeys(context, {keyToGet = "publish"}) async {
    try {
      var json = await repo.generateStripeKeys(context);
      if (json != null) {
        StripeKeyResponse response = StripeKeyResponse.fromJson(json);
        if (response.responseCode == "00" && keyToGet == "secret") {
          return response.responseData!.secretKey!;
        } else if (response.responseCode == "00") {
          return response.responseData!.publishableKey!;
        }
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  Future makeChargePayment(
      context, StripeChargesRequest data, Courses course) async {
    var json = await repo.makePaymentRepo(context, data);
    if (json != null) {
      StripeChargesResponse response = StripeChargesResponse.fromJson(json);
      if (response.responseCode == "00" || response.responseCode == "000") {
        if (response.responseData!.status == "succeeded") {
          getSuccessPaymentDialog(context, course: course, pending: false);
        } else if (response.responseData!.status == "pending") {
          getSuccessPaymentDialog(context, pending: true);
        } else {
          getFailedDialog(
              "Payment failed: ${response.responseMessage}.", context);
        }
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    }
  }
}
