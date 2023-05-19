import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/alll_courses_screen.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/widgets/course_row.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/more_card_shimmer.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/courses_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/courses_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key, this.isFullScreen = false});
  final bool isFullScreen;

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage>
    with CourseTextWidgets, CoursesText, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    Provider.of<PaidCoursesProvider>(context, listen: false)
        .getPaidCoursesMethod(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    return Consumer<PaidCoursesProvider>(
      builder: (_, course, __) => BackgroundWidget(
        appBar: SliverAppBar(
          title: appBarText(CoursesText.myCourses),
          pinned: true,
          floating: true,
          leading: widget.isFullScreen ? leadingIcon(context) : null,
          elevation: 0,
          backgroundColor: backgroundBlurColor,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.01),
            child: !course.isLoading && course.courses.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.15),
                      SvgPicture.asset(ImagePath.noCourse),
                      const SizedBox(height: 20),
                      noCourseText(() {
                        RoutingService.pushRouting(
                            context, const AllCoursesScreen());
                      }),
                    ],
                  )
                : course.isLoading && course.courses.isEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 12,
                        itemBuilder: (context, int index) {
                          return const MoreCardsShimmer();
                        })
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: course.courses.length,
                        itemBuilder: (context, int index) {
                          course.courses[index].sections = <Sections>[];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: CourseRowWidget(
                                course: course.courses[index], percentage: 0),
                          );
                        }),
          ),
        ),
      ),
    );
  }
}
