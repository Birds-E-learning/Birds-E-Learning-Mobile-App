import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/request_model/stripe_payment.dart';
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
  const PaymentScreen({super.key, required this.course});
  final Courses course;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with PaymentWidgets, CardValidator {
  TextEditingController cardNo = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController ccv = TextEditingController();
  bool isDisabled = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cardNo.dispose();
    expiryDate.dispose();
    ccv.dispose();
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
                    onChanged: (val) => validateFields(),
                    keyboardType: TextInputType.number,
                    hintText: PaymentTexts.cardHint,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(19),
                      FilteringTextInputFormatter.digitsOnly,
                      CardNumberFormatter(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextColumn(
                            controller: expiryDate,
                            text: PaymentTexts.expiryText,
                            onChanged: (val) => validateFields(),
                            keyboardType: TextInputType.number,
                            hintText: PaymentTexts.expiryHint,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.digitsOnly,
                              CardExpirationFormatter(),
                            ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomTextColumn(
                          controller: ccv,
                          onChanged: (val) => validateFields(),
                          text: PaymentTexts.ccvText,
                          keyboardType: TextInputType.number,
                          hintText: PaymentTexts.ccvHint,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 15),
                  // saveCard(payment.isChecked, (value) {
                  //   payment.onCheckClick(value);
                  // }),
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlackButtonWidget(
                        isDisabled: isDisabled,
                          onPressed: isDisabled ? null : () async {
                            FocusScope.of(context).unfocus();
                            if (payment.payClicked) {
                              payment.onPayClick();
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              payment.onPayClick();
                              StripePaymentRequest data = StripePaymentRequest(
                                cardNo: cardNo.text.trim(),
                                expiryDate: expiryDate.text.trim(),
                                ccv: ccv.text.trim(),
                                amount: widget.course.salePrice,
                              );
                              await payment.getPaymentToken(context,
                                  card: data, course: widget.course);
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
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: stripeText(),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  void validateFields(){
    if(cardNo.text.length == 19
    && expiryDate.text.length == 5 && ccv.text.length == 3){
      isDisabled = false;
    }else{
      isDisabled = true;
    }
    setState(() {});
  }
}
