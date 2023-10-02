import 'package:birds_learning_network/src/features/modules/home/view/widgets/home_course/testimony_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/more_card_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/course_content_provider.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/content_mixins.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseReviewWidget extends StatelessWidget with HomeWidgets, ContentWidget{
  const CourseReviewWidget({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseContentProvider>(
      builder: (_, ref, __) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerText("Student Testimonials"),
                InkWell(
                  onTap: ()async{
                    ref.onReviewClicked();
                    if(ref.reviewClicked){
                      await ref.getReviewMethod(context, courseId);
                    }
                  },
                  child: !ref.reviewClicked ? const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: black, size: 40,) :
                  const Icon(
                    Icons.keyboard_arrow_up_outlined,
                    color: black, size: 40,)
                )
              ],
            ),
            SizedBox(
              child: ref.reviewClicked ?
              Container(
                child: ref.reviews.isEmpty
                ? ref.reviewStatus == Status.loading
                    ? ListView.separated(
                      separatorBuilder: (_,__) => const SizedBox(height: 10),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, int index) {
                        return const MoreCardsShimmer();
                      },
                    )
                    : const Center(
                  child: Text("No available review for this course",
                    style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500
                    ),
                  ),
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    totalStudentText(ref.reviewers ?? 0),
                    const SizedBox(height: 10),
                    ListView.builder(
                        itemCount: ref.reviews.length > 12 ? 12 : ref.reviews.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return  TestimonyCard(review: ref.reviews[index],);
                        })
                  ],
                ),
              ) : null,
            ),
          ],
        );
      }
    );
  }
}
