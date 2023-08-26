import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/more_card_shimmer.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view/widgets/no_course_widget.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view_model/course_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/custom_widgets/course_row_card.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnregisteredPreferenceCoursesScreen extends StatefulWidget {
  const UnregisteredPreferenceCoursesScreen({super.key});

  @override
  State<UnregisteredPreferenceCoursesScreen> createState() =>
      _UnregisteredPreferenceCoursesScreenState();
}

class _UnregisteredPreferenceCoursesScreenState extends State<UnregisteredPreferenceCoursesScreen>
    with HomeWidgets, HomeText {
  @override
  void initState() {
    Provider.of<UnregisteredCourseProvider>(context, listen: false).refreshData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<UnregisteredCourseProvider>(
      builder: (_, course, __) => BackgroundWidget(
        appBar: SliverAppBar(
          title: appBarTex("Top Picks for you"),
          centerTitle: false,
          pinned: true,
          floating: true,
          leading: leadingIcon(context),
          elevation: 0,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.height * 0.02),
            child: course.prefCourses.isEmpty
                ? course.prefStatus == Status.loading
                    ?  ListView.separated(
                        separatorBuilder: (_, __) => const SizedBox(
                              height: 10,
                              child: Divider(thickness: 0.2, color: success1000),
                            ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 8,
                        itemBuilder: (context, int index) {
                          return const MoreCardsShimmer();
                        })
                    : const EmptyCategoryWidget(category: "Preference")
                : ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(
                          height: 10,
                          child: Divider(thickness: 0.2, color: success1000),
                        ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: course.prefCourses.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      // print("pref courses ====>> ${course.prefCourses}");
                      return UnregisteredCourseRowCards(
                        course: course.prefCourses[index],
                      );
                    }),
          ),
        ),
      ),
    );
  }
}
