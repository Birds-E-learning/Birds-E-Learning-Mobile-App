import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/more_card_shimmer.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/custom_widgets/html_page.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view/widgets/facilitator/facilitator_course_card.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/facilitator_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnregisteredFacilitatorScreen extends StatelessWidget with FacilitatorMixin {
  const UnregisteredFacilitatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isLandscape = size.width > size.height || size.width > 600;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: leadingIcon(context),
        elevation: 0,
      ),
      body: Consumer<UnregisteredHomeProvider>(
        builder: (_, facilitator, __) => SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: !isLandscape ? Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: profilePicture(facilitator.facilitatorData.imageUrl ?? "")),
                      const SizedBox(height: 10),
                      nameText("${facilitator.facilitatorData.firstName ?? "John"} ${facilitator.facilitatorData.lastName ?? "Doe"}"),
                      labelText(facilitator.facilitatorData.emailAddress ?? "johndoe@birdsnetwork.com"),
                      const SizedBox(height: 15)
                    ],
                  ),
                  const Expanded(
                    child: SingleChildScrollView(
                      child: FacilitatorBody(),
                    ),
                  )
                ],
              ) : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: profilePicture(facilitator.facilitatorData.imageUrl ?? "")),
                    const SizedBox(height: 10),
                    nameText("${facilitator.facilitatorData.firstName ?? "John"} ${facilitator.facilitatorData.lastName ?? "Doe"}"),
                    labelText(facilitator.facilitatorData.emailAddress ?? "johndoe@birdsnetwork.com"),
                    const SizedBox(height: 15),
                    const FacilitatorBody()
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class FacilitatorBody extends StatelessWidget with FacilitatorMixin {
  const FacilitatorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnregisteredHomeProvider>(
      builder: (_, facilitator, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleCard("About Me"),
              const SizedBox(height: 10),
              // labelText(facilitator.aboutMe)
              HTMLPageScreen(
                content: facilitator.facilitatorData.aboutMe ?? "",
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              cardText(
                  "Total Courses", facilitator.facilitatorData.numberOfCourses.toString()),
              cardText("Avg. Rating", facilitator.facilitatorData.averageRating.toString()),
              cardText("No. of Students", facilitator.facilitatorData.numberOfStudents.toString()),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleCard("Courses"),
              const SizedBox(height: 15),
              facilitator.courseList.isEmpty
                  ? facilitator.loadingStatus == Status.loading
                  ?  ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, int index) {
                    return const MoreCardsShimmer();
                  })
                  : const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "No course available for this facilitator.",
                    style: CartStyles.richStyle1,
                  ),
                ),
              )
                  : ListView.separated(
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.5),
                    child: Divider(
                      color: success1000,
                      thickness: 0.2,
                    ),
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: facilitator.courseList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    facilitator.courseList[index].facilitator =
                        Facilitator();
                    facilitator.courseList[index].facilitator!.name =
                    "${facilitator.facilitatorData.firstName} ${facilitator.facilitatorData.lastName}";
                    facilitator.courseList[index].facilitator!
                        .ratings = "${facilitator.facilitatorData.averageRating}";
                    return FacilitatorCourseCards(
                        course: facilitator.courseList[index]);
                  }),
            ],
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

