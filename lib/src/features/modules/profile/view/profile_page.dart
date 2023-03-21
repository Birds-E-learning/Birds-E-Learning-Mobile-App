import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/course_screen.dart';
import 'package:birds_learning_network/src/features/modules/profile/custom_widgets/pages_row.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/cards/card_setting.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/change_password.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/contact_us.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/edit_profile.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/preferences_screen.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/widgets/profile_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/profile_provider.dart';
import 'package:birds_learning_network/src/global_model/repositories/url_launcher.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/user_details.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with ProfileWidgets, ProfileTexts {
  String fullName = "John Doe";
  String email = "john.doe@gmail.com";
  String photoLink = "";
  bool received = false;
  bool isLoading = true;

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundWidget(
      appBar: SliverAppBar(
        title: appBarText(ProfileTexts.profileAppBar),
        centerTitle: true,
        pinned: true,
        floating: true,
        elevation: 0,
        backgroundColor: backgroundBlurColor,
      ),
      child: Consumer<ProfileProvider>(
        builder: (_, profile, __) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isLoading
                      ? const ProfilePictureShimmer()
                      : profilePicture(photoLink, null),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userNameText(fullName),
                        const SizedBox(height: 5),
                        emailText(email),
                        const SizedBox(height: 10),
                        editProfileText(() =>
                            RoutingService.pushFullScreenRouting(
                                context, const EditProfilePage()))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomPageRow(
                      icon: ImagePath.lock,
                      text: ProfileTexts.changePassword,
                      onTap: () {
                        RoutingService.pushFullScreenRouting(
                            context, const ChangePasswordPage());
                      }),
                  const SizedBox(height: 25),
                  CustomPageRow(
                      icon: ImagePath.profileCourse,
                      text: ProfileTexts.myCourses,
                      onTap: () {
                        RoutingService.pushFullScreenRouting(
                            context, const MyCoursesPage());
                      }),
                  const SizedBox(height: 25),
                  CustomPageRow(
                      icon: ImagePath.certificate,
                      text: ProfileTexts.certificate,
                      onTap: () {}),
                  const SizedBox(height: 25),
                  CustomPageRow(
                      icon: ImagePath.card,
                      text: ProfileTexts.cardSetting,
                      onTap: () {
                        RoutingService.pushFullScreenRouting(
                            context, const CardSettingPage());
                      }),
                  const SizedBox(height: 25),
                  CustomPageRow(
                      icon: ImagePath.preferences,
                      text: ProfileTexts.preferences,
                      onTap: () {
                        RoutingService.pushFullScreenRouting(
                            context, const EditPreferenceScreen());
                      }),
                  const SizedBox(height: 25),
                  CustomPageRow(
                      icon: ImagePath.contact,
                      text: ProfileTexts.contactText,
                      onTap: () {
                        RoutingService.pushFullScreenRouting(
                            context, const ContactPage());
                      })
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 25, bottom: 15),
                child: Divider(
                  thickness: 0.5,
                  color: success1000,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomPageRow(
                      icon: ImagePath.terms,
                      text: ProfileTexts.termsText,
                      onTap: () => UrlLauncher().urlLauncher(
                          "https://blns.dgtechltd.com/public/page/term-of-service",
                          context)),
                  const SizedBox(height: 25),
                  CustomPageRow(
                      icon: ImagePath.privacy,
                      text: ProfileTexts.privacyText,
                      onTap: () => UrlLauncher().urlLauncher(
                          "https://blns.dgtechltd.com/page/privacy-policy",
                          context)),
                ],
              ),
              const SizedBox(height: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  logoutRow(() => logoutDialog(context, () async {
                        await profile.userLogout(context);
                      })),
                  const SizedBox(height: 15),
                  versionText()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void getUserDetails() async {
    LoginResponse user = await UserSecureStorage().getUserData();
    String picUrl = await UserPreferences.getUserPhoto();
    setState(() {
      fullName = user.responseData!.fullName ??
          "${user.responseData!.firstName} ${user.responseData!.lastName}";
      email = user.responseData!.email ?? "john.doe@gmail.com";
      photoLink = user.responseData!.photoLink ==
                  "https://birds-e-learning.herokuapp.com/img/profile.png" &&
              picUrl != ""
          ? picUrl
          : user.responseData!.photoLink!;
      isLoading = false;
      received = photoLink == "" ? false : true;
    });
  }
}
