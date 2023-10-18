import 'package:birds_learning_network/src/features/modules/home/custom_widgets/html_page.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/facilitator/facilitator_course_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/facilitator_screen_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/facilitator_provider.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/facilitator_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class FacilitatorScreen extends StatefulWidget {
  const FacilitatorScreen({super.key, required this.facilitatorId});
  final String facilitatorId;

  @override
  State<FacilitatorScreen> createState() => _FacilitatorScreenState();
}

class _FacilitatorScreenState extends State<FacilitatorScreen>
    with FacilitatorMixin {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FacilitatorProvider>(context, listen: false).refreshData();
      Provider.of<FacilitatorProvider>(context, listen: false).getFacilitatorData(context,
          widget.facilitatorId);
    });
    super.initState();
  }

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
      body: Consumer<FacilitatorProvider>(
        builder: (_, facilitator, __) => SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: facilitator.loadingStatus != Status.loading ?
              !isLandscape ? Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: profilePicture(
                          facilitator.facilitator != null ? "${facilitator.facilitator!.imageUrl}" : ""
                      )),
                      const SizedBox(height: 10),
                      nameText(facilitator.facilitator != null ?
                      "${facilitator.facilitator!.firstName} ${facilitator.facilitator!.lastName}": ""
                      ),
                      labelText(
                          facilitator.facilitator != null ? "${facilitator.facilitator!.emailAddress}" : ""
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                  const Expanded(
                    child: SingleChildScrollView(
                      // primary: !isLandscape,
                      // physics: isLandscape ? const NeverScrollableScrollPhysics() : null,
                      child: FacilitatorBody()
                    ),
                  ),
                ],
              ) : SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: profilePicture(
                            facilitator.facilitator != null ? "${facilitator.facilitator!.imageUrl}" : ""
                        )),
                        const SizedBox(height: 10),
                        nameText(facilitator.facilitator != null ?
                        "${facilitator.facilitator!.firstName} ${facilitator.facilitator!.lastName}": ""
                        ),
                        labelText(
                            facilitator.facilitator != null ? "${facilitator.facilitator!.emailAddress}" : ""
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    const FacilitatorBody()
                  ],
                ),
              )
                  : const FacilitatorScreenShimmer(),
            )),
      ),
    );
  }
}

class FacilitatorBody extends StatelessWidget with FacilitatorMixin {
  const FacilitatorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FacilitatorProvider>(
      builder:(_, facilitator, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleCard("About Me"),
              const SizedBox(height: 10),
              // labelText(facilitator.aboutMe)
              HTMLPageScreen(
                content: facilitator.facilitator != null ?
                "${facilitator.facilitator!.aboutMe}" : "",
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              cardText(
                  "Total Courses",
                  facilitator.facilitator != null ? "${facilitator.facilitator!.numberOfCourses}" : ""),
              cardText("Avg. Rating",
                  facilitator.facilitator != null ? "${facilitator.facilitator!.averageRating}" : ""),
              cardText("No. of Students",
                  facilitator.facilitator != null ? "${facilitator.facilitator!.numberOfStudents}": ""),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleCard("Courses"),
              const SizedBox(height: 15),
              facilitator.courseList.isEmpty
                  ?  const Center(
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
                    facilitator.courseList[index].facilitator = Facilitator();
                    facilitator.courseList[index].facilitator!.name = facilitator.facilitator != null ?
                    "${facilitator.facilitator!.firstName} ${facilitator.facilitator!.lastName}" : "";
                    facilitator.courseList[index].facilitator!.ratings = facilitator.facilitator != null ?
                    "${facilitator.facilitator!.averageRating}": "";
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

