import 'package:birds_learning_network/src/features/modules/payment/model/repository/payment_repository.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/request_model/stripe_model.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/response_model/stripe_keys.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentRepository repo = PaymentRepository();
  bool _payClicked = false;
  bool _isChecked = false;
  bool _stripeLoading = false;
  dynamic data;

  void onPaymentClicked(bool isLoading) {
    _stripeLoading = isLoading;
    notifyListeners();
  }

  bool get payClicked => _payClicked;
  bool get isChecked => _isChecked;
  bool get paymentClicked => _stripeLoading;

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

  Future<void> makePayment(
      {required BuildContext context, required String amount}) async {
    try {
      StripePaymentModel body = StripePaymentModel(
          amount: calculateAmount(amount),
          currency: "USD",
          paymentMethodTypes: "card");
      onPaymentClicked(true);
      data = await repo.stripePaymentIntent(body, context);
      notifyListeners();

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            appearance: const PaymentSheetAppearance(
                primaryButton: PaymentSheetPrimaryButtonAppearance(
                    colors: PaymentSheetPrimaryButtonTheme(
              dark: PaymentSheetPrimaryButtonThemeColors(
                  background: white, text: black, border: deepGrey),
              light: PaymentSheetPrimaryButtonThemeColors(
                  background: deepGrey, text: Colors.white),
            ))),
            paymentIntentClientSecret: data['client_secret'],
            style: ThemeMode.light,
            merchantDisplayName: "Birds Learing Network"),
      );
      if (context.mounted) {
        await displayPaymentSheet(context);
      }
    } catch (e) {
      _stripeLoading ? onPaymentClicked(false) : null;
    }
    notifyListeners();
  }

  Future<void> displayPaymentSheet(BuildContext context) async {
    // String status = PaymentStatus.success.value;
    try {
      onPaymentClicked(false);
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));
        data = null;
        notifyListeners();
      });
      // await _sendTransactionToBackend(
      //   context: context,
      //   loanOrder: loanOrder,
      //   loanCharge: loanCharge,
      // );
    } on StripeException catch (_) {
      // print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      _stripeLoading ? onPaymentClicked(false) : null;
      // print("exception======>>:$e");
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
}
