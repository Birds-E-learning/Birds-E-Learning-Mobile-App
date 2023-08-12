import 'package:birds_learning_network/src/features/modules/courses/view/widgets/course_container.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/widgets/video_container.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/course_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/courses_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/content_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  YoutubePlayerController? _controller;
  final List<String> _tabs = ['Lectures', 'Resources', 'Assessment'];
  // bool _isDisposed = true;

  @override
  void initState() {
    _tabController = _tabController = TabController(length: 3, vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Provider.of<PaidCoursesProvider>(context, listen: false).refreshValues();
    Provider.of<PaidCoursesProvider>(context, listen: false)
        .getCourseSection(context, widget.course);
    });
    super.initState();
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
          child: CustomScrollView(
            slivers: <Widget>[
              course.isLessonPlayed ||
                      (_controller != null )
                  ? SliverPersistentHeader(
                      delegate: _SliverTitleBarDelegate(
                        "The current Lesson title should be here"
                      ),
                      pinned: true,
                      floating: true,
                    )
                  : const SliverPadding(padding: EdgeInsets.zero),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: !course.isLessonPlayed
                        ? CourseContainer(course: widget.course)
                        : VideoPlayerContainer(
                            controller: _controller!,
                          )),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
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
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: skipColor,
                    indicatorPadding: const EdgeInsets.only(top: 22),
                    padding: EdgeInsets.zero,
                    onTap: (index) => course.onTabClick(index),
                  ),
                ),
                pinned: true,
                floating: true,
              ),
              SliverFillRemaining(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: TabBarView(
                    controller: _tabController,
                    children: course
                        .getTabWidget( widget.course,
                        _updateController).values.toList(),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  _updateController(String url){

  }


  @override
  void dispose() {
    _controller != null ? _controller!.dispose() : null;
    super.dispose();
  }
}



class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 25;
  @override
  double get maxExtent => 25;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          _tabBar,
          const Positioned(
            bottom: -8,
            right: 0,
            left: 0,
            child: Divider(
              thickness: 0.5,
              color: grey100,
            ),
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _SliverTitleBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTitleBarDelegate(this.title);
  final String title;

  @override
  double get minExtent => 25;
  @override
  double get maxExtent => 25;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child:  Text(title, style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600
      ),),
    );
  }

  @override
  bool shouldRebuild(_SliverTitleBarDelegate oldDelegate) {
    return false;
  }
}