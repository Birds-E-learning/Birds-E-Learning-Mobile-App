import 'package:birds_learning_network/src/features/modules/profile/view_model/change_password_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:birds_learning_network/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    with ProfileWidgets, InputValidators {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ChangePasswordProvider>(
      builder: (_, password, __) => BackgroundWidget(
        appBar: SliverAppBar(
            centerTitle: true,
            pinned: true,
            floating: true,
            elevation: 0,
            title: appBarText(ProfileTexts.changePassword),
            leading: leadingIcon(context)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.05, horizontal: size.width * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: oldPassword,
                  labelText: ProfileTexts.oldText,
                  maxLines: 1,
                  filled: true,
                  obscureText: !password.showOldPassword,
                  validator: (value) => passwordValidator(value),
                  suffixIcon: passwordVisibility(
                      () => password.onOldPasswordClick(),
                      password.showOldPassword),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: newPassword,
                  labelText: ProfileTexts.newText,
                  maxLines: 1,
                  obscureText: !password.showNewPassword,
                  filled: true,
                  validator: (value) =>
                      newPasswordValidator(value, oldPassword.text.trim()),
                  suffixIcon: passwordVisibility(
                      () => password.onNewPasswordClick(),
                      password.showNewPassword),
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: confirmPassword,
                  labelText: ProfileTexts.confirmText,
                  maxLines: 1,
                  obscureText: !password.showConfirmPassword,
                  filled: true,
                  validator: (value) =>
                      confirmPasswordValidator(value, newPassword.text.trim()),
                  suffixIcon: passwordVisibility(
                      () => password.onConfirmPasswordClick(),
                      password.showConfirmPassword),
                ),
                SizedBox(height: size.height * 0.2),
                SizedBox(
                  width: double.infinity,
                  child: BlackButtonWidget(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (password.updateClicked) {
                          password.onUpdateClick();
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          password.onUpdateClick();
                          await password.changeUserPassword(context,
                              oldPassword.text.trim(), newPassword.text.trim());
                        }
                      },
                      child: password.updateClicked
                          ? loadingIdicator()
                          : buttonText(ProfileTexts.updateText)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
