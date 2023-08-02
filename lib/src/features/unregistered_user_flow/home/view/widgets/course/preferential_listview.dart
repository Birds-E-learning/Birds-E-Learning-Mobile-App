import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view/widgets/custom_shimmer_card.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view_model/course_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/custom_widgets/course_card.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreferentialListView extends StatelessWidget {
  const PreferentialListView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey topKey = GlobalKey();
    Size size = MediaQuery.of(context).size;
    return Consumer<UnregisteredCourseProvider>(
      builder: (_, course, __) => SizedBox(
        height: 190,
        child: course.prefCourses.isEmpty && course.prefStatus == Status.loading
            ? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return const UnregisteredCustomHomeCardShimmer();
                })
            : course.prefCourses.isEmpty && course.prefStatus != Status.loading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "No Preferential Course available for you, ",
                        style: CartStyles.richStyle1,
                      ),
                    ),
                  )
                : ListView.separated(
                    key: topKey,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemCount: course.prefCourses.length > 10
                        ? 10
                        : course.prefCourses.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return UnregisteredCourseCard(
                        course: course.prefCourses[index],
                      );
                    }),
      ),
    );
  }
}
