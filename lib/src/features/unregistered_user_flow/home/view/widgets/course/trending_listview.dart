import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view/widgets/custom_shimmer_card.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view_model/course_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/custom_widgets/course_card.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnregisteredTrendingListView extends StatelessWidget {
  const UnregisteredTrendingListView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey trendingKey = GlobalKey();
    Size size = MediaQuery.of(context).size;
    return Consumer<UnregisteredCourseProvider>(
      builder: (_, course, __) => SizedBox(
        height: 190,
        child: course.trendingCourses.isEmpty && course.trendingStatus == Status.loading
            ? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return const UnregisteredCustomHomeCardShimmer();
                })
            : course.trendingCourses.isEmpty && course.trendingStatus != Status.loading
                ? const Center(
                    child: Text(
                      "No available trending courses.",
                      style: CartStyles.richStyle1,
                    ),
                  )
                : ListView.separated(
                    key: trendingKey,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemCount: course.trendingCourses.length > 10
                        ? 10
                        : course.trendingCourses.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {

                      return UnregisteredCourseCard(
                        course: course.trendingCourses[index],
                      );
                    }),
      ),
    );
  }
}
