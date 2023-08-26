import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_row_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/screens/buy_course_screen.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';

import '../../model/response_model/get_courses.dart';

class CategoryScreen extends StatelessWidget with HomeWidgets, HomeText {
  const CategoryScreen({super.key, required this.title, required this.courses});
  final String title;
  final List<Courses> courses;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BackgroundWidget(
      appBar: SliverAppBar(
        title: appBarTex(title),
        centerTitle: false,
        pinned: true,
        floating: true,
        leading: leadingIcon(context),
        elevation: 0,
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.notifications,
        //         color: greys800,
        //       ))
        // ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04, vertical: size.height * 0.02),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return CourseRowCards(
                  course: courses[index],
                  onTap: () => RoutingService.pushFullScreenRouting(
                      context, BuyCourseScreen(course: courses[index])),
                );
              }),
        ),
      ),
    );
  }
}
