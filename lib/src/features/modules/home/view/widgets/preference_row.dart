import 'package:birds_learning_network/src/features/core/settings/view_model/filter_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
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
    FilterProvider filter = Provider.of<FilterProvider>(context, listen: false);
    FilterProvider filterWatch = Provider.of<FilterProvider>(context);
    return Consumer<HomeProvider>(
      builder: (_, home, __) => SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filter.myList.length,
          itemBuilder: (BuildContext context, int index) {
            if (home.selectedCards.length < filter.myList.length) {
              home.selectedCards.add(false);
            }
            return InkWell(
              onTap: () {
                if (!home.selectedCards[index] &&
                    controller.text.trim().isEmpty) {
                  home.setValue(index);
                  controller.text = filter.myList[index];
                  home.onSearchTriggered(true);
                  home.onSearchClicked(controller.text.trim());
                } else if (home.selectedCards[index] &&
                    controller.text.trim() == filter.myList[index]) {
                  controller.text = "";
                  home.setValue(index);
                  home.onSearchTriggered(false);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: topicText(
                    filterWatch.myList[index],
                    home.selectedCards[index] ? white : grey700,
                    home.selectedCards[index] ? grey700 : Colors.transparent),
              ),
            );
          },
        ),
      ),
    );
  }
}
