import 'dart:io';
import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/view_course/view_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/html_page.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/course/action_buttons.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/course/course_info.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/home_course/preview_container.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/home_course/section_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/section_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/course_content_provider.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/screens/subscription_screen.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/home_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/text_style.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/content_mixins.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:birds_learning_network/src/utils/shared_functions/active_subscription.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BuyCourseScreen extends StatefulWidget {
  const BuyCourseScreen({
    super.key,
    required this.course,
    this.isFcilitator = false,
  });
  final Courses course;
  final bool isFcilitator;

  @override
  State<BuyCourseScreen> createState() => _BuyCourseScreenState();
}

class _BuyCourseScreenState extends State<BuyCourseScreen>
    with HomeWidgets, ContentWidget, TickerProviderStateMixin {
  VideoPlayerController? videoPlayerController;
  ChewieController? _controller;
  YoutubePlayerController? _ytController;
  final key1 = GlobalKey();
  bool isSubscriptionActive = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Provider.of<CourseContentProvider>(context, listen: false).reset();
      await showVideoPlayer(context, widget.course.video!);
      await getCourseSection();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<CourseContentProvider>(
        builder: (_, content, __) => SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => RoutingService.popRouting(context),
                    child: Icon(Platform.isAndroid
                        ? Icons.arrow_back
                        : Icons.arrow_back_ios),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Container(
                          key: key1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: 200,
                          width: double.infinity,
                          child: content.showVideo
                              ? content.isVideo && _controller != null
                                  ? _controller!.videoPlayerController.value
                                          .isInitialized
                                      ? Chewie(controller: _controller!)
                                      : PreviewContainer(
                                          image: widget.course.imageUrl)
                                  : content.isYoutube && _ytController != null
                                      ? YoutubePlayer(
                                          controller: _ytController!,
                                          showVideoProgressIndicator: true,
                                          progressColors:
                                              const ProgressBarColors(
                                            playedColor: backgroundBlurColor,
                                            handleColor: white,
                                          ),
                                        )
                                      : PreviewContainer(
                                          image: widget.course.imageUrl)
                              : PreviewContainer(
                                  image: widget.course.imageUrl,
                                  loaded: false,
                                  onTap: () {
                                    content.onPreviewClick(true);
                                  },
                                )),
                    ),
                  ),
                  CourseInfoWidget(
                      course: widget.course,
                      isSubscriptionActive: isSubscriptionActive,
                      isFacilitator: widget.isFcilitator),
                  const SizedBox(height: 20),
                  HTMLPageScreen(
                    content: widget.course.content ?? "",
                  ),
                  const SizedBox(height: 10),
                  headerText("Course Content"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      color: success400,
                      thickness: 0.7,
                    ),
                  ),
                  content.sectionLoading
                      ? widget.course.sections!.isEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return const SectionShimmer();
                              },
                              separatorBuilder: (_, __) => const Divider(
                                    color: success400,
                                    thickness: 0.7,
                                  ),
                              itemCount: 5)
                          : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: success400,
                                thickness: 0.7,
                              ),
                              itemCount: widget.course.sections!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                if (content.selectedLesson.length <
                                    widget.course.sections!.length) {
                                  content.selectedLesson.add(false);
                                }
                                return SectionCard(
                                    index: index,
                                    onPlayTap: () async {
                                      await showVideoPlayer(
                                          context,
                                          widget.course.sections![0]
                                                  .lessons![index].url ??
                                              "https://www.youtube.com/watch?v=tO01J-M3g0U");
                                      Scrollable.ensureVisible(
                                          key1.currentContext!,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut);
                                    },
                                    onLessonTap: () {
                                      content.setSelectedLesson(index);
                                    },
                                    section: widget.course.sections![index]);
                              },
                            )
                      : widget.course.sections!.isEmpty
                          ? const Center(
                              child: Text(
                                "No available course content for preview. Buy now!",
                                style: CartStyles.richStyle1,
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: success400,
                                thickness: 0.7,
                              ),
                              itemCount: widget.course.sections!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                if (content.selectedLesson.length <
                                    widget.course.sections!.length) {
                                  content.selectedLesson.add(false);
                                }
                                return SectionCard(
                                    index: index,
                                    onPlayTap: () async {
                                      await showVideoPlayer(
                                          context,
                                          widget.course.sections![0]
                                                  .lessons![index].url ??
                                              "https://www.youtube.com/watch?v=tO01J-M3g0U");
                                      Scrollable.ensureVisible(
                                          key1.currentContext!,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut);
                                    },
                                    onLessonTap: () {
                                      content.setSelectedLesson(index);
                                    },
                                    section: widget.course.sections![index]);
                              },
                            ),
                  // const SizedBox(height: 10),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     headerText("Student Testimonials"),
                  //     const SizedBox(height: 5),
                  //     totalStudentText(5423),
                  //     const SizedBox(height: 10),
                  //     ListView.builder(
                  //         itemCount: 3,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         shrinkWrap: true,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           return const TestimonyCard();
                  //         })
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  Container(
                      child: widget.course.subscriptionBased != null && widget.course.subscriptionBased!
                      ? null
                      :  widget.course.salePrice == "0.00"
                          ? freeText()
                          : bigAmountText(widget.course.salePrice ?? "00.00"),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      child: widget.course.subscriptionBased != null &&  widget.course.subscriptionBased!
                      ? !isSubscriptionActive
                         ? SizedBox(
                            width: double.infinity,
                            child: BlackButtonWidget(
                                onPressed: () => RoutingService.pushRouting(context, const SubscriptionScreen()),
                                child: Text(
                                  "Subscribe",
                                  style: TextStyles.buttonStyle.copyWith(color: nextColor),
                                )),
                          )
                        : SizedBox(
                          width: double.infinity,
                          child: BlackButtonWidget(
                              onPressed: () => RoutingService.pushRouting(context,  ViewCourseScreen(course: widget.course)),
                              child: Text(
                                "Proceed to Course",
                                style: TextStyles.buttonStyle.copyWith(color: nextColor),
                              )),
                        )
                      : CourseActionButtons(course: widget.course),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> youtubePlayer(String vidUrl) async {
    Provider.of<CourseContentProvider>(context, listen: false)
        .onPreviewClick(false);
    List vidId =
        vidUrl.contains("?v=") ? vidUrl.split("?v=") : vidUrl.split("/");
    _ytController = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(vidUrl) ?? vidId[vidId.length - 1],
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  Future<void> loadVideoPlayer(String vidUrl) async {
    Provider.of<CourseContentProvider>(context, listen: false)
        .onPreviewClick(false);
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(vidUrl));
    await Future.wait([videoPlayerController!.initialize()]);
    _controller = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: false,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: HomeStyles.authorNameStyle,
          ),
        );
      },
    );
  }

  Future showVideoPlayer(context, String vidUrl) async {
    if (vidUrl.toLowerCase().contains("youtube.com")) {
      Provider.of<CourseContentProvider>(context, listen: false).youtubeVid =
          true;
      await youtubePlayer(vidUrl);
      if (mounted) setState(() {});
    } else if (vidUrl.toLowerCase().contains(".mp4")) {
      Provider.of<CourseContentProvider>(context, listen: false).video = true;
      await loadVideoPlayer(vidUrl);
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _ytController == null ? null : _ytController!.dispose();
    videoPlayerController == null ? null : videoPlayerController!.dispose();
    _controller == null ? null : _controller!.dispose();
    super.dispose();
  }

  Future getCourseSection() async {
    if (widget.course.sections == null || widget.course.sections!.isEmpty) {
      widget.course.sections = <Sections>[];
      widget.course.sections =
          await Provider.of<CourseContentProvider>(context, listen: false)
              .getCourseSection(context, widget.course.id!);
      if(!mounted)return;
      isSubscriptionActive = await checkActiveSubscription(context);
      setState(() {});
    }
  }
}
