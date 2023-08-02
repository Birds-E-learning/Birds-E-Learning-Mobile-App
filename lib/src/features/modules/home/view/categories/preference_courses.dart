import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_row_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/course/no_course_widget.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/more_card_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreferenceCoursesScreen extends StatefulWidget {
  const PreferenceCoursesScreen({super.key});

  @override
  State<PreferenceCoursesScreen> createState() =>
      _PreferenceCoursesScreenState();
}

class _PreferenceCoursesScreenState extends State<PreferenceCoursesScreen>
    with HomeWidgets, HomeText {
  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).refreshData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(
      builder: (_, home, __) => BackgroundWidget(
        appBar: SliverAppBar(
          title: appBarTex("Top Picks for you"),
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
            child: home.prefCourses.isEmpty
                ? home.isPrefLoading
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
                    itemCount: home.prefCourses.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return CourseRowCards(
                        course: home.prefCourses[index],
                      );
                    }),
          ),
        ),
      ),
    );
  }
}
