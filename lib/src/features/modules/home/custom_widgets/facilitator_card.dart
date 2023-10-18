import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/screens/facilitator.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';

class FacilitatorCard extends StatelessWidget with HomeWidgets {
  const FacilitatorCard({super.key, required this.facilitator});
  final Facilitator facilitator;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RoutingService.pushRouting(context, FacilitatorScreen(
          facilitatorId: facilitator.id ?? "0",
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: success100,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: Image.network(facilitator.imageUrl ??
                              "https://birds-e-learning.herokuapp.com/img/profile.png")
                          .image)),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      authorNameText(facilitator.name == ""
                          ? "Anonymous"
                          : facilitator.name!),
                      const SizedBox(width: 5),
                      authorLabelText(facilitator.degree == "" ||
                              facilitator.degree == null
                          ? ""
                          : facilitator.degree!),
                      Container(
                        height: 2,
                        width: 2,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: skipColor,
                        ),
                      ),
                      authorLabelText(facilitator.skill == "" ||
                              facilitator.degree == null
                          ? ""
                          : facilitator.skill!)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      detailRowText(
                          "Ratings (${facilitator.ratings})", Icons.stars),
                      const SizedBox(width: 5),
                      detailRowText("Courses (${facilitator.courses})",
                          Icons.library_books),
                      const SizedBox(width: 5),
                      detailRowText("Students (${facilitator.students})",
                          Icons.supervisor_account),
                      const SizedBox(width: 5),
                      detailRowText(
                          "Reviews (${facilitator.reviews})", Icons.reviews)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
