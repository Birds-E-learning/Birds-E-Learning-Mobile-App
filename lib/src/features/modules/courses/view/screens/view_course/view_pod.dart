// import 'package:birds_learning_network/src/features/modules/courses/view/screens/view_course/sliver_appbar.dart';
// import 'package:birds_learning_network/src/features/modules/courses/view/screens/view_course/sliver_title_bar.dart';
// import 'package:birds_learning_network/src/features/modules/courses/view/widgets/course_container.dart';
// import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
// import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
// import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/course_data.dart';
// import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
// import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/course_style.dart';
// import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/courses_texts.dart';
// import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
// import 'package:birds_learning_network/src/utils/mixins/module_mixins/content_mixins.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:pod_player/pod_player.dart';
// import 'package:provider/provider.dart';
//
// class ViewCourseScreenP extends StatefulWidget {
//   const ViewCourseScreenP({
//     super.key,
//     required this.course,
//   });
//   final Courses course;
//
//   @override
//   // ignore: no_logic_in_create_state
//   State<ViewCourseScreenP> createState() => _ViewCourseScreenPState();
// }
//
// class _ViewCourseScreenPState extends State<ViewCourseScreenP>
//     with SingleTickerProviderStateMixin, ContentWidget, CoursesText {
//   TabController? _tabController;
//   PodPlayerController? _controller;
//   final List<String> _tabs = ['Lectures', 'Resources', 'Assessment'];
//   Courses? _course;
//   bool _isDisposed = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = _tabController = TabController(length: 3, vsync: this);
//     Provider.of<PaidCoursesProvider>(context, listen: false)
//         .refreshValues(isInit: true);
//     SchedulerBinding.instance.addPostFrameCallback((_) async {
//       var json = await CoursePreference.getCourseById(widget.course.id!);
//       json != null
//           ? setState(() {
//         _course = Courses.fromJson(json);
//       })
//           : null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         leading: leadingIcon(context),
//         elevation: 0,
//         backgroundColor: white,
//       ),
//       body: Consumer<PaidCoursesProvider>(
//         builder: (_, course, __) => SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
//               child: CustomScrollView(
//                 slivers: <Widget>[
//                   course.isLessonPlayed ||
//                       (_controller != null && _controller!.isFullScreen)
//                       ? SliverPersistentHeader(
//                     delegate: SliverTitleBarDelegate("hello"),
//                     pinned: true,
//                     floating: true,
//                   )
//                       : const SliverPadding(padding: EdgeInsets.zero),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                         padding: const EdgeInsets.only(bottom: 15),
//                         child: !course.isLessonPlayed || _isDisposed
//                             ? CourseContainer(course: widget.course)
//                             : null
//                         // VideoPlayerContainer(
//                         //   controller: _controller!,
//                         // ),
//                     ),
//                   ),
//                   SliverPersistentHeader(
//                     delegate: SliverAppBarDelegate(
//                       TabBar(
//                         tabs: _tabs
//                             .map((tab) => Padding(
//                           padding: const EdgeInsets.only(bottom: 5),
//                           child: Text(tab,
//                               textAlign: TextAlign.left,
//                               style: CourseContentStyle.pageHeaderStyle),
//                         ))
//                             .toList(),
//                         controller: _tabController,
//                         isScrollable: false,
//                         labelPadding: const EdgeInsets.symmetric(horizontal: 10),
//                         indicatorWeight: 3,
//                         indicatorSize: TabBarIndicatorSize.label,
//                         indicatorColor: skipColor,
//                         indicatorPadding: const EdgeInsets.only(top: 22),
//                         padding: EdgeInsets.zero,
//                         onTap: (index) => course.onTabClick(index),
//                       ),
//                     ),
//                     pinned: true,
//                     floating: true,
//                   ),
//                   SliverFillRemaining(
//                     child: AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 500),
//                       child: TabBarView(
//                         controller: _tabController,
//                         children: course
//                             .getTabWidget(
//                             _course ?? widget.course, _updatePodController)
//                             .values
//                             .toList(),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
//
//   void _updatePodController(String vidUrl) {
//     if (_controller != null) {
//       _controller!.pause();
//       _controller!.dispose();
//       _isDisposed = true;
//       setState(() {});
//     }
//     if (vidUrl.isNotEmpty) {
//       Provider.of<PaidCoursesProvider>(context, listen: false)
//           .onPlayButtonClick(vidUrl);
//       setState(() {
//         _controller = PodPlayerController(
//           playVideoFrom:
//           Provider.of<PaidCoursesProvider>(context, listen: false)
//               .podPlayerService(),
//           podPlayerConfig: const PodPlayerConfig(
//               autoPlay: true,
//               isLooping: false,
//               videoQualityPriority: [720, 360]),
//         )..initialise().then((value) {
//           _isDisposed = false;
//           _controller!.play();
//           _controller!.addListener(() {
//             if (_controller!.currentVideoPosition.inSeconds ==
//                 _controller!.totalVideoLength.inSeconds) {
//               if (!_isDisposed) {
//                 _controller!.dispose();
//                 _isDisposed = true;
//               }
//             }
//           });
//         });
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller != null ? _controller!.dispose() : null;
//     super.dispose();
//   }
// }
//
//
//
//
//
//
// // Column(
// //   crossAxisAlignment: CrossAxisAlignment.start,
// //   children: [
// //     CourseContainer(course: widget.course),
// //     // Container(
// //     //   width: double.infinity,
// //     //   height: 200,
// //     //   decoration: BoxDecoration(
// //     //       border: Border.all(width: 1, color: borderColor),
// //     //       borderRadius: BorderRadius.circular(20)),
// //     //   child: PodVideoPlayer(
// //     //     controller: course.controller,
// //     //   ),
// //     // ),
// //     const SizedBox(height: 20),
// //     Stack(
// //       children: [
// //         TabBar(
// //           tabs: _tabs
// //               .map((tab) => Padding(
// //                     padding: const EdgeInsets.only(bottom: 5),
// //                     child: Text(tab,
// //                         textAlign: TextAlign.left,
// //                         style:
// //                             CourseContentStyle.pageHeaderStyle),
// //                   ))
// //               .toList(),
// //           controller: _tabController,
// //           isScrollable: false,
// //           labelPadding:
// //               const EdgeInsets.symmetric(horizontal: 10),
// //           indicatorWeight: 3,
// //           indicator: const ShapeDecoration(
// //               color: skipColor,
// //               shape: RoundedRectangleBorder(
// //                   borderRadius:
// //                       BorderRadius.all(Radius.circular(20)))),
// //           indicatorSize: TabBarIndicatorSize.label,
// //           indicatorColor: skipColor,
// //           indicatorPadding: const EdgeInsets.only(top: 22),
// //           padding: EdgeInsets.zero,
// //           onTap: (index) => course.onTabClick(index),
// //         ),
// //         const Positioned(
// //             bottom: -8,
// //             right: 0,
// //             left: 0,
// //             child: Divider(
// //               thickness: 0.5,
// //               color: grey100,
// //             ))
// //       ],
// //     ),
// //     Flexible(
// //       child: AnimatedSwitcher(
// //         duration: const Duration(milliseconds: 500),
// //         child: TabBarView(
// //           controller: _tabController,
// //           children: course
// //               .getTabWidget(_course ?? widget.course)
// //               .values
// //               .toList(),
// //         ),
// //       ),
// //     ),
// //   ],
// // ),