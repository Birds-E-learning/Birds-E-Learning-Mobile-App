import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/courses_mixins.dart';
import 'package:flutter/material.dart';

class AssessmentSummary extends StatelessWidget with CourseTextWidgets {
  const AssessmentSummary({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: appBarText("Assessment"),
        leading: leadingIcon(context),
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (_, constraint) => SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      quizText(title),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Divider(
                          color: grey100,
                          thickness: 0.75,
                        ),
                      ),
                      const SizedBox(height: 16),
                      assessmentRow("Pass mark", "80% or higher"),
                      const SizedBox(height: 12),
                      assessmentRow("Attempts allowed", "3"),
                      const SizedBox(height: 12),
                      assessmentRow("Attempts left", "3"),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: WhiteButtonWidget(
                            onPressed: () {},
                            child: const Text("Take Assessment",
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: skipColor))),
                      ),
                      const SizedBox(height: 40)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
