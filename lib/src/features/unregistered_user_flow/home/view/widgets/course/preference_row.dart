import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view_model/course_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view_model/home_provider.dart';
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
    UnregisteredHomeProvider filter = context.read<UnregisteredHomeProvider>();
    UnregisteredHomeProvider filterWatch = context.watch<UnregisteredHomeProvider>();
    return Consumer<UnregisteredCourseProvider>(
      builder: (_, course, __) => SizedBox(
        height: 40,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          scrollDirection: Axis.horizontal,
          itemCount: filter.prefList.length,
          itemBuilder: (BuildContext context, int index) {
            if (course.selectedCards.length < filter.prefList.length) {
              course.selectedCards.add(false);
            }
            return InkWell(
              onTap: () {
                if (!course.selectedCards[index] &&
                    controller.text.trim().isEmpty) {
                  course.setValue(index); // this sets the index of the category selected by the user to true
                  controller.text = filter.prefList[index]; // this populates the controller with the category selected
                  course.onSearchTriggered(true); // this triggers the search functionality
                  course.onSearchClicked(controller.text.trim());
                } else if (course.selectedCards[index] &&
                    controller.text.trim() == filter.prefList[index]) { // this condition checks if the category is selected already
                  controller.text = ""; // this clears the text controller
                  course.setValue(index); // this reverses the boolean value of selected cards to false
                  course.onSearchTriggered(false);
                }
              },
              child: topicText(
                  filterWatch.prefList[index],
                  course.selectedCards[index] ? white : grey700,
                  course.selectedCards[index] ? grey700 : Colors.transparent),
            );
          },
        ),
      ),
    );
  }
}
