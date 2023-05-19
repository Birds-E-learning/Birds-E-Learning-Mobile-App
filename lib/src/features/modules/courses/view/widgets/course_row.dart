import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/view_course/view_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/facilitator.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/facilitator_provider.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/course_data.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CourseRowWidget extends StatefulWidget {
  const CourseRowWidget(
      {super.key, required this.course, required this.percentage});
  final double percentage;
  final Courses course;

  @override
  State<CourseRowWidget> createState() => _CourseRowWidgetState();
}

class _CourseRowWidgetState extends State<CourseRowWidget> {
  @override
  void initState() {
    widget.course.sections = <Sections>[];
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getCourseSection(context, widget.course.id.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        RoutingService.pushRouting(
            context,
            ViewCourseScreen(
              course: widget.course,
            ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: widget.course.imageUrl!.isEmpty
                        ? Image.asset(
                            ImagePath.thumbnail,
                            fit: BoxFit.fitHeight,
                          ).image
                        : Image.network(widget.course.imageUrl ?? "").image)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.92 - 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.course.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      color: black),
                ),
                InkWell(
                  onTap: () {
                    context.read<FacilitatorProvider>().getFacilitatorData(
                        context, widget.course.facilitator!.id!.toString());
                    RoutingService.pushRouting(
                        context, const FacilitatorScreen());
                  },
                  child: Text(
                    widget.course.facilitator!.name ?? "",
                    style: const TextStyle(
                        fontSize: 10,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        color: greys200),
                  ),
                )
              ],
            ),
          ),
          widget.percentage.toString() == "0.0" ||
                  widget.percentage.toString() == "0"
              ? const Text(
                  "Start",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      color: success600),
                )
              : CircularProgressIndicator(
                  value: widget.percentage,
                  color: success600,
                )
        ],
      ),
    );
  }

  Future getCourseSection(context, String id) async {
    var response = await Provider.of<CartProvider>(context, listen: false)
        .getCourseSection(context, id);
    if (response != null) {
      List<Sections> sections = response;
      widget.course.sections = sections;
      await CoursePreference.saveCourseById(widget.course);
    }
  }
}
