import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_row_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/buy_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/more_card_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuickCoursesScreen extends StatefulWidget {
  const QuickCoursesScreen({super.key});

  @override
  State<QuickCoursesScreen> createState() => _QuickCoursesScreenState();
}

class _QuickCoursesScreenState extends State<QuickCoursesScreen>
    with HomeWidgets, HomeText {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(
      builder: (_, home, __) => BackgroundWidget(
        appBar: SliverAppBar(
          title: appBarTex("Quick Courses"),
          centerTitle: false,
          pinned: true,
          floating: true,
          backgroundColor: backgroundBlurColor,
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
            child: home.quickCourses.isEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, int index) {
                      return const MoreCardsShimmer();
                    })
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: home.quickCourses.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return CourseRowCards(
                        course: home.quickCourses[index],
                        onTap: () => RoutingService.pushFullScreenRouting(
                            context,
                            BuyCourseScreen(course: home.quickCourses[index])),
                      );
                    }),
          ),
        ),
      ),
    );
  }
}
