import 'package:birds_learning_network/src/features/modules/profile/model/response_model/get_card_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget with ProfileWidgets {
  const CustomCard({super.key, required this.card});
  final CardResponseData card;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          ImagePath.debitCard,
          height: 234,
        ),
        Positioned(
          top: size.width * 0.08,
          left: size.width <= 360
              ? 28
              : size.width <= 410
                  ? 36
                  : 40,
          child: cardNumber(card.cardNo ?? "**** **** **** ****"),
        ),
        Positioned(
          top: size.width * 0.25,
          right: size.width <= 360
              ? 28
              : size.width <= 410
                  ? 36
                  : 40,
          child: Image.asset(
            (card.cardType.toString().toLowerCase() == "mastercard")
                ? ImagePath.mastercard
                : card.cardType.toString().toLowerCase() == "verve"
                    ? ImagePath.verve
                    : ImagePath.visa,
          ),
        ),
        Positioned(
            top: size.width * 0.40,
            left: size.width <= 360
                ? 28
                : size.width <= 410
                    ? 36
                    : 40,
            child: Row(
              children: [
                cardDetailsText(card.cardType!),
                const SizedBox(width: 12),
                cardDetailsText(card.expiryDate!),
              ],
            ))
      ],
    );
  }
}
