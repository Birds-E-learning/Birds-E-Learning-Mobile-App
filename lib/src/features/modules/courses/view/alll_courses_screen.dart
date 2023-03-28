import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/course_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_row_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/buy_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/more_card_shimmer.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/courses_styles/ny_courses_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({super.key});

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen>
    with HomeWidgets, HomeText {
  @override
  void initState() {
    Provider.of<CourseProvider>(context, listen: false).getCourses(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Provider.of<CourseProvider>(context, listen: false).getCourses(context);
    return Consumer<CourseProvider>(
      builder: (_, course, __) => BackgroundWidget(
        appBar: SliverAppBar(
          title: appBarTex("Available Courses"),
          centerTitle: false,
          pinned: true,
          floating: true,
          backgroundColor: backgroundBlurColor,
          leading: leadingIcon(context),
          elevation: 0,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.height * 0.02),
            child: course.allCourses.isEmpty && course.isLoading
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 12,
                    itemBuilder: (context, int index) {
                      return const MoreCardsShimmer();
                    })
                : course.allCourses.isEmpty && !course.isLoading
                    ? const Center(
                        child: Text(
                        "No available course found",
                        style: CourseStyles.noCourseLabelStyle,
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: course.allCourses.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return CourseRowCards(
                            course: course.allCourses[index],
                            onTap: () => RoutingService.pushFullScreenRouting(
                                context,
                                BuyCourseScreen(
                                    course: course.allCourses[index])),
                          );
                        }),
          ),
        ),
      ),
    );
  }
}
