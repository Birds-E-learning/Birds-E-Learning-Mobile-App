import 'package:birds_learning_network/src/features/modules/profile/custom_widgets/custom_card_container.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/widgets/contact_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/profile_provider.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/global_model/repositories/url_launcher.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget{
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> with ProfileWidgets  {
  UrlLauncher launch = UrlLauncher();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().contactDetailsMethod(context);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ProfileProvider>();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: appBarText(ProfileTexts.contactText),
        centerTitle: true,
        leading: leadingIcon(context),
        elevation: 0,
        backgroundColor: white,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Image.asset(ImagePath.contactImage),
            const SizedBox(height: 30),
            contactLabelStyle(),
            const SizedBox(height: 50),
            watch.contactStatus != Status.loading
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardContainer(
                    image: ImagePath.outgoingMail,
                    text: ProfileTexts.emailText,
                    onTap: () => launch.emailLaunchPage(
                      watch.contact?.adminEmail, context)),
                  const SizedBox(height: 20),
                  CardContainer(
                    image: ImagePath.phoneCall,
                    text: ProfileTexts.phoneNumber,
                    onTap: () =>
                        launch.phoneLaunchPage(watch.contact?.contactPhone ?? "", context))
                      ],
                   )
             : const Column(
              children: [
                ContactShimmer(),
                SizedBox(height: 16),
                ContactShimmer()
              ],
            )
          ],
        ),
      )),
    );
  }
}
