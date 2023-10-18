import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CertificateScreen extends StatelessWidget with ProfileWidgets {
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: appBarText(ProfileTexts.certificate),
        centerTitle: true,
        leading: leadingIcon(context),
        elevation: 0,
        backgroundColor: white,
      ),
      body: LayoutBuilder(
        builder: (_, constraints) => SafeArea(
            child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImagePath.certImage,
                      height: 254,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 30),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Your certificates will show up here when you finish a course.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Inter",
                              color: deepBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
