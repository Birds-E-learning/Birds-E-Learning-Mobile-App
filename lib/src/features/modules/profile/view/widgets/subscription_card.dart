import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/shared_functions/convert_currency.dart';
import 'package:birds_learning_network/src/utils/shared_functions/convert_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubscriptionCardWidget extends StatelessWidget {
  const SubscriptionCardWidget({super.key, this.subscription});
  final SubscriptionModel? subscription;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          ProfileTexts.subTitle,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: grey700
          ),
        ),
        const SizedBox(height: 24),
        SubscriptionContainer(
          text: "Current plan",
          value: "${convertCurrency(subscription?.currency ?? "USD")}${subscription?.amount ?? 0}",
          imagePath: ImagePath.currentPlan,
        ),
        const SizedBox(height: 16),
        SubscriptionContainer(
          text: "Billing cycle",
          value: "${subscription?.package}",
          imagePath: ImagePath.billingCycle,
        ),
        const SizedBox(height: 16),
        SubscriptionContainer(
          text: "Started on",
          value: convertDate(subscription?.createdAt ?? ""),
          imagePath: ImagePath.startedOn,
        ),
        const SizedBox(height: 16),
        SubscriptionContainer(
          text: "Due date",
          value: "${dateDifference(subscription?.expirationAt ?? DateTime.now().toString())} days",
          imagePath: ImagePath.dueDate,
        )
      ],
    );
  }
}


class SubscriptionContainer extends StatelessWidget {
  const SubscriptionContainer({
    required this.imagePath,
    required this.text,
    required this.value,
    super.key,
  });
  final String text;
  final String value;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: deepBlack.withOpacity(0.3)),
        color: inactiveDotColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SvgPicture.asset(imagePath),
              const SizedBox(width: 24),
              Text(
                text,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: deepBlack
                ),
              )
            ],
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: skipColor
            ),
          )
        ],
      ),
    );
  }
}

