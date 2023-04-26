// Future<void> makePayment(
//       {required BuildContext context, required String amount}) async {
//     try {
//       StripePaymentModel body = StripePaymentModel(
//           amount: calculateAmount(amount),
//           currency: "USD",
//           paymentMethodTypes: "card");
//       onPaymentClicked(true);
//       data = await repo.stripePaymentIntent(body, context);
//       notifyListeners();

//       // 2. initialize the payment sheet
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//             appearance: const PaymentSheetAppearance(
//                 primaryButton: PaymentSheetPrimaryButtonAppearance(
//                     colors: PaymentSheetPrimaryButtonTheme(
//               dark: PaymentSheetPrimaryButtonThemeColors(
//                   background: white, text: black, border: deepGrey),
//               light: PaymentSheetPrimaryButtonThemeColors(
//                   background: deepGrey, text: Colors.white),
//             ))),
//             paymentIntentClientSecret: data['client_secret'],
//             style: ThemeMode.light,
//             merchantDisplayName: "Birds Learing Network"),
//       );
//       if (context.mounted) {
//         await displayPaymentSheet(context);
//       }
//     } catch (e) {
//       _stripeLoading ? onPaymentClicked(false) : null;
//     }
//     notifyListeners();
//   }

//   Future<void> displayPaymentSheet(BuildContext context) async {
//     // String status = PaymentStatus.success.value;
//     try {
//       onPaymentClicked(false);
//       await Stripe.instance.presentPaymentSheet().then((value) async {
//         final token = await Stripe.instance.createToken(
//             const CreateTokenParams.card(
//                 params: CardTokenParams(type: TokenType.Card)));

//         print("token====>>> $token");
//       });
//       CardDetails card = CardDetails();
//       print("hereeee=====>>> ");
//       // .then((value) {
//       // showDialog(
//       //     context: context,
//       //     builder: (_) => AlertDialog(
//       //           content: Column(
//       //             mainAxisSize: MainAxisSize.min,
//       //             children: const [
//       //               Icon(
//       //                 Icons.check_circle,
//       //                 color: Colors.green,
//       //                 size: 100.0,
//       //               ),
//       //               SizedBox(height: 10.0),
//       //               Text("Payment Successful!"),
//       //             ],
//       //           ),
//       //         ));
//       //   data = null;
//       //   notifyListeners();
//       // });
//       // await _sendTransactionToBackend(
//       //   context: context,
//       //   loanOrder: loanOrder,
//       //   loanCharge: loanCharge,
//       // );
//     } on StripeException catch (_) {
//       print('Error is:---> $_');
//       AlertDialog(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: const [
//                 Icon(
//                   Icons.cancel,
//                   color: Colors.red,
//                 ),
//                 Text("Payment Failed"),
//               ],
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       _stripeLoading ? onPaymentClicked(false) : null;
//       // print("exception======>>:$e");
//     }
//   }
