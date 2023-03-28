import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';

class FacilitatorCard extends StatelessWidget with HomeWidgets {
  const FacilitatorCard({super.key, required this.facilitator});
  final Facilitator facilitator;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          top: 10, right: size.width * 0.04, left: size.width * 0.04),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  authorNameText(
                      facilitator.name == "" ? "Anonymous" : facilitator.name!),
                  const SizedBox(width: 5),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: authorLabelText(facilitator.degree == ""
                              ? "PhD, Design"
                              : facilitator.degree!),
                        ),
                        Container(
                          height: 2,
                          width: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: skipColor,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: authorLabelText(facilitator.skill == ""
                              ? "Graphic Designer"
                              : facilitator.skill!),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailRowText(
                      "Ratings (${facilitator.ratings})", Icons.stars),
                  const SizedBox(width: 5),
                  detailRowText(
                      "Courses (${facilitator.courses})", Icons.library_books),
                  const SizedBox(width: 5),
                  detailRowText("Students (${facilitator.students})",
                      Icons.supervisor_account),
                  const SizedBox(width: 5),
                  detailRowText(
                      "Reviews (${facilitator.reviews})", Icons.reviews)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
