import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/features/core/auth/view/login/sign_in.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/repository/profile_repository.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/request_model/update_profile_model.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/contact_model.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/user_profile_response.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/user_details.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/success_dialog.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String? _countryCode;
  dynamic _gender;
  bool _doneClicked = false;
  bool _isClicked = false;
  ProfileRepository repo = ProfileRepository();
  UserSecureStorage storage = UserSecureStorage();
  Status contactStatus = Status.initial;
  ContactData? contact;

  dynamic get gender => _gender;
  bool get doneClicked => _doneClicked;
  bool get isClicked => _isClicked;
  set setGender(value) {
    _gender = value;
    notifyListeners();
  }

  String get countryCode => _countryCode ?? "000";

  void getCountryCode(code) {
    _countryCode = code;
    notifyListeners();
  }

  void setContactStatus({Status status = Status.initial}){
    contactStatus = status;
    notifyListeners();
  }

  void onLogoutClicked() {
    _isClicked = !_isClicked;
    notifyListeners();
  }

  void onDoneClick() {
    _doneClicked = !_doneClicked;
    notifyListeners();
  }

  void getGender(gender_) {
    _gender = gender_;
    notifyListeners();
  }

  Future<LoginResponse> getUserData() async {
    LoginResponse data = await UserSecureStorage().getUserData();
    return data;
  }

  Future userLogout(context) async {
    try {
      onLogoutClicked();
      notifyListeners();
      var response = await repo.logOutUser(context);
      if (response["responseCode"] == "00") {
        RoutingService.pushAndRemoveAllRoute(context, const LoginScreen());
        isClicked ? onLogoutClicked() : null;
      } else {
        Navigator.pop(context);
        showSnack(context, "=02", response["responseMessage"]);
        isClicked ? onLogoutClicked() : null;
      }
    } catch (e) {
      isClicked ? onLogoutClicked() : null;
    }
    notifyListeners();
  }

  Future updateUserProfile(context, UpdateProfileModel data) async {
    try {
      UpdateProfileResponse? response = await repo.updateUser(context, data);
      if(response != null){
        if (response.responseCode == "00") {
          LoginResponse? loginResponse = await repo.getSingleUser(context, data.emailAddress!);
          doneClicked ? onDoneClick() : null;
          if(loginResponse != null){
            if (loginResponse.responseCode == "00") {
              // print(loginResponse.responseData?.toJson());
              successDialog(
                  context, "Successful", "Profile Successfully Updated", "OK", () {
                RoutingService.popRouting(context);
                RoutingService.popRouting(context);
              });
              await UserPreferences.setUserFirstName(
                  loginResponse.responseData!.firstName!);
              await UserPreferences.setUserEmail(
                  response.responseData!.newEmail ?? "");
              await storage.setUserData(loginResponse);
            } else {
              showSnack(context, loginResponse.responseCode!,
                  loginResponse.responseMessage!);
            }
          } else {
            doneClicked ? onDoneClick() : null;
            showSnack(context, response.responseCode!, response.responseMessage!);
          }
        }
      }else{
        doneClicked ? onDoneClick() : null;
        showSnack(context, "02", "Profile update failed!.");
      }
    } catch (e) {
      doneClicked ? onDoneClick() : null;
    }
  }

  Future contactDetailsMethod(context)async{
    try{
      setContactStatus(status: Status.loading);
      ContactData? response = await repo.contactDetailsRepo(context);
      setContactStatus(status: Status.completed);
      if(response != null){
        contact = response;
        notifyListeners();
      }
    }catch(e){
      setContactStatus(status: Status.error);
      return;
    }
  }
}
