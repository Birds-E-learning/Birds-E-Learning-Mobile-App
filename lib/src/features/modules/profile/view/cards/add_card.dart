import 'package:birds_learning_network/src/features/modules/profile/custom_widgets/custom_text_column.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/card_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:birds_learning_network/src/utils/validators/card_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage>
    with ProfileWidgets, CardValidator {
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
        title: appBarText(ProfileTexts.addCard),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        leading: leadingIcon(context),
      ),
      body: Consumer<CardProvider>(
        builder: (_, card, __) => SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.05),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextColumn(
                    controller: cardNo,
                    text: ProfileTexts.cardNo,
                    keyboardType: TextInputType.number,
                    hintText: ProfileTexts.cardHint,
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
                            text: ProfileTexts.expiryText,
                            keyboardType: TextInputType.number,
                            hintText: ProfileTexts.expiryHint,
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
                          text: ProfileTexts.ccvText,
                          keyboardType: TextInputType.number,
                          hintText: ProfileTexts.ccvHint,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) => cvvValidator(value),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 25),
                  // CustomTextColumn(
                  //   controller: pin,
                  //   text: ProfileTexts.pinText,
                  //   keyboardType: TextInputType.number,
                  //   hintText: ProfileTexts.pinHint,
                  //   inputFormatters: [
                  //     LengthLimitingTextInputFormatter(4),
                  //     FilteringTextInputFormatter.digitsOnly,
                  //   ],
                  //   validator: (value) => pinValidator(value),
                  // ),
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlackButtonWidget(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (card.addClicked) {
                              card.onAddClick();
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              card.onAddClick();
                              await card.addCardRequest(
                                  context,
                                  cardNo.text.trim(),
                                  expiryDate.text.trim(),
                                  ccv.text.trim());
                            }
                          },
                          child: card.addClicked
                              ? loadingIdicator()
                              : buttonText(ProfileTexts.addCardButton)),
                      const SizedBox(height: 15),
                      WhiteButtonWidget(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                          },
                          child: cancelButton(ProfileTexts.cancelButton))
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

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}
