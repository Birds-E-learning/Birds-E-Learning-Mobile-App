import 'package:birds_learning_network/src/features/modules/payment/view_model/payment_provider.dart';
import 'package:birds_learning_network/src/features/modules/profile/custom_widgets/custom_text_column.dart';
import 'package:birds_learning_network/src/utils/formatters/card_expiration_formatter.dart';
import 'package:birds_learning_network/src/utils/formatters/card_number_formatter.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/payment_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/payment_mixins.dart';
import 'package:birds_learning_network/src/utils/validators/card_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with PaymentWidgets, CardValidator {
  TextEditingController cardNo = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController ccv = TextEditingController();
  TextEditingController pin = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cardNo.dispose();
    expiryDate.dispose();
    ccv.dispose();
    pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: appBarText(PaymentTexts.payment),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        leading: leadingIcon(context),
      ),
      body: Consumer<PaymentProvider>(
        builder: (_, payment, __) => SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextColumn(
                    controller: cardNo,
                    text: PaymentTexts.cardNo,
                    keyboardType: TextInputType.number,
                    hintText: PaymentTexts.cardHint,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(19),
                      FilteringTextInputFormatter.digitsOnly,
                      CardNumberFormatter(),
                    ],
                    validator: (value) => cardNoValidator(cardNo.text.trim()),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextColumn(
                            controller: expiryDate,
                            text: PaymentTexts.expiryText,
                            keyboardType: TextInputType.number,
                            hintText: PaymentTexts.expiryHint,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.digitsOnly,
                              CardExpirationFormatter(),
                            ],
                            validator: (value) => dateValidator(value)),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomTextColumn(
                          controller: ccv,
                          text: PaymentTexts.ccvText,
                          keyboardType: TextInputType.number,
                          hintText: PaymentTexts.ccvHint,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) => cvvValidator(value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  CustomTextColumn(
                    controller: pin,
                    text: PaymentTexts.pinText,
                    keyboardType: TextInputType.number,
                    hintText: PaymentTexts.pinHint,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) => pinValidator(value),
                  ),
                  const SizedBox(height: 15),
                  saveCard(payment.isChecked, (value) {
                    payment.onCheckClick(value);
                  }),
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlackButtonWidget(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (payment.payClicked) {
                              payment.onPayClick();
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              payment.onPayClick();
                              // await card.addCardRequest(
                              //     context,
                              //     cardNo.text.trim(),
                              //     expiryDate.text.trim(),
                              //     ccv.text.trim());
                            }
                          },
                          child: payment.payClicked
                              ? loadingIdicator()
                              : buttonText()),
                      const SizedBox(height: 15),
                      WhiteButtonWidget(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                          },
                          child: cancelButton())
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
