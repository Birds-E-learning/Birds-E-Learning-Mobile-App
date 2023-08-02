import 'package:birds_learning_network/src/features/core/settings/model/request_model/save_preference.dart';
import 'package:birds_learning_network/src/features/core/settings/model/response_model/get_preference.dart';
import 'package:birds_learning_network/src/features/core/settings/model/response_model/save_pref_response.dart';
import 'package:birds_learning_network/src/features/core/settings/model/response_model/user_pref_response.dart';
import 'package:birds_learning_network/src/features/core/settings/view_model/filter_provider.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/user_details.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterRepository extends NetworkService with BaseHeaders, BaseUrl {
  UserSecureStorage storage = UserSecureStorage();

  Future getFilterData(context) async {
    try{
      Map<String, String> header_ = await authHeader();
      var response = await getRequest(getPref, header_, context);
      GetPreferenceModel responseData = GetPreferenceModel.fromJson(response);
      if (responseData.responseCode == "00") {
        return responseData.responseData!;
      }
      return null;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future getUserFilterData(context) async {
    Map<String, String> header_ = await authHeader();
    var response = await getRequest(getPrefUser, header_, context);
    UserPreferenceResponse responseData =
        UserPreferenceResponse.fromJson(response);
    if (responseData.responseCode == "00") {
      return responseData.responseData!.preferenceNames!;
    }
  }

  Future saveUserPreference(context, SavePreferenceModel data) async {
    Map<String, String> header_ = await authHeader();
    var json = await postRequest(savePref, header_, data.toJson(), context);
    SavePreferenceResponse responseData = SavePreferenceResponse.fromJson(json);
    if (responseData.responseCode.toString() == "00") {
      return responseData.responseCode;
    } else {
      showSnack(
          context, responseData.responseCode!, responseData.responseMessage!);
      Provider.of<FilterProvider>(context, listen: false).buttonClicked
          ? Provider.of<FilterProvider>(context, listen: false)
          : null;
      return responseData.responseCode;
    }
  }
}
