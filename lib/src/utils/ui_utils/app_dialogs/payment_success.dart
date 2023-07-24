import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/view_course/view_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/course_data.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/profile_styles/profile_styles.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:flutter/material.dart';

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
                            await CoursePreference.saveCourseById(course!);
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
          // SizedBox(
          //   height: 50,
          //   width: double.infinity,
          //   child: TextButton(
          //       onPressed: () {
          //         RoutingService.popUntilRouteIsFirstRouting(context);
          //       },
          //       style: TextButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(4),
          //         ),
          //         backgroundColor: deepGrey,
          //         elevation: 3,
          //         shadowColor: Colors.grey[100],
          //       ),
          // child: Text(
          //   "Go to Home",
          //   style: ProfileStyles.logoutButtonStyle
          //       .copyWith(color: nextColor, fontSize: 14),
          // )),
          // ),
        ]),
  );
}
