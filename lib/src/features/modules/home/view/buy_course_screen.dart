import 'dart:io';

import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses_pref.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/preview_container.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/section_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/course_content_provider.dart';
import 'package:birds_learning_network/src/features/modules/payment/view/screens/payment_screen.dart';
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
  final Courses course;

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
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Provider.of<CourseContentProvider>(context, listen: false).reset();
      await showVideoPlayer(context, widget.course.video!);
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
                    child: Icon(Platform.isAndroid
                        ? Icons.arrow_back
                        : Icons.arrow_back_ios),
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
                                          image: widget.course.imageUrl)
                                  : content.isYoutube
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
                      contentOwnerText(
                          widget.course.facilitator!.name == ""
                              ? "Anonymous"
                              : widget.course.facilitator!.name!,
                          () {}),
                      const SizedBox(width: 5),
                      Row(
                        children: getStarList(
                            widget.course.facilitator!.ratings ?? 0,
                            ImagePath.starFill,
                            ImagePath.starUnfill,
                            size: 12),
                      ),
                      const SizedBox(width: 5),
                      ratingText(widget.course.facilitator!.reviews.toString())
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      benefitText(
                          "${widget.course.duration} total minutes video",
                          Icons.play_circle),
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
                        "body": Style(
                            margin: Margins.zero,
                            fontSize: FontSize(14, Unit.px),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Inter"),
                        "h4": Style(
                            color: greys900,
                            fontSize: FontSize(18),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            margin:
                                Margins.only(bottom: 5, top: 5, unit: Unit.px)),
                        "p": Style(
                            margin:
                                Margins.only(top: 0, bottom: 0, unit: Unit.px),
                            lineHeight: const LineHeight(0, units: "px"),
                            fontSize: FontSize(14),
                            color: deepBlack,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                        "ul": Style(
                            fontSize: FontSize(14),
                            display: Display.inline,
                            fontFamily: "Inter",
                            margin: Margins.all(0, unit: Unit.px)),
                        "li": Style(
                          lineHeight: const LineHeight(0, units: "px"),
                          fontSize: FontSize(14),
                          fontFamily: "Inter",
                          margin: Margins.all(0, unit: Unit.px),
                        ),
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  headerText("Course Content"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: success400,
                      thickness: 0.7,
                    ),
                  ),
                  ListView.builder(
                    itemCount: widget.course.sections!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (content.selectedLesson.length <
                          widget.course.sections![0].lessons!.length) {
                        content.selectedLesson.add(false);
                      }
                      return SectionCard(
                          index: index,
                          onPlayTap: () async {
                            await showVideoPlayer(
                                context,
                                widget.course.sections![0].lessons![index]
                                        .url ??
                                    "https://www.youtube.com/watch?v=tO01J-M3g0U");
                            Scrollable.ensureVisible(key1.currentContext!,
                                duration: const Duration(milliseconds: 500),
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
                  bigAmountText(widget.course.salePrice ?? "5,000.00"),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: BlackButtonWidget(
                        onPressed: () => RoutingService.pushRouting(
                            context, const PaymentScreen()),
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
    videoPlayerController = VideoPlayerController.network(vidUrl);
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
    super.dispose();
    videoPlayerController.dispose();
    _controller!.dispose();
    _ytController.dispose();
  }
}
