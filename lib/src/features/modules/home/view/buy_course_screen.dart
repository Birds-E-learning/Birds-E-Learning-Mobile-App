import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses_pref.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/error_widget.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/lesson_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/testimony_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/course_content_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/home_styles.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/content_mixins.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BuyCourseScreen extends StatefulWidget {
  const BuyCourseScreen({
    super.key,
    required this.course,
  });
  final CoursesPref course;

  @override
  State<BuyCourseScreen> createState() => _BuyCourseScreenState();
}

class _BuyCourseScreenState extends State<BuyCourseScreen>
    with HomeWidgets, ContentWidget, TickerProviderStateMixin {
  late VideoPlayerController videoPlayerController;
  ChewieController? _controller;
  late YoutubePlayerController _ytController;
  final key1 = GlobalKey();

  @override
  void initState() {
    super.initState();
    Provider.of<CourseContentProvider>(context, listen: false).reset();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await showVideoPlayer(context);
    });
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
                    child: backButton("Back"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Container(
                          key: key1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: 200,
                          child: content.showVideo
                              ? content.isVideo && _controller != null
                                  ? _controller!.videoPlayerController.value
                                          .isInitialized
                                      ? Chewie(controller: _controller!)
                                      : PreviewContainer(
                                          image: widget.course.imageId)
                                  : content.isYoutube && _ytController != null
                                      ? YoutubePlayer(
                                          controller: _ytController,
                                          showVideoProgressIndicator: true,
                                          progressColors:
                                              const ProgressBarColors(
                                            playedColor: backgroundBlurColor,
                                            handleColor: white,
                                          ),
                                        )
                                      : PreviewContainer(
                                          image: widget.course.imageId)
                              : PreviewContainer(
                                  image: widget.course.imageId,
                                  loaded: false,
                                  onTap: () {
                                    content.onPreviewClick();
                                  },
                                )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: size.width * 0.6,
                          child: titleText(widget.course.title ?? "")),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: success100,
                            borderRadius: BorderRadius.circular(20)),
                        child: titleAmountText(widget.course.salePrice ?? ""),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      contentOwnerText("John Doe", () {}),
                      const SizedBox(width: 5),
                      Row(
                        children: getStarList(
                            "4", ImagePath.starFill, ImagePath.starUnfill,
                            size: 12),
                      ),
                      const SizedBox(width: 5),
                      ratingText("4")
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      benefitText("3 total hours video", Icons.play_circle),
                      const SizedBox(width: 15),
                      benefitText("Resource files", Icons.assessment)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      benefitText(
                          "Certificate of Completion", Icons.leaderboard),
                      const SizedBox(width: 15),
                      benefitText("Lifetime access", Icons.all_inclusive)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Html(
                      data: widget.course.content,
                      shrinkWrap: true,
                      style: {
                        "h4": Style(
                            margin: Margins.only(
                                bottom: 0, top: 10, unit: Unit.px)),
                        "p": Style(
                            margin: Margins.only(
                                top: -10, bottom: 0, unit: Unit.px),
                            lineHeight: const LineHeight(0, units: "px"),
                            fontSize: FontSize(10)),
                        "p , ul": Style(
                          lineHeight: const LineHeight(2, units: "px"),
                          fontSize: FontSize(9),
                        ),
                        "li": Style(
                          lineHeight: const LineHeight(0, units: "px"),
                          fontSize: FontSize(10),
                        ),
                        "cs_course_syslebus2": Style(fontSize: FontSize(8))
                      },
                    ),
                  ),
                  headerText("Course Content"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: skipColor,
                      thickness: 0.7,
                    ),
                  ),
                  ListView.builder(
                    itemCount: widget.course.lessons!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (content.selectedLesson.length <
                          widget.course.lessons!.length) {
                        content.selectedLesson.add(false);
                      }
                      return LessonCard(
                          index: index,
                          onPlayTap: () async {
                            await updateVideoController(widget
                                    .course.lessons![index].url ??
                                "https://www.youtube.com/watch?v=tO01J-M3g0U");
                            Scrollable.ensureVisible(key1.currentContext!,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          },
                          onLessonTap: () {
                            content.setSelectedLesson(index);
                          },
                          lesson: widget.course.lessons![index]);
                    },
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerText("Student Testimonials"),
                      const SizedBox(height: 5),
                      totalStudentText(5423),
                      const SizedBox(height: 10),
                      ListView.builder(
                          itemCount: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return const TestimonyCard();
                          })
                    ],
                  ),
                  const SizedBox(height: 20),
                  bigAmountText("NGN 5,000.00"),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: BlackButtonWidget(
                        onPressed: () {},
                        child: buttonText("Enroll Now", nextColor)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: size.width * 0.45,
                        child: WhiteButtonWidget(
                            onPressed: () {},
                            child: buttonText("Add to Cart", skipColor)),
                      ),
                      SizedBox(
                        height: 60,
                        width: size.width * 0.45,
                        child: WhiteButtonWidget(
                            onPressed: () {},
                            child: buttonText("Add to WishList", skipColor)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future updateVideoController(String vidUrl) async {
    if (vidUrl.toLowerCase().contains("youtube.com")) {
      List vidId =
          vidUrl.contains("?v=") ? vidUrl.split("?v=") : vidUrl.split("/");
      print("vidId====>${vidId[vidId.length - 1]}");
      setState(() {
        Provider.of<CourseContentProvider>(context, listen: false)
            .onPreviewClick();
        _ytController = YoutubePlayerController(
          initialVideoId:
              YoutubePlayer.convertUrlToId(vidUrl) ?? vidId[vidId.length - 1],
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
      });
    } else {
      Provider.of<CourseContentProvider>(context, listen: false)
          .onPreviewClick();
      videoPlayerController = VideoPlayerController.network(vidUrl);
      await Future.wait([videoPlayerController.initialize()]);
      _controller = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
      );
      setState(() {});
    }
  }

  Future<void> youtubePlayer() async {
    List vidId = widget.course.video!.split("/");
    _ytController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.course.video!) ??
          vidId[vidId.length - 1],
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  Future<void> loadVideoPlayer() async {
    videoPlayerController =
        VideoPlayerController.network(widget.course.video ?? "");
    await Future.wait([videoPlayerController.initialize()]);
    _controller = ChewieController(
      videoPlayerController: videoPlayerController,
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

  Future showVideoPlayer(context) async {
    if (widget.course.video!.toLowerCase().contains("youtube.com")) {
      Provider.of<CourseContentProvider>(context, listen: false).youtubeVid =
          true;
      await youtubePlayer();
      if (mounted) setState(() {});
    } else if (widget.course.video!.toLowerCase().contains(".mp4")) {
      Provider.of<CourseContentProvider>(context, listen: false).video = true;
      await loadVideoPlayer();
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    _controller!.dispose();
    _ytController.dispose();
  }
}
