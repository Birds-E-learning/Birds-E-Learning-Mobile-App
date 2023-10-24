import 'package:birds_learning_network/src/features/modules/subscription/model/response_model/subscription_type.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/shared_functions/convert_currency.dart';
import 'package:flutter/material.dart';

class SubscriptionCardWidget extends StatelessWidget {
  const SubscriptionCardWidget({super.key,
  required this.duration, this.selectedValue, this.onChanged, this.isSelected = false});
  final DurationData duration;
  final String? selectedValue;
  final bool isSelected;
  final ValueChanged<dynamic>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration:  BoxDecoration(
          color: isSelected ? white900 : white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? success600 : const Color.fromRGBO(0, 0, 0, 0.3))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Row(
                children: [
                  Radio(value: duration.duration, groupValue: selectedValue,
                      activeColor: black,
                      onChanged: onChanged),
                  const SizedBox(width: 12),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        duration.duration != null ?
                          "${duration.duration![0].toUpperCase()}${duration.duration!.substring(1).toLowerCase()}" : "",
                        style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),),
                      const SizedBox(height: 6),
                      Text("Pay for a ${duration.duration != null ?
                            duration.duration!.toLowerCase().replaceAll("ly", "") : ""}", style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: greys200,
                          fontFamily: "Inter"
                      ),)
                    ],
                  )
                ],
              )
          ),
          RichText(
            textAlign: TextAlign.justify,
            text:  TextSpan(
                text: convertCurrency(duration.currency),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                    color: skipColor
                ),
                children: [
                  TextSpan(
                    text: "${duration.amount ?? 0}",
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter",
                        color: skipColor
                    ),
                  )
                ]
            ),
          )
        ],
      ),
    );
  }
}

