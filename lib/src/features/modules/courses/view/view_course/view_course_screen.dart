import 'package:birds_learning_network/src/features/modules/courses/view/widgets/course_container.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/course_data.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/course_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/courses_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/content_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ViewCourseScreen extends StatefulWidget {
  const ViewCourseScreen({
    super.key,
    required this.course,
  });
  final Courses course;

  @override
  // ignore: no_logic_in_create_state
  State<ViewCourseScreen> createState() => _ViewCourseScreenState();
}

class _ViewCourseScreenState extends State<ViewCourseScreen>
    with SingleTickerProviderStateMixin, ContentWidget, CoursesText {
  TabController? _tabController;
  final List<String> _tabs = ['Lectures', 'Resources', 'Assessment'];
  Courses? _course;

  @override
  void initState() {
    super.initState();
    _tabController = _tabController = TabController(length: 3, vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      var json = await CoursePreference.getCourseById(widget.course.id!);
      json != null
          ? setState(() {
              _course = Courses.fromJson(json);
            })
          : null;
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: leadingIcon(context),
        elevation: 0,
        backgroundColor: white,
      ),
      body: Consumer<PaidCoursesProvider>(
        builder: (_, course, __) => SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CourseContainer(course: widget.course),
              const SizedBox(height: 20),
              Stack(
                children: [
                  TabBar(
                    tabs: _tabs
                        .map((tab) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(tab,
                                  textAlign: TextAlign.left,
                                  style: CourseContentStyle.pageHeaderStyle),
                            ))
                        .toList(),
                    controller: _tabController,
                    isScrollable: false,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    indicatorWeight: 3,
                    indicator: const ShapeDecoration(
                        color: skipColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: skipColor,
                    indicatorPadding: const EdgeInsets.only(top: 22),
                    padding: EdgeInsets.zero,
                    onTap: (index) => course.onTabClick(index),
                  ),
                  const Positioned(
                      bottom: -8,
                      right: 0,
                      left: 0,
                      child: Divider(
                        thickness: 0.5,
                        color: grey100,
                      ))
                ],
              ),
              Flexible(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: TabBarView(
                    controller: _tabController,
                    children: course
                        .getTabWidget(_course ?? widget.course)
                        .values
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
