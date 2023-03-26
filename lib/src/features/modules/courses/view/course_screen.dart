import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/alll_courses_screen.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/courses_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/courses_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCoursesPage extends StatelessWidget
    with CourseTextWidgets, CoursesText {
  const MyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundWidget(
      appBar: SliverAppBar(
        title: appBarText(CoursesText.myCourses),
        pinned: true,
        floating: true,
        elevation: 0,
        backgroundColor: backgroundBlurColor,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.1),
              SvgPicture.asset(ImagePath.noCourse),
              const SizedBox(height: 20),
              noCourseText(() {
                RoutingService.pushRouting(context, const AllCoursesScreen());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
