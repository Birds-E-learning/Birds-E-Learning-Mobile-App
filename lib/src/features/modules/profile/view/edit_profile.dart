import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/request_model/update_profile_model.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/profile_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/drop_down.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/phone_drop_down.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/image_picker.dart';
import 'package:birds_learning_network/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with ProfileWidgets, InputValidators {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController gender = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String photoLink = "";

  dynamic gender_;
  XFile? _pickedImg;

  @override
  void initState() {
    setUser();
    super.initState();
  }

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    phone.dispose();
    gender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ProfileProvider>(
      builder: (_, profile, __) => BackgroundWidget(
        appBar: SliverAppBar(
          centerTitle: true,
          pinned: true,
          floating: true,
          elevation: 0,
          backgroundColor: backgroundBlurColor,
          title: appBarText(ProfileTexts.editProfile),
          leading: leadingIcon(context),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      profilePicture(photoLink, _pickedImg),
                      Positioned(
                        bottom: 0,
                        right: 3,
                        child: InkWell(
                          onTap: () =>
                              ImageUpload().uploadImage(context, (pickedImage) {
                            setState(() {
                              _pickedImg = pickedImage;
                              photoLink = "";
                            });
                          }),
                          child: cameraAvatar(),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                editHeaderText(),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: fullName,
                  labelText: ProfileTexts.fullName,
                  filled: true,
                  hintText: "John Doe",
                  validator: (value) => nameValidator(value, "Full"),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: email,
                  labelText: ProfileTexts.emailAddress,
                  filled: true,
                  hintText: ProfileTexts.emailHint,
                  validator: (value) => emailValidator(value),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  prefix: PhoneDropDown(
                    onSelect: (code) => profile.getCountryCode(code.phoneCode),
                    data: "+${profile.countryCode}",
                  ),
                  controller: phone,
                  filled: true,
                  labelText: ProfileTexts.phoneNumber,
                  hintText: "1234 567 890",
                  keyboardType: TextInputType.number,
                  validator: (value) => numberValidator(value),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: gender,
                  readOnly: true,
                  filled: true,
                  hintText: "Select Gender",
                  labelText: ProfileTexts.genderText,
                  suffixIcon: DropDownCustom(
                    value: gender_,
                    hint: "Select Gender",
                    items: const ["Male", "Female", "Others"],
                    onChanged: (value) {
                      setState(() {
                        gender.text = gender_ = value!;
                      });
                      // profile.getGender(value);
                    },
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: BlackButtonWidget(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (profile.doneClicked) {
                          profile.onDoneClick();
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          profile.onDoneClick();
                          UpdateProfileModel data = UpdateProfileModel(
                              fullName: fullName.text.trim(),
                              emailAddress: email.text.trim(),
                              mobileNumber: getNumber(
                                  profile.countryCode, phone.text.trim()),
                              gender: gender_);
                          await profile.updateUserProfile(context, data);
                        }
                      },
                      child: profile.doneClicked
                          ? loadingIdicator()
                          : buttonText(ProfileTexts.doneText)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setUser() async {
    LoginResponse user =
        await Provider.of<ProfileProvider>(context, listen: false)
            .getUserData();
    setState(() {
      email.text = user.responseData!.email ?? "";
      fullName.text = user.responseData!.fullName ??
          "${user.responseData!.firstName} ${user.responseData!.lastName}";
      phone.text = user.responseData!.mobileNumber ?? "";
      gender.text = user.responseData!.gender ?? "";
      photoLink = user.responseData!.photoLink ?? "";
      // gender_ = user.responseData!.gender;
    });
  }

  String getNumber(String code, String phone) {
    if (code == phone.substring(1, code.length + 1)) {
      return phone;
    } else {
      return "$code$phone";
    }
  }
}
