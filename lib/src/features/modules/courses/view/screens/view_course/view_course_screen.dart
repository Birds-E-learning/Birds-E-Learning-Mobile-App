import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
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
  State<ViewCourseScreen> createState() => _ViewCourseScreenState();
}

class _ViewCourseScreenState extends State<ViewCourseScreen>
    with SingleTickerProviderStateMixin, ContentWidget, CoursesText {
  TabController? _tabController;
  YoutubePlayerController? _controller;
  final List<String> _tabs = ['Description', 'Lessons', 'Assessment'];
  String title = "";

  @override
  void initState() {
    _tabController = _tabController = TabController(length: 3, vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // print(widget.course.toJson());
      context.read<PaidCoursesProvider>().refreshValues();
      context.read<PaidCoursesProvider>().getCourseSection(context, widget.course);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: leadingIcon(
          context,
          onTap: (){
            context.read<PaidCoursesProvider>().onDisposed(context, widget.course.id ?? "0");
            RoutingService.popRouting(context);
          }
        ),
        elevation: 0,
        title: Text(
            context.watch<PaidCoursesProvider>().currentlyPlayingLesson?.lessonTitle ?? "",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600)),
        backgroundColor: white,
      ),
      body: Consumer<PaidCoursesProvider>(
        builder: (_, course, __) => SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: CustomScrollView(
            slivers: <Widget>[
              // course.isLessonPlayed || (_controller != null )
              //     ? SliverPersistentHeader(
              //         delegate: _SliverTitleBarDelegate(
              //           title
              //         ),
              //         pinned: true,
              //         floating: true,
              //       )
              //     : const SliverPadding(padding: EdgeInsets.zero),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: !course.isLessonPlayed || _controller == null
                        ? CourseContainer(course: widget.course)
                        : VideoPlayerContainer(
                            controller: _controller!,
                            courseId: widget.course.id ?? "0",
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

  _updateController(CourseModel lesson){
    // if(lesson.pauseVideo == true && _controller != null){
    //   _controller!.pause();
    //   return;
    // }
    // print("lesson url ===>> ${lesson.lessonUrl} ===>>> lesson id ===>> ${lesson.lessonId}");
    String? videoId = YoutubePlayer.convertUrlToId(lesson.lessonUrl ?? "");
    // print("video id ====>>> $videoId");
    final ref = context.read<PaidCoursesProvider>();
    ref.onPlayButtonClick(context, lesson, widget.course.id?.toString() ?? "0");

    setState(() {
      title = lesson.lessonTitle ?? "";
    });
    if (videoId != null){
      if(_controller != null){
        _controller!.pause();
        // print("here ======>.>>>>>>> ");
        _controller!.load(videoId);
      }else{
        setState(() {
          _controller = YoutubePlayerController(
              initialVideoId: videoId, flags:  const YoutubePlayerFlags(
              autoPlay: false,
              controlsVisibleAtStart: true,
              forceHD: true,
              // startAt: lesson.lessonLastPlayedDuration != null ?
              // int.parse(lesson.lessonLastPlayedDuration!.toString()) : 0
          )
          );
        });
      }
    }
  }


  @override
  void dispose() {
    _controller != null ? _controller!.dispose() : null;
    super.dispose();
  }

  @override
  void deactivate() {
    _controller != null ? _controller!.pause() : null;
    super.deactivate();
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

// class _SliverTitleBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverTitleBarDelegate(this.title);
//   final String title;
//
//   @override
//   double get minExtent => 25;
//   @override
//   double get maxExtent => 25;
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.white,
//       child:  Text(
//         context.watch<PaidCoursesProvider>().currentlyPlayingLesson != null ?
//         context.watch<PaidCoursesProvider>().currentlyPlayingLesson!.lessonTitle ?? "" : "",
//         style: const TextStyle(
//           fontSize: 16, fontWeight: FontWeight.w600
//       ),),
//     );
//   }
//
//   @override
//   bool shouldRebuild(_SliverTitleBarDelegate oldDelegate) {
//     return false;
//   }
// }