import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/request_model/add_card_model.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/request_model/change_password_model.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/request_model/update_profile_model.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/add_card_response.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/change_password_response.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/contact_model.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/delete_card_response.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/get_card_response.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/user_profile_response.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/card_provider.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/change_password_provider.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:provider/provider.dart';

class ProfileRepository extends NetworkService with BaseHeaders, BaseUrl {
  Future changePasswordRepo(context, ChangePasswordModel data) async {
    Map<String, String> header_ = await authHeader();
    var json =
        await postRequest(changePassword, header_, data.toJson(), context);
    ChangePasswordResponse response = ChangePasswordResponse.fromJson(json);
    if (response.responseCode == "00") {
      return response.responseCode;
    } else {
      Provider.of<ChangePasswordProvider>(context, listen: false).updateClicked
          ? Provider.of<ChangePasswordProvider>(context, listen: false)
              .onUpdateClick()
          : null;
      showSnack(context, response.responseCode!, response.responseMessage!);
    }
  }

  Future addUserCardDetails(context, AddCardModel data) async {
    Map<String, String> header_ = await authHeader();
    var json = await postRequest(addCardLink, header_, data.toJson(), context);
    AddCardResponse response = AddCardResponse.fromJson(json);
    if (response.responseCode == "00") {
      return response.responseCode;
    } else {
      Provider.of<CardProvider>(context, listen: false).addClicked
          ? Provider.of<CardProvider>(context, listen: false).onAddClick()
          : null;
      showSnack(context, response.responseCode!, response.responseMessage!);
    }
  }

  Future getAlllDebitCard(context) async {
    Map<String, String> header_ = await authHeader();
    var json = await getRequest(getDebitCards, header_, context);
    GetDebitCardResponse response = GetDebitCardResponse.fromJson(json);
    if (response.responseCode == "00") {
      return response.responseData;
    }
  }

  Future logOutUser(context) async {
    Map<String, String> header_ = await authHeader();
    var json = await getRequest(logout, header_, context);
    return json;
  }

  Future updateUser(context, UpdateProfileModel data) async {
    Map<String, String> header_ = await authHeader();
    var json =
        await postRequest(updateProfile, header_, data.toJson(), context);
    UpdateProfileResponse response = UpdateProfileResponse.fromJson(json);
    return response;
  }

  Future getSingleUser(context, String email) async {
    // Map<String, String> header_ = await authHeader();
    var json = await getRequest("$singleUserDetail$email", header, context);
    LoginResponse response = LoginResponse.fromJson(json);
    return response;
  }

  Future deleteDebitCard(context, String cardNo) async {
    Map<String, String> header_ = await authHeader();
    var json = await deleteRequest("$deleteCardLink$cardNo", header_, context);
    DeleteCardResponse response = DeleteCardResponse.fromJson(json);
    return response;
  }

  Future contactDetailsRepo(context)async{
    try{
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(contactUrl, header_, context);
      if(json != null){
        ContactDetailsModel response = ContactDetailsModel.fromJson(json);
        if(response.responseCode == "00" || response.responseCode == "000"){
          return response.responseData;
        }else{
          showSnack(context, response.responseCode!, response.responseMessage ?? "unable to load data");
        }
      }
      return null;
    }catch(e){
      return null;
    }
  }
}
