import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/view_course/view_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/course_data.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/profile_styles/profile_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/text_style.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void getSuccessPaymentDialog(context,
    {pending = false, Courses? course}) async {
  return showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100.0,
            ),
            const SizedBox(height: 10.0),
            Text(pending ? "Payment Initiated" : "Payment Successful!",
                style: ProfileStyles.logoutHeaderStyle
                    .copyWith(color: success1000, fontSize: 18)),
            const SizedBox(height: 10),
            Text(pending
                ? "Payment has been initiated, you will be notified shortly."
                : ""),
          ],
        ),
        actions: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: pending
                ? BlackButtonWidget(
                    onPressed: () {
                      RoutingService.popUntilRouteIsFirstRouting(context);
                    },
                    child: Text(
                      "Go to Home",
                      style: ProfileStyles.logoutButtonStyle
                          .copyWith(color: nextColor, fontSize: 14),
                    ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      WhiteButtonWidget(
                          onPressed: () async {
                            await CoursePreference.saveCourseById(course!); // Saves the course in shared preference
                            RoutingService.pushAndPopUntilRouteIsFirst(
                                context, ViewCourseScreen(course: course));
                          },
                          child: Text(
                            "Start Course",
                            style: ProfileStyles.logoutButtonStyle
                                .copyWith(color: deepBlack, fontSize: 14),
                          )),
                      BlackButtonWidget(
                          onPressed: () {
                            RoutingService.popUntilRouteIsFirstRouting(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Go to Home",
                              style: ProfileStyles.logoutButtonStyle
                                  .copyWith(color: nextColor, fontSize: 14),
                            ),
                          ))
                    ],
                  ),
          ),
        ]),
  );
}

void paymentSuccessDialog(context, {Courses? course})async{
  // Size size = MediaQuery.of(context).size;
  return showModalBottomSheet(
    isScrollControlled: true,
      context: context,
      builder: (_) => Container(
      color: const Color(0xff757575),
      child: Container(
        padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
        ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 3,
                  width: 60,
                  color: grey100,
                ),
                const SizedBox(height: 25),
                SvgPicture.asset(ImagePath.paymentSuccess),
                const SizedBox(height: 30),
                const Text(
                  "Payment Successful",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: grey700,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                  fontSize: 16
                ),)
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: course != null ? SizedBox(
                    width: double.infinity,
                    child: BlackButtonWidget(
                        onPressed: ()async{
                          await CoursePreference.saveCourseById(course); // Saves the course in shared preference
                          RoutingService.pushAndPopUntilRouteIsFirst(
                              context, ViewCourseScreen(course: course));
                        }, child: Text(
                      "Start Course",
                      style: TextStyles.buttonStyle.copyWith(color: nextColor),
                    )),
                  ) : null,
                ),
                 SizedBox(height: course != null ? 16 : 0),
                SizedBox(
                  width: double.infinity,
                  child: WhiteButtonWidget(
                      onPressed: (){
                        RoutingService.popUntilRouteIsFirstRouting(context);
                      }, child: Text(
                    "Go to Home",
                    style: TextStyles.buttonStyle.copyWith(color: skipColor),
                  )),
                )
              ],
            )
          ],
        ),
      ),
    ),
  ));
}