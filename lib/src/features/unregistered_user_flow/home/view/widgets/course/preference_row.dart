import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/preference_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/filter_mixins/filter_mixin.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreferenceRowContainer extends StatelessWidget
    with HomeWidgets, FilterTextWidgets {
  const PreferenceRowContainer({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomePreferenceProvider filter =
        Provider.of<HomePreferenceProvider>(context, listen: false);
    HomePreferenceProvider filterWatch =
        Provider.of<HomePreferenceProvider>(context);
    return Consumer<HomeProvider>(
      builder: (_, home, __) => SizedBox(
        height: 40,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          scrollDirection: Axis.horizontal,
          itemCount: filter.prefList.length,
          itemBuilder: (BuildContext context, int index) {
            if (home.selectedCards.length < filter.prefList.length) {
              home.selectedCards.add(false);
            }
            return InkWell(
              onTap: () {
                if (!home.selectedCards[index] &&
                    controller.text.trim().isEmpty) {
                  home.setValue(index);
                  controller.text = filter.prefList[index];
                  home.onSearchTriggered(true);
                  home.onSearchClicked(controller.text.trim());
                } else if (home.selectedCards[index] &&
                    controller.text.trim() == filter.prefList[index]) {
                  controller.text = "";
                  home.setValue(index);
                  home.onSearchTriggered(false);
                }
              },
              child: topicText(
                  filterWatch.prefList[index],
                  home.selectedCards[index] ? white : grey700,
                  home.selectedCards[index] ? grey700 : Colors.transparent),
            );
          },
        ),
      ),
    );
  }
}
